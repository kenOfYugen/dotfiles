source "$HOME/.cargo/env"

# Nix stuff
source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

if [ -f $HOME/.nix-profile/etc/profile.d/nix.sh ];
then
    source $HOME/.nix-profile/etc/profile.d/nix.sh
fi

export XDG_DATA_DIRS=$HOME/.nix-profile/share:/usr/local/share:/usr/share
