#!/bin/bash
GIT_REPO="https://github.com/mahalekiran/CICD-Pipeline.git"
NGINX_SERVICE="nginx"

# Cloning the latest code
if [ -d "/tmp/latest_code" ] && [ "$(ls -A /tmp/latest_code)" ]; then
    # Pull the latest changes
    echo "Pulling the latest changes from the repository..."
    cd /tmp/latest_code || exit
    git pull
else
    # Clone the repository
    echo "Cloning the repository into /tmp/latest_code..."
    git clone "$GIT_REPO" /tmp/latest_code || exit
fi

# Check if the clone was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to clone the repository."
  exit 1
fi

# Replace old code with the latest
echo "Replacing old code with the latest..."
sudo rm -rf /var/www/html/*
sudo cp -r /tmp/latest_code/* /var/www/html/

# Restart Nginx
echo "Restarting Nginx..."
sudo systemctl restart $NGINX_SERVICE

# Check if Nginx restart was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to restart Nginx."
  exit 1
fi

echo "Deployment completed successfully!"