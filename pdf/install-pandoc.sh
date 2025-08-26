#!/usr/bin/env bash
set -euo pipefail

echo "Installing Pandoc and LaTeX toolchain via Homebrew..."

# Check if homebrew is installed
if ! command -v brew >/dev/null 2>&1; then
    echo "ERROR: Homebrew not found. Please install Homebrew first:"
    echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

echo "Installing pandoc..."
brew install pandoc

echo "Installing BasicTeX (lightweight LaTeX distribution)..."
brew install --cask basictex

echo "Updating PATH for current session..."
export PATH="/usr/local/texlive/2024basic/bin/universal-darwin:$PATH"

echo "Installing additional LaTeX packages..."
sudo tlmgr update --self
sudo tlmgr install xetex
sudo tlmgr install fontspec
sudo tlmgr install unicode-math
sudo tlmgr install geometry

echo ""
echo "✅ Installation complete!"
echo "You may need to restart your terminal or run:"
echo "  export PATH=\"/usr/local/texlive/2024basic/bin/universal-darwin:\$PATH\""
echo ""
echo "Then test with: ./pdf/build.sh"
