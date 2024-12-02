#!/bin/bash

# Unmount all macFUSE filesystems
mount | grep macfuse | awk '{print $3}' | while read -r mountpoint; do
  echo "Unmounting $mountpoint"
  diskutil unmount force "$mountpoint" || echo "Failed to unmount $mountpoint"
done
