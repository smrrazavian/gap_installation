#!/bin/bash

# Prompt for the user's password
read -sp "Enter your password: " password
echo

# Check if GAP is already downloaded
if [ ! -f gap-4.12.2.tar.gz ]; then
    echo "Downloading GAP..."
    echo "$password" | sudo -S wget --progress=bar:force https://github.com/gap-system/gap/releases/download/v4.12.2/gap-4.12.2.tar.gz
fi

# Extract the downloaded archive
echo "$password" | sudo -S tar -xf gap-4.12.2.tar.gz

# Change to the extracted directory
cd gap-4.12.2

# Update package lists and install required dependencies
echo "$password" | sudo -S apt update
echo "$password" | sudo -S apt-get install -y build-essential autoconf libtool libgmp-dev libreadline-dev zlib1g-dev

# Run the configure script and make
./configure
make

# Add GAP alias to bashrc file
echo 'alias gap="./bin/gap.sh"' >> ~/.bashrc

# Add GAP binary path to PATH variable
echo 'export PATH="$PATH:'$(pwd)'/bin"' >> ~/.bashrc

# Reload the bashrc file
source ~/.bashrc

echo "Installation completed. You can now call 'gap' from any directory."
