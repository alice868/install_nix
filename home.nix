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
  xdg.enable = true;
  xdg.configFile."nvim".source = pkgs.fetchFromGitHub {
    owner = "LazyVim";
    repo = "starter";
    rev = "main";
    hash = pkgs.lib.fakeHash;
  };
 }
