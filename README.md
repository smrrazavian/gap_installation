# GAP Installation Script

This script automates the installation process for the GAP system on Ubuntu-based systems. It downloads the GAP archive, extracts it, installs the required dependencies, configures the system, and creates an alias for easy access to the GAP command.

## Prerequisites

- Ubuntu-based system (tested on Ubuntu 18.04 and higher)
- `wget` command-line utility

## Usage

To install GAP using the provided script, run the following command in your terminal:

```bash
bash <(curl -fsSL https://github.com/smrrazavian/gap_installation/raw/main/gap_installation.sh)
