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

    home.packages =
      [ pkgs.nixfmt pkgs.ripgrep pkgs.keybase pkgs.niv pkgs.fzf pkgs.fd ];

    programs.emacs = { enable = true; };

    home.file = {
      ".doom.d" = {
        source = ./doom.d;
        recursive = true;
      };
    };

    programs.bat = {
      enable = true;
      config = { theme = "Dracula"; };
    };

    programs.git = {
      enable = true;
      userName = "rikvanderkemp";
      userEmail = "r.vanderkemp@pararius.nl";
      signing = {
        key = "725EEF5FB6559093";
        signByDefault = true;
      };
      aliases = {
        st = "status -s -b";
        lg =
          "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset %Cblue[%an]%Creset' --abbrev-commit --date=relative";
        alias = "config --get-regexp ^alias\\.";
        co = "checkout";
        up = "!f() { echo 'Fetch & Pull' && git fetch --tags && git pull; }; f";
        t =
          "log --tags --simplify-by-decoration --pretty=format:'%Cred%d%Creset - %ai (%Cblue[%an]%Creset)' -n30";
        edit = "config --edit --global";
        delmerged = ''
          !f() { git branch --merged | grep -v "^*" | awk '{print $NF}' | xargs git branch -d; }; f'';
        pushf = "push --force-with-lease";
        delgone =
          "!f() { git branch -vvv | grep gone | awk '{print $1}' | xargs git branch -d; }; f";
        delgonef =
          "!f() { git branch -vvv | grep gone | awk '{print $1}' | xargs git branch -D; }; f";
        mergeff = "merge --ff";
        recent =
          "for-each-ref --count=10 --sort=-committerdate refs/heads/ --format='%(refname:short)'";
        prunetags = "!f() { git tag -l | xargs git tag -d; git fetch -t; }; f";
        undo = "reset HEAD^";
        wip = "!f() { git add . && git commit -m'WIP' --no-verify; }; f";
        cp = "log --pretty=format:'🍒 %h --> %d %s' -1";
      };
      extraConfig = {
        pull = {
          ff = "only";
          rebase = true;
        };
        core = {
          autocrlf = "input";
          filemode = false;
        };
        init = { defaultBranch = "main"; };
      };
      ignores = [ ".DS_Store" ".idea" ];
      delta = {
        enable = true;
        options = {
          navigate = true;
          line-numbers = true;
          syntax-theme = "Dracula";
          features = "decorations";
        };
      };
    };

    programs.beets = {
      enable = true;
      settings = {
        directory = "/home/rik/Music";
        library = "/home/rik/Music/musiclibrary.blb";
        import = {
          copy = false;
          move = false;
        };
        paths = {
          default =
            "$albumartist/$year - $album%aunique{}/%if{$multidisc,Disc $disc/}$track - $title";
        };
        item_fields = { multidisc = "1 if disctotal > 1 else 0"; };

        plugins = "inline fetchart bandcamp";
        bandcamp = {
          exclude_extra_fields = [ "lyrics" "comments" "year" "country" ];
        };
        art = "true";
      };
    };
  };
}
