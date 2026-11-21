# Set-up Guide

## Pre-requisites

### Windows Subsystem for Linux

```ps1
wsl --install --name Ubuntu-26.04
```

### Nix

```bash
# Single-user installation
# https://nixos.org/download/
curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --no-daemon

# Enable experimental features
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Test it
nix shell nixpkgs#cowsay
cowsay "Hello World!"
```
