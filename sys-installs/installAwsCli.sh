#!/usr/bin/env bash

set -e

SOFTWARE_NAME="AWS CLI v2"
COMMAND_NAME="aws"
INSTALL_DIR="/usr/local/aws-cli"
BIN_PATH="/usr/local/bin/aws"

TMP_DIR="/tmp/awscli-install"
ZIP_FILE="awscliv2.zip"

# 1. Check EUID (must be root)
if [[ "$EUID" -ne 0 ]]; then
    echo "❌ This script must be run as root (use sudo)."
    exit 1
fi

# 2. Check for required tools (instead of apt requirement)
for cmd in curl unzip; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "❌ Required tool '$cmd' is not installed."
        echo "Install it using: sudo apt install -y $cmd"
        exit 1
    fi
done

# 3. Inform user and confirm
echo "This script will install: $SOFTWARE_NAME"
echo "It will download and install AWS CLI v2 from the official source."
read -rp "Proceed? (y/n): " CONFIRM

if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    echo "❌ Installation cancelled."
    exit 0
fi

# 4. Check if command name already exists
if command -v "$COMMAND_NAME" >/dev/null 2>&1; then
    echo "❌ A command named '$COMMAND_NAME' already exists on this system."
    echo "To avoid conflicts, installation will not proceed."
    exit 1
fi

# 5. Prepare temp directory
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"

# 6. Download AWS CLI v2
echo "📥 Downloading AWS CLI v2..."
curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$ZIP_FILE"

# 7. Unzip
echo "📦 Extracting..."
unzip -q "$ZIP_FILE"

# 8. Install silently
echo "⚙️ Installing..."
./aws/install --install-dir "$INSTALL_DIR" --bin-dir /usr/local/bin >/dev/null

# 9. Cleanup
cd /
rm -rf "$TMP_DIR"

# 10. Completion message
echo "✅ Installation complete!"
echo "Try running: aws --version"
