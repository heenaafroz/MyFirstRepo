#!/bin/bash

# Update tools

sudo apt-get update
sudo apt-get install -y wget unzip vim nano git telnet

# Azure Cli
sudo apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg 

curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

AZ_REPO=$(lsb_release -cs)
echo "deb [arch=`dpkg --print-architecture`] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt-get update
sudo apt-get install azure-cli

# K9S
sudo snap install k9s
#sudo wget https://github.com/derailed/k9s/releases/download/v0.26.7/k9s_Linux_x86_64.tar.gz
#sudo tar -xvf k9s_Linux_x86_64.tar.gz -C /usr/local/bin
#sudo chmod +x /usr/local/bin/k9s

# Flux

curl -s https://fluxcd.io/install.sh | sudo bash


# kubectl 

sudo az aks install-cli
#curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
#mv kubectl /usr/local/bin
#sudo chmod +x /usr/local/bin/kubectl


# helm 

if (helm version); then
    echo "helm exsite"
else
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    sudo chmod 700 get_helm.sh
    sudo ./get_helm.sh
fi
