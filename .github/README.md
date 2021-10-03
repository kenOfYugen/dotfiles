<div align=center>

# dotfiles

[![NixOS](https://img.shields.io/badge/NixOS-21.11-informational.svg?logo=nixos)](https://github.com/nixos/nixpkgs) [![AwesomeWM](https://img.shields.io/badge/AwesomeWM-git-blue.svg?logo=lua)](https://github.com/awesomeWM/awesome)

</div>

<a href="https://awesomewm.org/"><img alt="AwesomeWM Logo" height="160" align = "left" src="https://upload.wikimedia.org/wikipedia/commons/0/07/Awesome_logo.svg"></a>

Welcome to my system configuration files! My system is managed by Nix, as I use NixOS. Well, most of it is. My AwesomeWM configuration and Neovim configuration files are still written in lua, as the number of edits, features, and customizations I have done on them are too massive for me to convert those configs to Nix. The only configuration left to convert to Nix is **wezterm**.

**Note**: Please don't use this as a template NixOS setup - I just started using NixOS and I'm sure what I'm doing isn't the best at some places.


## Setup for NixOS
1. Get the latest [NixOS ISO](https://nixos.org/download.html) and boot into the installer/environment.
2. Format and mount your disks.
3. Follow these commands:

```bash
# Get into a Nix shell with git and flakes
nix-shell -p nixFlakes

# Clone my dotfiles
git clone https://github.com/JavaCafe01/awedots /mnt/etc/nixos

# Remove this file
rm /mnt/etc/nixos/thonkpad/hardware-configuration.nix

# Generate a config and copy the hardware configuration, disregarding the generated configuration.nix
nixos-generate-config
cp /etc/nixos/hardware-configuration.nix /mnt/etc/nixos/thonkpad/

# Install this NixOS configuration with flakes
nixos-install --root /mnt --flake /mnt/etc/nixos#thonkpad --impure
```
4. Reboot, login as root, and change the password for your user using `passwd`.
5. Log in as your normal user.


## AwesomeWM Modules
### [bling](https://github.com/BlingCorp/bling)
- Adds new layouts, modules, and widgets that try to primarily focus on window management
### [layout-machi](https://github.com/xinhaoyuan/layout-machi)
- Manual layout for Awesome with an interactive editor
### [UPower Battery Widget](https://github.com/Aire-One/awesome-battery_widget)
- A widget accessing **UPower** for battery info with LGI
### [rubato](https://github.com/andOrlando/rubato)
- Creates smooth animations with a slope curve for awesomeWM (Awestore, but not really)
### Better Resize
- An improved method of resizing clients in the tiled layout
### Save Floats
- Saves positions of clients in the floating layout

## Screenshots
TODO

## Special Thanks
- [elenapan's dotfiles](https://github.com/elenapan/dotfiles)
- [fortuneteller2k's NixOS Configuration](https://github.com/fortuneteller2k/nix-config)
