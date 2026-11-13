
nix eval .#nixosConfigurations.nyx.config.system.build.toplevel

nix run github:nix-community/nixos-anywhere -- --flake .#nyx root@172.16.0.169
