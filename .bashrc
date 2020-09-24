#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Make colorcoding available for everyone

Black='\[\e[0;30m\]'	# Black
Red='\[\e[0;31m\]'		# Red
Green='\[\e[0;32m\]'	# Green
Yellow='\[\e[0;33m\]'	# Yellow
Blue='\[\e[0;34m\]'		# Blue
Purple='\[\e[0;35m\]'	# Purple
Cyan='\[\e[0;36m\]'		# Cyan
White='\[\e[0;37m\]'	# White

# Bold
BBlack='\[\e[1;30m\]'	# Black
BRed='\[\e[1;31m\]'		# Red
BGreen='\[\e[1;32m\]'	# Green
BYellow='\[\e[1;33m\]'	# Yellow
BBlue='\[\e[1;34m\]'	# Blue
BPurple='\[\e[1;35m\]'	# Purple
BCyan='\[\e[1;36m\]'	# Cyan
BWhite='\[\e[1;37m\]'	# White

# Background
On_Black='\[\e[40m\]'	# Black
On_Red='\[\e[41m\]'		# Red
On_Green='\[\e[42m\]'	# Green
On_Yellow='\[\e[43m\]'	# Yellow
On_Blue='\[\e[44m\]'	# Blue
On_Purple='\[\e[45m\]'	# Purple
On_Cyan='\[\e[46m\]'	# Cyan
On_White='\[\e[47m\]'	# White

NC='\[\e[m\]'			# Color Reset

ALERT="${BWhite}${On_Red}" # Bold White on red background

# Useful aliases
alias c='clear'
alias ..='cd ..'
alias v="nvim"
alias ls='exa --icons'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias cat='bat'
alias xwin='Xephyr -br -ac -noreset -screen 1400x800 :1'
alias xdisp='DISPLAY=:1 '
alias fetish="info='n os wm sh cpu mem kern term pkgs col n' accent=4 separator='  ' fet.sh"
alias grep='grep --color=auto'

# Source for dotbare (dotfile manager)
source ~/.dotbare/dotbare.plugin.bash
export DOTBARE_DIR="$HOME/.cfg"
export DOTBARE_TREE="$HOME"

# Set PATH so it includes user's private bin directories
PATH="${HOME}/.bin:${HOME}/.local/bin:${PATH}"

# Set prompt
PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local EXIT="$?"
    local RESET="\[\e[m\]"

    PS1="\[\e[36m\] $RESET\[\e[34;1m\]\w$RESET "

    if [ $EXIT != 0 ]; then
        PS1+="$RESET\[\e[31;100m\]|$RESET "
    else
        PS1+="$RESET\[\e[32;1;100m\]|$RESET "
    fi
}

clear; gfetch
