#!/bin/bash

# Sync Neovim files from .dotfiles to .config
src_dir="${NVIM_SRC_DIR:-$HOME/.dotfiles/nvim}"
dest_dir="${NVIM_DEST_DIR:-$HOME/.config/nvim}"

if [[ ! -d "$src_dir" ]]; then
  echo "Error: Source directory $src_dir does not exist. Exiting."
  exit 1
fi

echo "Starting sync from $src_dir to $dest_dir..."

# Create symlinks for files in the source directory
echo "Creating/updating symlinks..."
find "$src_dir" -type f | while read -r file; do
relative_path="${file#$src_dir/}"
symlink_path="$dest_dir/$relative_path"
dest_dir_path=$(dirname "$symlink_path")

mkdir -p "$dest_dir_path"

if [[ -L "$symlink_path" ]]; then
  if [[ "$(readlink "$symlink_path")" == "$file" ]]; then
    echo "Symlink already exists and is correct: $symlink_path"
  else
    echo "Updating incorrect symlink: $symlink_path"
    rm "$symlink_path"
    ln -s "$file" "$symlink_path"
    echo "Updated symlink: $symlink_path -> $file"
  fi
elif [[ -e "$symlink_path" ]]; then
  echo "Conflict: $symlink_path exists but is not a symlink."
  backup_path="${symlink_path}.bak"
  echo "Backing up and replacing: $symlink_path -> $backup_path"
  mv "$symlink_path" "$backup_path"
  ln -s "$file" "$symlink_path"
  echo "Replaced with symlink: $symlink_path -> $file"
else
  ln -s "$file" "$symlink_path"
  echo "Symlink created: $symlink_path -> $file"
fi
done

# Remove orphaned symlinks in the destination directory
echo "Checking for orphaned symlinks in $dest_dir..."
find "$dest_dir" -type l | while read -r symlink; do
target=$(readlink "$symlink")
if [[ "$target" != "$src_dir/"* || ! -e "$target" ]]; then
  echo "Orphaned symlink found: $symlink (target: $target)"
  rm "$symlink"
  echo "Removed orphaned symlink: $symlink"
fi
done

# Remove empty directories in the destination directory
echo "Cleaning up empty directories in $dest_dir..."
find "$dest_dir" -type d -empty -delete

echo "Sync completed successfully."
