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
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
    git
    ripgrep
    fd
    fzf
    nixfmt
    cmake
    gnumake
    pkg-config
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
