# NDI Monitor for Linux - Release Guide

This document contains internal notes for preparing and publishing releases.

## 📦 Building the Release Package

### Step 1: Clean Build

```bash
cd /home/uros/Projects/Frontend/iluro_studio_monitor
./gradlew clean
./gradlew createDistributable
```

### Step 2: Create Release Archive

```bash
cd build/compose/binaries/main/app
tar -czf ndi-monitor-linux-v1.0.0.tar.gz ndi-monitor-linux/
```

**What gets packaged:**
- `/bin` - Launcher scripts  
- `/lib` - All JAR files, application code, and bundled JRE
- Complete standalone application (Java runtime included)

**Note:** NDI Runtime libraries are NOT included - users must install NDI Tools for Linux separately.

### Step 3: Verify Package Contents

```bash
tar -tzf ndi-monitor-linux-v1.0.0.tar.gz | head -20
```

Should include:
- `ndi-monitor-linux/bin/ndi-monitor-linux`
- `ndi-monitor-linux/lib/app/*.jar`
- `ndi-monitor-linux/lib/runtime/` (bundled Java)

## 🧪 Testing Before Release

### Test on Clean System (VM Recommended)

1. **Extract package:**
   ```bash
   tar -xzf ndi-monitor-linux-v1.0.0.tar.gz
   cd ndi-monitor-linux
   ```

2. **Verify files:**
   ```bash
   ls -lh bin/
   ls -lh lib/app/
   ```

3. **Test installation:**
   ```bash
   sudo ./install.sh
   ```

4. **Test launch:**
   ```bash
   ndi-monitor-linux
   # Also test from application menu
   ```

5. **Test functionality:**
   - Scan for NDI sources
   - Preview a source
   - Check performance

6. **Test uninstallation:**
   ```bash
   sudo ./uninstall.sh
   ```

## 📤 Publishing to GitHub

### Step 1: Prepare Public Repository

The `public-release/` folder contains all files for the public repository:

```
public-release/
├── README.md           # Professional documentation
├── LICENSE             # Proprietary license
├── CHANGELOG.md        # Version history
├── install.sh          # Installation script
├── uninstall.sh        # Uninstallation script
└── .gitignore          # Git ignore rules
```

### Step 2: Create GitHub Repository

1. Go to https://github.com/new
2. Repository name: `ndi-monitor-linux`
3. Description: "Professional NDI Studio Monitor for Linux"
4. Visibility: Public
5. **Do NOT** initialize with README (we have our own)

### Step 3: Push Public Release Files

```bash
cd public-release/
git init
git add .
git commit -m "Initial release: v1.0.0"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/ndi-monitor-linux.git
git push -u origin main
```

### Step 4: Create GitHub Release

1. Go to repository → **Releases** → **Create a new release**

2. **Tag**: `v1.0.0`
   - Target: `main`

3. **Release title**: `iLuro Studio Monitor v1.0.0`

4. **Description**:

```markdown
# 🎉 iLuro Studio Monitor v1.0.0

Professional NDI Studio Monitor for Linux - First public release!

## ✨ What's New

This is the initial public release of iLuro Studio Monitor, featuring:

- 🔍 **Automatic Network Discovery** - Scan and detect all NDI sources on your local network
- 📺 **Real-Time Video Preview** - Single-click access to live video streams
- 🎨 **Modern Dark UI** - Beautiful, professional interface
- 📦 **Self-Contained Package** - No external dependencies required
- ⚡ **High Performance** - Hardware-accelerated video rendering

## 💿 Installation

**System Requirements:**
- Linux x64 (Ubuntu 20.04+, Fedora 35+, Debian 11+, or compatible)
- 512 MB RAM (1 GB recommended)
- Multicast-enabled network

**Quick Install:**

1. Download `ndi-monitor-linux-v1.0.0.tar.gz` below
2. Extract: `tar -xzf ndi-monitor-linux-v1.0.0.tar.gz`
3. Install: `cd ndi-monitor-linux && sudo ./install.sh`
4. Launch: `ndi-monitor-linux`

See [README.md](README.md) for detailed documentation.

## 📝 Technical Details

- **Kotlin** 2.0.21
- **Jetpack Compose Desktop** 1.7.3
- **NDI Integration** Requires NDI® SDK 6.x (installed separately)
- **Java Runtime** OpenJDK 17 (bundled)
- **Platform** Linux x64

## 🔒 License

Proprietary - see [LICENSE](LICENSE) file for terms.

## 📊 Checksums

```
SHA256: [generate with: sha256sum ndi-monitor-linux-v1.0.0.tar.gz]
```

---

**NDI® is a registered trademark of Vizrt NDI AB.**
```

5. **Upload file**: Drag and drop `ndi-monitor-linux-v1.0.0.tar.gz`

6. Click **Publish release**

## 📊 Post-Release Checklist

- [ ] Verify download link works
- [ ] Test installation from GitHub release package
- [ ] Update README if needed (screenshots, links)
- [ ] Announce release (if applicable)
- [ ] Monitor issues for bug reports

## 🔐 Generate Checksums

```bash
sha256sum ndi-monitor-linux-v1.0.0.tar.gz > SHA256SUMS
md5sum ndi-monitor-linux-v1.0.0.tar.gz > MD5SUMS
```

Add these to release description for verification.

## 📝 Version Numbering

Using Semantic Versioning (MAJOR.MINOR.PATCH):

- **MAJOR**: Breaking changes, major features
- **MINOR**: New features, backward compatible
- **PATCH**: Bug fixes, minor improvements

Examples:
- `v1.0.0` - Initial release
- `v1.0.1` - Bug fixes
- `v1.1.0` - New features
- `v2.0.0` - Major changes

## 🎨 Future Enhancements

Consider for future releases:
- [ ] Custom application icon (replace generic video-display icon)
- [ ] Screenshot gallery in README
- [ ] Multi-monitor support
- [ ] Audio preview
- [ ] Recording functionality
- [ ] ARM64 support
- [ ] .deb and .rpm packages

