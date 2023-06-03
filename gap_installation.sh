#!/bin/bash

# Prompt for the user's password
read -sp "Enter your password: " password
echo

# Function to check if a command is available
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check the operating system
os=$(uname -s)
case "$os" in
  Linux*)
    echo "Detected Linux-based OS"
    os_type="linux"
    ;;
  Darwin*)
    echo "Detected macOS"
    os_type="macos"
    ;;
  *)
    echo "Unsupported operating system: $os"
    exit 1
    ;;
esac

# Install dependencies based on the operating system
if [ "$os_type" == "linux" ]; then
  # Update package lists
  echo "$password" | sudo -S apt update
  
  # Install required dependencies
  echo "$password" | sudo -S apt-get install -y build-essential autoconf libtool libgmp-dev libreadline-dev zlib1g-dev
elif [ "$os_type" == "macos" ]; then
  # Check if Homebrew is installed
  if ! command_exists brew; then
    echo "Homebrew is not installed. Installing Homebrew..."
    echo "$password" | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  
  # Install required dependencies with Homebrew
  echo "$password" | brew install gmp readline
else
  echo "Unsupported operating system: $os_type"
  exit 1
fi

# Check if GAP is already downloaded
if [ ! -f gap-4.12.2.tar.gz ]; then
  echo "Downloading GAP..."
  wget --progress=bar:force https://github.com/gap-system/gap/releases/download/v4.12.2/gap-4.12.2.tar.gz
fi

# Extract the downloaded archive
tar -xf gap-4.12.2.tar.gz

# Change to the extracted directory
cd gap-4.12.2

# Configure and make GAP
if [ "$os_type" == "macos" ]; then
  ./configure --with-gmp=$(brew --prefix) --with-readline=$(brew --prefix)/opt/readline && make
else
  ./configure && make
fi

# Add GAP alias to bashrc file
echo 'alias gap="./bin/gap.sh"' >> ~/.bashrc

# Add GAP binary path to PATH variable
echo 'export PATH="$PATH:'$(pwd)'/bin"' >> ~/.bashrc

# Reload the bashrc file
source ~/.bashrc

echo "Installation completed. You can now call 'gap' from any directory."
