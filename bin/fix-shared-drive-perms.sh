#!/bin/bash
# /home/dashverse/Codes/dotfiles/bin/fix-shared-drive-perms.sh
# Normalizes permissions for the shared drive to fix issues caused by 'mv' or 'umask' settings.

TARGET="/drives/internalfirst2tb"
GROUP="storage-common"

if [ ! -d "$TARGET" ]; then
    echo "Error: $TARGET not found."
    exit 1
fi

# 1. Force group ownership and root owner
chown -R root:"$GROUP" "$TARGET"

# 2. Set directory permissions: rwxrwsr-x
# (u=rwx, g=rwx + setgid, o=rx)
find "$TARGET" -type d -exec chmod 2775 {} +

# 3. Set file permissions: rw-rw-r--
# (u=rw, g=rw, o=r)
find "$TARGET" -type f -exec chmod 664 {} +

# 4. Re-apply ACLs to ensure future inheritance is clean
# Remove existing ACLs first to avoid conflicts
setfacl -R -b "$TARGET"
# Set access and default ACLs for the group
setfacl -R -m g:"$GROUP":rwx "$TARGET"
setfacl -R -d -m g:"$GROUP":rwx "$TARGET"

echo "Permissions fixed for $TARGET"
