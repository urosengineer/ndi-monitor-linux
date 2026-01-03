#!/bin/bash
# NDI Monitor for Linux - Uninstallation Script
# Copyright (c) 2026 ILURO. All rights reserved.

set -e

APP_NAME="ndi-monitor-linux"
INSTALL_DIR="/opt/$APP_NAME"
DESKTOP_FILE="/usr/share/applications/$APP_NAME.desktop"
BIN_LINK="/usr/local/bin/$APP_NAME"

echo "========================================="
echo "  NDI Monitor for Linux - Uninstaller"
echo "========================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "❌ Error: This script must be run with sudo privileges"
    echo ""
    echo "Usage:"
    echo "   sudo ./uninstall.sh"
    echo ""
    exit 1
fi

echo "🗑️  Removing NDI Monitor for Linux..."
echo ""

REMOVED_ITEMS=0

# Remove application directory
if [ -d "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR"
    echo "✅ Removed application files from $INSTALL_DIR"
    REMOVED_ITEMS=$((REMOVED_ITEMS + 1))
fi

# Remove desktop entry
if [ -f "$DESKTOP_FILE" ]; then
    rm "$DESKTOP_FILE"
    echo "✅ Removed desktop entry"
    REMOVED_ITEMS=$((REMOVED_ITEMS + 1))
fi

# Remove symlink
if [ -L "$BIN_LINK" ]; then
    rm "$BIN_LINK"
    echo "✅ Removed system command link"
    REMOVED_ITEMS=$((REMOVED_ITEMS + 1))
fi

# Update desktop database
if command -v update-desktop-database &> /dev/null; then
    update-desktop-database /usr/share/applications 2>/dev/null || true
fi

echo ""
if [ $REMOVED_ITEMS -eq 0 ]; then
    echo "ℹ️  NDI Monitor for Linux was not found on this system"
else
    echo "✅ Uninstallation completed successfully!"
    echo ""
    echo "All application files and system integrations have been removed."
fi
echo ""
