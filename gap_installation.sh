#!/bin/bash

# Prompt for the user's password
read -sp "Enter your password: " password
echo

# Function to check if a command is available
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to install dependencies on Linux
install_dependencies_linux() {
  echo "$password" | sudo -S apt update
  echo "$password" | sudo -S apt-get install -y build-essential autoconf libtool libgmp-dev libreadline-dev zlib1g-dev
}

# Function to install dependencies on macOS
install_dependencies_macos() {
  if ! command_exists brew; then
    echo "Homebrew is not installed. Installing Homebrew..."
    echo "$password" | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  echo "$password" | brew install gmp readline
}

# Function to download GAP archive
download_gap() {
  if [ ! -f gap-4.12.2.tar.gz ]; then
    echo "Downloading GAP..."
    wget --progress=bar:force https://github.com/gap-system/gap/releases/download/v4.12.2/gap-4.12.2.tar.gz
  fi
}

# Function to extract GAP archive
extract_gap() {
  if [ ! -d gap-4.12.2 ]; then
    tar -xf gap-4.12.2.tar.gz
  fi
}

# Function to configure and make GAP
configure_and_make_gap() {
  cd gap-4.12.2
  configure_cmd="./configure"
  if [ "$os_type" == "macos" ]; then
    configure_cmd+=" --with-gmp=$(brew --prefix) --with-readline=$(brew --prefix)/opt/readline"
  fi
  $configure_cmd && make
}

# Function to add GAP alias and binary path to shell configuration file
add_gap_alias_to_shell() {
  echo -e "\e[32mAdding GAP alias and binary path to shell configuration file...\e[0m"
  echo "alias gap=\"$gap_path/gap-4.12.2/bin/gap.sh\"" >> "$shell_config_file"
  echo "export PATH=\"\$PATH:$gap_path/gap-4.12.2/bin\"" >> "$shell_config_file"
  source "$shell_config_file"
}

# Set the shell configuration file path
shell_config_file=""

# Check the operating system
os=$(uname -s)
case "$os" in
  Linux*)
    echo "Detected Linux-based OS"
    os_type="linux"
    shell_config_file="$HOME/.bashrc"  # Update with your desired path
    install_dependencies_linux
    ;;
  Darwin*)
    echo "Detected macOS"
    os_type="macos"
    shell_config_file="$HOME/.bash_profile"  # Update with your desired path
    install_dependencies_macos
    ;;
  *)
    echo "Unsupported operating system: $os"
    exit 1
    ;;
esac

# Download GAP archive
download_gap

# Extract GAP archive
extract_gap

# Store current directory path
gap_path=$(pwd)

# Configure and make GAP
configure_and_make_gap

# Add GAP alias and binary path to shell configuration file
add_gap_alias_to_shell

# Reload the shell configuration file
source "$shell_config_file"

echo "Installation completed. You can now call 'gap' from any directory."
