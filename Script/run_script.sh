# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt-get update && sudo apt-get upgrade -y

# Install Java Runtime Environment (JRE)
echo "Installing Java Runtime Environment..."
sudo apt install default-jre

# Download Mirth Connect
echo "Downloading Mirth Connect..."
curl https://s3.amazonaws.com/downloads.mirthcorp.com/connect/4.4.2.b326/mirthconnect-4.4.2.b326-unix.tar.gz -o mirthconnect.tar.gz

# Extract Mirth Connect
echo "Extracting Mirth Connect..."
tar -xvzf mirthconnect.tar.gz

# Move Mirth Connect to /opt/
echo "Moving Mirth Connect to /opt/"
sudo mv Mirth\ Connect/ /opt/mirthconnect

# Start Mirth Connect service
echo "Starting Mirth Connect service..."
/opt/mirthconnect/mcservice start

# Check Mirth Connect service status
echo "Checking Mirth Connect service status..."
/opt/mirthconnect/mcservice status

echo "Installation completed!"