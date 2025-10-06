#!/bin/bash

# Neovim setup script
# Installs or updates Neovim to the required version

REQUIRED_VERSION="0.11.4"
INSTALL_DIR="$HOME/.local/bin"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
  echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# Function to compare versions
version_ge() {
  # Returns 0 if $1 >= $2
  [ "$(printf '%s\n' "$2" "$1" | sort -V | head -n1)" = "$2" ]
}

# Check if nvim is installed
if command -v nvim &>/dev/null; then
  CURRENT_VERSION=$(nvim --version | head -n1 | sed -n 's/.*v\([0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/p')
  if [ -n "$CURRENT_VERSION" ]; then
    log_info "Found Neovim version $CURRENT_VERSION"

    if version_ge "$CURRENT_VERSION" "$REQUIRED_VERSION"; then
      log_info "Neovim version $CURRENT_VERSION meets minimum requirement ($REQUIRED_VERSION)"
      log_info "Setup complete!"
      return 0
    else
      log_warn "Neovim version $CURRENT_VERSION is older than required version $REQUIRED_VERSION"
      log_info "Updating Neovim..."
    fi
  else
    log_warn "Could not determine Neovim version. Proceeding with installation..."
  fi
else
  log_info "Neovim not found. Installing..."
fi

# Detect OS and architecture
OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
Linux*)
  log_info "Detected Linux system"

  # Create install directory if it doesn't exist
  mkdir -p "$INSTALL_DIR"

  # Determine architecture
  case "$ARCH" in
  x86_64)
    APPIMAGE_NAME="nvim-linux-x86_64.appimage"
    ;;
  aarch64 | arm64)
    APPIMAGE_NAME="nvim-linux-arm64.appimage"
    ;;
  *)
    log_error "Unsupported architecture: $ARCH"
    exit 1
    ;;
  esac

  # Download latest release AppImage
  DOWNLOAD_URL="https://github.com/neovim/neovim/releases/latest/download/${APPIMAGE_NAME}"
  NVIM_PATH="$INSTALL_DIR/nvim"

  log_info "Downloading Neovim AppImage for $ARCH..."
  if ! curl -fL "$DOWNLOAD_URL" -o "$NVIM_PATH"; then
    log_error "Failed to download Neovim from $DOWNLOAD_URL"
    exit 1
  fi
  chmod +x "$NVIM_PATH"

  log_info "Neovim installed to $NVIM_PATH"

  # Check if $INSTALL_DIR is in PATH
  if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    log_warn "$INSTALL_DIR is not in your PATH"
    log_warn "Add this line to your ~/.bashrc or ~/.zshrc:"
    echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
  fi
  ;;

Darwin*)
  log_info "Detected macOS system"

  if command -v brew &>/dev/null; then
    brew install --HEAD neovim || brew upgrade neovim
  else
    log_error "Homebrew not found. Please install Homebrew first:"
    log_error "https://brew.sh"
    exit 1
  fi
  ;;

*)
  log_error "Unsupported operating system: $OS"
  exit 1
  ;;
esac

# Verify installation
if command -v nvim &>/dev/null; then
  NEW_VERSION=$(nvim --version | head -n1 | sed -n 's/.*v\([0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/p')
  if [ -n "$NEW_VERSION" ]; then
    log_info "Successfully installed Neovim version $NEW_VERSION"
  else
    log_info "Neovim installed successfully"
  fi
else
  log_error "Installation failed. Neovim not found in PATH"
  exit 1
fi

log_info "Setup complete!"
