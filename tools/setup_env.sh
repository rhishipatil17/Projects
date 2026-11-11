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

echo "3. Installing GitHub CLI (gh), used to upload dependencies to bazel-deps releases..."
# From GitHub's own apt repo; the Ubuntu archive's gh lags several versions behind
sudo mkdir -p -m 755 /etc/apt/keyrings
wget -q -O- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install -y gh

echo "=========================================================="
echo "Installation Complete!"
echo " - Bazel version: $(bazel --version)"
echo " - gh version: $(gh --version | head -1)"
echo " - Log in to GitHub (needed for gh release uploads) with: gh auth login"
echo " - Build for the Pi with: bazel build --config=pi_zero_w //..."
echo "=========================================================="
