# Check if running as administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run this script as Administrator!"
    Exit
}

# Enable WSL feature if not already enabled
if ((Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux).State -ne 'Enabled') {
    Write-Host "Enabling WSL feature..."
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart
    Write-Host "WSL features enabled. Please restart your computer and run this script again."
    Exit
}

wsl --unregister Ubuntu-24.04

Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-2404 -OutFile ~/Ubuntu.appx -UseBasicParsing
Add-AppxPackage -Path ~/Ubuntu.appx

RefreshEnv
Ubuntu2404 install --root
Ubuntu2404 run apt update
Ubuntu2404 run apt upgrade -y

# install git
Ubuntu2404 run apt install -y git

# install docker
Ubuntu2404 run apt install -y docker.io

# open folder insider wsl in vs code
Ubuntu2404 run mkdir ~/dev
Ubuntu2404 run code ~/dev/

# Create setup script for Ubuntu
# $setupScript = @'
# #!/bin/bash
# # Update package list and upgrade existing packages
# sudo apt-get update && sudo apt-get upgrade -y

# # Install Git
# sudo apt-get install -y git

# # Install Docker prerequisites
