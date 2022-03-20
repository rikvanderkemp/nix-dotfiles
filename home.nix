{ config, lib, pkgs, ... }:

with lib;

{
  config = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.username = "rik";
    home.homeDirectory = "/home/rik";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "22.05";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    home.packages = [
      pkgs.ripgrep
      pkgs.keybase
      pkgs.niv
      pkgs.cuetools
      pkgs.shntool
      pkgs.flac
      pkgs.fzf
      pkgs.fd
    ];

    programs.emacs =  {
      enable = false;
    };

    programs.bat = {
      enable = true;
      config = {
        theme = "Dracula";
      };
    };

    programs.git = {
      enable = true;
      userName = "rikvanderkemp";
      userEmail = "rik@upto11.nl";
      extraConfig = {
        pull = {
          ff = "only";
        };
        init = {
          defaultBranch = "main";
        };
      };
      ignores = [ ".DS_Store" ".idea" ];
      delta = {
        enable = true;
        options = {
          navigate = true;
          line-numbers = true;
          syntax-theme = "Dracula";
        };
      };
    };

    programs.go = {
      enable = true;
    };
  };
}
