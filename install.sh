#!/bin/bash
# NDI Monitor for Linux - Installation Script
# Copyright (c) 2026 ILURO. All rights reserved.

set -e

APP_NAME="ndi-monitor-linux"
INSTALL_DIR="/opt/$APP_NAME"
DESKTOP_FILE="/usr/share/applications/$APP_NAME.desktop"
BIN_LINK="/usr/local/bin/$APP_NAME"
APP_VERSION="1.0.0"

echo "========================================="
echo "  NDI Monitor for Linux - Installer"
echo "  Version $APP_VERSION"
echo "========================================="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "❌ Error: This script must be run with sudo privileges"
    echo ""
    echo "Usage:"
    echo "   sudo ./install.sh"
    echo ""
    exit 1
fi

echo "📦 Installing NDI Monitor for Linux..."
echo ""

# Remove old installation if exists
if [ -d "$INSTALL_DIR" ]; then
    echo "🗑️  Removing previous installation..."
    rm -rf "$INSTALL_DIR"
fi

# Check if source directory exists
if [ ! -d "bin" ] || [ ! -d "lib" ]; then
    echo "❌ Error: Installation files not found in current directory"
    echo ""
    echo "Please ensure you are running this script from the extracted"
    echo "ndi-monitor-linux directory containing 'bin' and 'lib' folders."
    echo ""
    exit 1
fi

# Copy application files
echo "📋 Copying application files to $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
cp -r bin lib "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/bin/$APP_NAME"

# Create desktop entry
echo "🖥️  Creating desktop entry..."
cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=NDI Monitor
Comment=Professional NDI Source Scanner and Monitor for Linux
Exec=$INSTALL_DIR/bin/$APP_NAME
Icon=video-display
Terminal=false
Categories=AudioVideo;Video;
Keywords=NDI;Video;Streaming;Monitor;Network;Broadcast;
StartupNotify=true
EOF

chmod 644 "$DESKTOP_FILE"

# Create symlink
echo "🔗 Creating system command link..."
ln -sf "$INSTALL_DIR/bin/$APP_NAME" "$BIN_LINK"

# Update desktop database
if command -v update-desktop-database &> /dev/null; then
    echo "🔄 Updating desktop database..."
    update-desktop-database /usr/share/applications 2>/dev/null || true
fi

# Update icon cache if available
if command -v gtk-update-icon-cache &> /dev/null; then
    gtk-update-icon-cache -f -t /usr/share/icons/hicolor 2>/dev/null || true
fi

echo ""
echo "✅ Installation completed successfully!"
echo ""
echo "You can now launch the application:"
echo ""
echo "  • From terminal:"
echo "      $APP_NAME"
echo ""
echo "  • From application menu:"
echo "      Search for 'NDI Monitor' (in Video category)"
echo ""
echo "To uninstall, run: sudo ./uninstall.sh"
echo ""
