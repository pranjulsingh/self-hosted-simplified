#!/bin/bash
echo "checking git installation"
if ! command -v git > /dev/null
then
    echo "git not installed"
    echo "installing git"

    sudo apt-get update
    sudo apt install git
else
    echo "git already installed"
    echo "skipping git installation"
fi

echo "checking docker installation"
if ! command -v docker > /dev/null
then
    echo "docker not installed"
    echo "installing docker"

    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    # Add the repository to Apt sources:
    echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
else
    echo "docker already installed"
    echo "skipping docker installation"
fi

echo "cloning the repo: self-hosted-simplified"
git clone https://github.com/pranjulsingh/self-hosted-simplified.git
echo "env setup done"
echo "edit config files and run deploy.sh file"