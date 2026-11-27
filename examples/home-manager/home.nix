{ config, pkgs, ... }:

{
  home.username = "wlum";
  home.homeDirectory = "/home/wlum";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    python3
  ];

  nixpkgs.config.allowUnfree = true;

  programs = {
    git = {
      enable = true;
      settings.user.email = "joe@example.org";
      settings.user.name = "joe";
    };

    home-manager.enable = true;

    vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        vscodevim.vim
        yzhang.markdown-all-in-one
      ];
    };
  };
}
