
nix develop .#gcc
nix develop .#clang

nix develop ~/install_nix#rust-llvm

nix eval --raw   .#nixosConfigurations.nyx.config.system.build.toplevel.drvPath

nix eval .#nixosConfigurations.nyx.config.system.build.toplevel

nix run github:nix-community/nixos-anywhere -- --flake .#nyx root@172.16.0.169
