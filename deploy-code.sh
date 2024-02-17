#!/bin/bash

# Set the repository URL and local directory
repository_url="https://github.com/mahalekiran/CICD-Pipeline"
local_directory="/home/mahalek/CICD"

# Set Nginx service name
nginx_service="nginx"

# Function to clone the latest code
clone_latest_code() {
    echo "Cloning the latest code from $repository_url to $local_directory"
    git clone $repository_url $local_directory
}

# Function to restart Nginx
restart_nginx() {
    echo "Restarting Nginx"
    sudo service $nginx_service restart
}

# Main script execution
echo "Deploying the code..."

# Check if the local directory already exists, if so, pull the latest changes
if [ -d "$local_directory" ]; then
    echo "Updating existing code..."a
    cd $local_directory || exit
    git pull
else
    clone_latest_code
fi

# Restart Nginx
restart_nginx

echo "Deployment complete!"