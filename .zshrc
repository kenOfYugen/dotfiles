# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/javacafe01/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

path=("$HOME/.bin" $path)
export PATH

path=("$HOME/.local/bin" $path)
export PATH

# Aliases
alias v="nvim"
alias icat="kitty +kitten icat"
alias c="clear"
alias ubrmus="~/.ncmpcpp/ncmpcpp-ueberzug/ncmpcpp-ueberzug"

# Dotbare Variables
export DOTBARE_DIR="$HOME/.cfg"
export DOTBARE_TREE="$HOME"

export TERM="xterm-256color"
  if [ "$ISLINUX" '==' 'true' ]; then
    { infocmp -1 xterm-256color ; echo "\tsitm=\\E[3m,\n\tritm=\\E[23m,"; } | \
      tic -x -
  fi

blocks() {
	echo
	for i in {0..7}; do echo -n "\e[4${i}m  \e[0m ";	done
	echo
	for i in {0..7}; do echo -n "\e[10${i}m  \e[0m ";	done
	echo -e "\n"
}

alias ls='exa --icons'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

alias cat='bat'

alias xwin='Xephyr -br -ac -noreset -screen 1400x800 :1'
alias xdisp='DISPLAY=:1 '

alias fetish="info='n os wm sh cpu mem kern term pkgs col n' accent=4 separator='  ' fet.sh"

if command -v promptus >/dev/null; then
    precmd() { PROMPT="$(eval 'promptus $?')" }
fi

# this won't get used if promptus is found above
export PROMPT="my cool prompt $ "

#export FZF_DEFAULT_OPTS='--color prompt:10,border:12,bg+:8,pointer:5'

clear; gfetch
if [ -e /home/javacafe01/.nix-profile/etc/profile.d/nix.sh ]; then . /home/javacafe01/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
