# GAP Installation Script

This script automates the installation process for the GAP system on Ubuntu-based systems. It downloads the GAP archive, extracts it, installs the required dependencies, configures the system, and creates an alias for easy access to the GAP command.

## Prerequisites

- Ubuntu-based system (tested on Ubuntu 18.04 and higher)
- `wget` command-line utility

## Usage

1. Clone or download the repository:

    ```bash
    git clone https://github.com/smrrazavian/gap_installation.git
    ```

2. Change into the repository directory:

    ```bash
    cd gap_installation
    ```

3. Make the script executable:

    ```bash
    chmod +x gap_installation.sh
    ```

4. Run the script:

    ```bash
    ./gap_installation.sh
    ```

5. Follow the on-screen instructions. The script will download the GAP archive, extract it, install the required dependencies, configure the system, and create an alias for the `gap` command.

6. After the installation completes, reopen your terminal or run the following command to apply the changes:

    ```bash
    source ~/.bashrc
    ```

7. You can now use the `gap` command to run the GAP system from any directory.

## License

This project is licensed under the [MIT License](LICENSE).
