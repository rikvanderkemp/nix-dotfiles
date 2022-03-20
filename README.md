# My Home-manager driven dotfiles setup

## Setup

Make sure you [have a working Nix environment](https://nixos.org/download.html). (Multi-user installation recommended)

Before installing `home-manager` make sure you have the following in your `bashrc`


``` shell
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
```

For fish, I would recommend adding the above to bashrc first and then copy paste the output as a fish variable.

The following should be sufficient:

``` shell
set -U NIX_PATH /home/<user>/.nix-defexpr/channels /nix/var/nix/profiles/per-user/root/channels
```

Now install home-manager:

``` shell

# Add the home-manager channel
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# Install home-manager
nix-shell '<home-manager>' -A install
```
