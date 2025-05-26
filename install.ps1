# Check if running as administrator
#Requires -Version 7.4 -RunAsAdministrator

# Enable WSL feature if not already enabled
if ((Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux).State -ne 'Enabled') {
    Write-Host "Enabling WSL feature..."
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart
    Write-Host "WSL features enabled. Please restart your computer and run this script again."
    Exit
}

code --install-extension ms-vscode-remote.remote-wsl

wsl --unregister Ubuntu-24.04

$distroPath = "~/Ubuntu-24_04.appx";
$distroDownloadUrl = "https://wslstorestorage.blob.core.windows.net/wslblob/Ubuntu2404-240425.AppxBundle";

# check if file exists
if (Test-Path $distroPath) {
    Write-Host "Distro file already exists. Skipping download.";
}
else {
    Write-Host "Downloading distro file...";
    Invoke-WebRequest -Uri $distroDownloadUrl -OutFile $distroPath -UseBasicParsing;
}

Add-AppxPackage -Path $distroPath

RefreshEnv

Ubuntu2404 install --root
Ubuntu2404 run apt update
Ubuntu2404 run apt upgrade -y

# install git
Ubuntu2404 run apt install -y git

# install docker
Ubuntu2404 run "curl -fsSL https://get.docker.com | sudo sh"

# open folder insider wsl in vs code
Ubuntu2404 run mkdir ~/dev
Ubuntu2404 run code ~/dev/
