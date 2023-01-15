#!/bin/bash

# Script to install the command line tool

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# The location where the script will be installed
install_dir=/usr/local/bin

# The subfolder for the command line tool
subfolder=goto

# The name of the script file
script_name=goto

# check if the installation directory exist or not
if [ ! -d $install_dir ]; then
    sudo mkdir -p $install_dir
fi

# check if the subfolder exist or not
if [ ! -d $install_dir/$subfolder ]; then
    sudo mkdir -p $install_dir/$subfolder
fi

# Check if the script file already exists in the install directory
if [ -f $install_dir/$subfolder/$script_name ]; then
    echo -e "$YELLOW"
    read -p " Warning: goto script already exists at \"$install_dir/$subfolder\". Do you want to replace it? (y/n) " -n 1 -r
    echo -e "${NC}\n"
    if [[ $REPLY =~ ^[Yy]$ ]]; then
    	sudo cp -f goto $install_dir/$subfolder/$script_name
    else
    	echo -e "${RED} Failed to install goto... exiting ${NC}"
        exit 0
    fi
else
    # Copy the script file to the install directory
    sudo cp goto $install_dir/$subfolder/$script_name
fi

# Make the script file executable
sudo chmod +x $install_dir/$subfolder/$script_name

echo -e "${GREEN}Successfully copied $script_name to $install_dir/$subfolder${NC}"

# Add the path to the command line tool to the PATH environment variable
if ! grep -q "$install_dir/$subfolder" ~/.bashrc; then
	echo "export PATH=\$PATH:$install_dir/$subfolder" >> ~/.bashrc
	echo -e "${GREEN}The path to the command line tool has been added to the PATH environment variable${NC}"
else
	echo -e "${YELLOW}PATH already has an entry for \"$install_dir/$subfolder\" skipping this step${NC}"
fi

echo 
echo -e "${GREEN}Successfully installed $script_name"



# Reload the bashrc file to make the changes take effect
