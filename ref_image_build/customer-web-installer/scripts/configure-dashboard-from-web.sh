#!/bin/bash
# /usr/local/bin/install_librenms.sh
# This script is used to install LibreNMS on a Ubuntu 22.04 server.
# Created by: Andy Hobbs
# Version: 1.0.0
# Date: 2026-02-27


STEP_SUFFIX=".stepcg.network"
DASH_SUFFIX="-dashboard"
HOSTS_PATH="/etc/hosts"
HOSTNAME_PATH="/etc/hostname"
DELIMITER="."

# Function to check the status of the last command
check_status() {
    THIS_STATUS=$?
    if [[ $THIS_STATUS -ne 0 ]]; then
        echo "#############################################"
        echo "## ERROR: Last command returned: $THIS_STATUS"
        echo "## Exiting..."
        echo "#############################################"
        exit 1
    fi
}

# Function to print a highlighted notice
print_notice() {
    echo -e "\n##########################################################################################"
    echo "# $(date '+%Y/%m/%d %H:%M:%S'): $1"
    echo -e "##########################################################################################\n"
}





print_notice "Updating APT repositories..."
apt-get update -y
sleep 2


# Create scripts
print_notice "Setting up the scripts directory and creating Let's Encrypt script files."
if [ ! -d "/home/stepcg/scripts" ]; then
    mkdir /home/stepcg/scripts
    check_status
fi
if [ ! -f "/home/stepcg/scripts/authenticator.sh" ]; then
    touch /home/stepcg/scripts/authenticator.sh
    check_status
fi
if [ ! -f "/home/stepcg/scripts/cleanup.sh" ]; then
    touch /home/stepcg/scripts/cleanup.sh
    check_status
fi
chmod +x /home/stepcg/scripts/authenticator.sh
check_status
chmod +x /home/stepcg/scripts/cleanup.sh
check_status


print_notice "Setup operations concluded."
sleep 1





# This is the magic string our JavaScript is looking for!
echo "LIBRENMS_SETUP_COMPLETE"