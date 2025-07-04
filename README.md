# My Noob NixOS Config

## Based on the following repos:

- https://github.com/librephoenix/nixos-config
- https://github.com/Frost-Phoenix/nixos-config

## How to use:

- Clone the repo
- Move to .dotfiles
- Install home-manager:

'''
nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
'''

- Install configuration:
'''
sudo nixos-rebuild switch --flake .
'''

- Install home manager flake:
'''
home-manager switch --flake .
'''


## Config used:

- Nvim
- Zsh
- Wayland
- Hyprland
- Waybar

## Gruvbox based

![2025-01-27-081657_hyprshot](https://github.com/user-attachments/assets/4a4239e1-3d0e-4fae-ad85-cf0ed63af920)
![2025-01-27-081720_hyprshot](https://github.com/user-attachments/assets/23b92a9a-846b-4a90-8c9f-cd508db8e64b)
![2025-01-27-081744_hyprshot](https://github.com/user-attachments/assets/f23ae6e3-ece7-4e72-922d-153cf0c70ae7)
