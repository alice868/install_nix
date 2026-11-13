{ pkgs, ... }:
{
  home.username = "alice";
  home.homeDirectory = "/home/alice";
  home.stateVersion = "26.05";
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  home.packages = with pkgs; [

    # Rust compiler and toolchain
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer

    # Nix development
    nixfmt
    nil
    nixd

    # Rust development utilities
    cargo-watch
    cargo-edit
    cargo-nextest
    cargo-audit
    cargo-expand
    # Build dependencies
    gcc
    clang
    llvm
    pkg-config
    openssl
    gnumake
    cmake

    # CLI tools
    git
    ripgrep
    fd
    fzf
    gcc
    gnumake
    unzip
    nodejs
    python3
  ];

  home.sessionVariables = {
    RUST_BACKTRACE = "1";
    RUST_LOG = "info";
  };

  xdg.enable = true;
  xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
    owner = "LazyVim";
    repo = "starter";
    rev = "803bc181d7c0d6d5eeba9274d9be49b287294d99";
    ##    hash = pkgs.lib.fakeHash;
    hash = "sha256-QrpnlDD4r1X4C8PqBhQ+S3ar5C+qDrU1Jm/lPqyMIFM=";
  };
}
