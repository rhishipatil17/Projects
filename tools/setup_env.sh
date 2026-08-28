#!/bin/bash
set -e

# Define variables for the SourceForge URL and file paths
TOOLCHAIN_URL="https://sourceforge.net/projects/raspberry-pi-cross-compilers/files/Raspberry%20Pi%20GCC%20Cross-Compiler%20Toolchains/Bullseye/GCC%2014.2.0/Raspberry%20Pi%201%2C%20Zero/cross-gcc-14.2.0-pi_0-1.tar.gz/download"
TAR_FILE="cross-gcc-14.2.0-pi_0-1.tar.gz"
DEST_DIR="/opt/cross-pi-gcc"

echo "1. Installing basic build prerequisites..."
sudo apt update && sudo apt install -y wget tar xz-utils git build-essential libgtest-dev lcov

echo "2. Installing Bazel (via Bazelisk)..."
wget -q --show-progress -O bazelisk-linux-amd64 https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-amd64
chmod +x bazelisk-linux-amd64
sudo mv bazelisk-linux-amd64 /usr/local/bin/bazel
$(bazel --version)

echo "3. Downloading and extracting ARMv6 toolchain..."
wget -q --show-progress -O "$TAR_FILE" "$TOOLCHAIN_URL"
sudo mkdir -p "$DEST_DIR"
echo "Extracting..."
sudo tar -xf "$TAR_FILE" -C "$DEST_DIR" --strip-components=1
rm -f "$TAR_FILE"

echo "=========================================================="
echo "Installation Complete!"
echo " - Bazel version: $(bazel --version)"
echo " - Toolchain location: $DEST_DIR/bin"
echo "=========================================================="
