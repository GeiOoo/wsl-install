# Setup

- Run `install.ps1` in an Admin PowerShell

Existing WSL distro with the name `Ubuntu-24.04` will be unregistered and all
data will be removed!

## After install

VS Code will open from inside the WSL distro in a new directory `~/dev/`

## Quick Start

Execute following line in admin PowerShell7

```Invoke-RestMethod -Uri "https://raw.githubusercontent.com/GeiOoo/wsl-install/master/install.ps1" | Invoke-Expression```
