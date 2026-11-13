{
  description = "NixOS Hyper-V development VM";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    {
      self,
      nixpkgs,
      disko,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPacakges.${system};
    in
    {
      nixosConfigurations.nyx = nixpkgs.lib.nixosSystem {
        modules = [
          disko.nixosModules.disko
          ./disk-config.nix
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.alice = import ./home.nix;
          }
        ];
      };

      # GCC development environment
      devShells.${system}.gcc = pkgs.mkShell {
        packages = with pkgs; [
          gcc
          binutils
          gdb
          gnumake
          cmake
          pkg-config
          git
        ];
        shellHook = ''
          echo "GCC development environment"
          gcc --version | head -n 1
        '';
      };

      # Clang / LLVM development environment
      devShells.${system}.clang =
        pkgs.mkShell.override
          {
            stdenv = pkgs.llvmPackages.stdenv;
          }
          {
            packages = with pkgs; [
              llvmPackages.clang
              llvmPackages.lld
              llvmPackages.lldb
              llvmPackages.llvm
              gnumake
              cmake
              pkg-config
              git
            ];
            shellHook = ''
              echo "Clang / LLVM development environment"
              clang --version | head -n 1
            '';
          };
      # Default shell
      devShells.${system}.default = self.devShells.${system}.gcc;
      formatter.${system} = pkgs.nixfmt;
    };

  devShells.${system}.rust-llvm =
    pkgs.mkShell.override
      {
        stdenv = pkgs.llvmPackages.stdenv;
      }
      {
        packages = with pkgs; [
          rustc
          cargo
          rustfmt
          clippy
          rust-analyzer
          llvmPackages.clang
          llvmPackages.llvm
          llvmPackages.lld
          llvmPackages.libclang
          pkg-config
          cmake
          gnumake
        ];
        LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
        shellHook = ''
          echo "Rust + LLVM development environment"
          rustc --version
          clang --version | head -n 1
        '';
      };

}
