#!/bin/bash
set -e

# Run from the repo root so Bazelisk picks up .bazelversion
cd "$(dirname "$0")/.."

# The ARMv6 toolchain, GoogleTest and pigpio are fetched by Bazel itself (see MODULE.bazel).
# Bazel version is pinned in .bazelversion and picked up by Bazelisk.

echo "1. Installing basic build prerequisites..."
sudo apt update && sudo apt install -y wget git build-essential lcov

echo "2. Installing Bazel (via Bazelisk)..."
wget -q --show-progress -O bazelisk-linux-amd64 https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-amd64
chmod +x bazelisk-linux-amd64
sudo mv bazelisk-linux-amd64 /usr/local/bin/bazel

echo "=========================================================="
echo "Installation Complete!"
echo " - Bazel version: $(bazel --version)"
echo " - Build for the Pi with: bazel build --config=pi_zero_w //..."
echo "=========================================================="
