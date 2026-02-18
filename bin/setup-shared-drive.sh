#!/bin/bash

# setup-shared-drive.sh
# Automates the setup of shared storage permissions for a given mount point.

TARGET_DIR="$1"
GROUP_NAME="storage-common"

if [ -z "$TARGET_DIR" ]; then
    echo "Usage: $0 <mount_point_or_directory>"
    exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: $TARGET_DIR is not a directory."
    exit 1
fi

echo "Setting up shared permissions for $TARGET_DIR with group $GROUP_NAME..."

# Ensure group exists
if ! getent group "$GROUP_NAME" > /dev/null; then
    echo "Creating group $GROUP_NAME..."
    sudo groupadd "$GROUP_NAME"
fi

# 1. Change group ownership
echo "Changing group ownership..."
sudo chgrp -R "$GROUP_NAME" "$TARGET_DIR"

# 2. Set directory permissions (including setgid bit) and file permissions
echo "Setting permissions and setgid bit..."
sudo chmod -R u=rwX,g=rwX,o=rX "$TARGET_DIR"
sudo find "$TARGET_DIR" -type d -exec chmod g+s {} +

# 3. Set Default ACLs for inheritance
echo "Setting default ACLs for inheritance..."
sudo setfacl -R -m d:g:"$GROUP_NAME":rwx "$TARGET_DIR"
sudo setfacl -R -m g:"$GROUP_NAME":rwx "$TARGET_DIR"

echo "Done! Users in $GROUP_NAME can now share files in $TARGET_DIR."
