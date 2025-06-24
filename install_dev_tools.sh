#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo "Starting development tools installation..."

# Check and install Docker
if command_exists docker; then
    echo -e "${YELLOW}Docker is already installed${NC}"
else
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    rm get-docker.sh
    echo -e "${GREEN}Docker installed successfully${NC}"
fi

# Check and install Docker Compose
if command_exists docker-compose; then
    echo -e "${YELLOW}Docker Compose is already installed${NC}"
else
    echo "Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo -e "${GREEN}Docker Compose installed successfully${NC}"
fi

# Check and install Python
if command_exists python3; then
    PYTHON_VERSION=$(python3 --version)
    echo -e "${YELLOW}Python is already installed: ${PYTHON_VERSION}${NC}"
else
    # Check if pip is installed
    if ! command_exists pip3; then
        echo "Installing pip..."
        sudo apt install -y python3-pip
        echo -e "${GREEN}Pip installed successfully${NC}"

        cho "Installing Python..."
        sudo apt update
        sudo apt install -y python3 python3-pip
        echo -e "${GREEN}Python installed successfully${NC}"
    fi
fi

# Check and install Django
if python3 -m pip show django >/dev/null 2>&1; then
    echo -e "${YELLOW}Django is already installed${NC}"
else
    echo "Installing Django..."
    python3 -m pip install django
    echo -e "${GREEN}Django installed successfully${NC}"
fi

echo -e "${GREEN}All development tools have been installed!${NC}"

# Print versions
echo -e "\nInstalled versions:"
docker --version
docker-compose --version
python3 --version
python3 -m django --version