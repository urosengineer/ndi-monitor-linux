# NDI SDK Installation Instructions

This document provides detailed instructions for installing the NDI SDK on Linux, which is required to run NDI Monitor.

## Quick Start

1. Download NDI SDK from: https://ndi.video/for-developers/ndi-sdk/
2. Install the SDK
3. Copy `libndi.so` to `/usr/local/lib/`
4. Run `sudo ldconfig`

## Detailed Steps

### 1. Download NDI SDK

- Visit: **https://ndi.video/for-developers/ndi-sdk/**
- You'll need to create a free NDI developer account if you don't have one
- Select "Linux" as your platform
- Download the SDK installer (e.g., `InstallNDISDK_v6_Linux.tar.gz`)

### 2. Extract and Install

```bash
# Extract the archive
tar -xzf InstallNDISDK_v6_Linux.tar.gz

# Make installer executable
chmod +x InstallNDISDK_v6_Linux.sh

# Run installer
sudo ./InstallNDISDK_v6_Linux.sh
```

The installer will ask for installation location (default is `~/NDI SDK for Linux/`).

### 3. Copy Library to System Path

After installation, copy the NDI library to a system-wide location:

```bash
# Navigate to NDI SDK lib directory
cd "$HOME/NDI SDK for Linux/lib/x86_64-linux-gnu"

# Copy to system library path
sudo cp libndi.so.6* /usr/local/lib/

# Create symbolic link
sudo ln -sf /usr/local/lib/libndi.so.6 /usr/local/lib/libndi.so

# Update library cache
sudo ldconfig
```

### 4. Verify Installation

Check that the library is properly installed:

```bash
# Should show the path to libndi.so
ldconfig -p | grep libndi

# Expected output:
# libndi.so (libc6,x86-64) => /usr/local/lib/libndi.so
# libndi.so.6 (libc6,x86-64) => /usr/local/lib/libndi.so.6
```

### 5. Test NDI Monitor

Now you can install and run NDI Monitor:

```bash
cd ndi-monitor-linux
sudo ./install.sh
ndi-monitor-linux
```

## Alternative Installation Locations

If you prefer to keep NDI libraries in a custom location:

```bash
# Set LD_LIBRARY_PATH to include your custom path
export LD_LIBRARY_PATH="/path/to/ndi/lib:$LD_LIBRARY_PATH"

# Or create an environment variable
export NDI_RUNTIME_DIR="/path/to/ndi/lib"

# Run the application
ndi-monitor-linux
```

To make this permanent, add the export line to your `~/.bashrc` or `~/.profile`.

## Using NDI Tools Instead

Alternatively, you can download **NDI Tools for Linux** from https://ndi.video/tools/ which also includes the NDI runtime libraries. However, you'll still need to copy `libndi.so` to a system path as shown above.

## Troubleshooting

### "Cannot find libndi.so" error

If you see this error when starting NDI Monitor:

1. Verify the library exists:
   ```bash
   ls -l /usr/local/lib/libndi.so*
   ```

2. If not found, check your NDI SDK installation location and copy the library again

3. Run `sudo ldconfig` to update the cache

4. Try setting `LD_LIBRARY_PATH`:
   ```bash
   export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
   ```

### Permission Issues

If you get permission errors:

```bash
# Ensure proper permissions
sudo chmod 755 /usr/local/lib/libndi.so*

# Update cache with sudo
sudo ldconfig
```

### 32-bit vs 64-bit

NDI Monitor requires the **64-bit** version of NDI SDK (`x86_64-linux-gnu`). Make sure you're copying the library from the correct architecture folder.

## License Note

NDI® is a registered trademark of Vizrt NDI AB. The NDI SDK is subject to Vizrt's license terms. Please review the license agreement when downloading and installing the SDK.

NDI Monitor is not affiliated with or endorsed by Vizrt NDI AB.
