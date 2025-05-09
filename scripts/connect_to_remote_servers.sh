#!/bin/bash

# === Config ===
REMOTE_NAME="projects"  # must match SSH config alias
REMOTE_PATH="/var/www/vhosts"
LOCAL_MOUNT_BASE="$HOME/mnt"
LOG_DIR="$HOME/.dotfiles/.logs/projects"
TODAY=$(date +%F)
LOG_FILE="$LOG_DIR/$TODAY.log"
NEOVIM_CMD="+Neotree toggle"

# === Ensure log directory exists ===
mkdir -p "$LOG_DIR"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

fail() {
    log "❌ $*"
    exit 1
}

# === Check dependencies ===
command -v sshfs >/dev/null || fail "sshfs is not installed."
command -v nvim >/dev/null || fail "neovim (nvim) is not installed."

# === Get list of directories from remote ===
log "Connecting to $REMOTE_NAME to list directories..."
SITE_LIST=$(ssh "$REMOTE_NAME" "ls -1d $REMOTE_PATH/*" 2>/dev/null) || fail "Failed to list directories from remote."

# === Extract directory names only ===
SITE_NAMES=$(echo "$SITE_LIST" | sed "s|$REMOTE_PATH/||")

# === Prompt user to select a site ===
if command -v fzf >/dev/null; then
    SELECTED_SITE=$(echo "$SITE_NAMES" | fzf --prompt="Select site to mount: ") || fail "No site selected."
else
    echo "Available directories:"
    select SITE in $SITE_NAMES; do
        if [[ -n "$SITE" ]]; then
            SELECTED_SITE="$SITE"
            break
        fi
        echo "Invalid selection."
    done
fi

REMOTE_FULL_PATH="$REMOTE_PATH/$SELECTED_SITE"
LOCAL_MOUNT="$LOCAL_MOUNT_BASE/$SELECTED_SITE"

log "Selected site: $SELECTED_SITE"
log "Remote path: $REMOTE_FULL_PATH"
log "Local mount point: $LOCAL_MOUNT"

# === Check if already mounted ===
if mount | grep -q "on $LOCAL_MOUNT "; then
    log "Already mounted: $LOCAL_MOUNT"
    read -p "Do you want to re-mount it? (y/N): " RESP
    if [[ "$RESP" =~ ^[Yy]$ ]]; then
        log "Attempting to unmount existing mount..."
        umount "$LOCAL_MOUNT" || diskutil unmount "$LOCAL_MOUNT" || fail "Failed to unmount existing mount."
        rmdir "$LOCAL_MOUNT" 2>/dev/null
    else
        log "Aborting due to existing mount."
        exit 0
    fi
fi

# === Create mount point ===
mkdir -p "$LOCAL_MOUNT"

# === Mount via SSHFS ===
log "Mounting via sshfs..."
sshfs "$REMOTE_NAME:$REMOTE_FULL_PATH" "$LOCAL_MOUNT" -o reconnect,volname="$SELECTED_SITE" || fail "sshfs mount failed."

# === Define cleanup trap ===
cleanup() {
    log "Cleaning up mount: $LOCAL_MOUNT"

    if df | grep -q "$LOCAL_MOUNT"; then
        umount "$LOCAL_MOUNT" 2>/dev/null ||
        diskutil unmount force "$LOCAL_MOUNT" 2>/dev/null ||
        log "Could not unmount $LOCAL_MOUNT"
    else
        log "Nothing to unmount — $LOCAL_MOUNT not mounted."
    fi

    rmdir "$LOCAL_MOUNT" 2>/dev/null
    log "Done."
}
trap cleanup EXIT INT TERM

# === Launch Neovim ===
log "Launching Neovim..."
nvim "$NEOVIM_CMD" "$LOCAL_MOUNT"

# Trap will handle unmounting
