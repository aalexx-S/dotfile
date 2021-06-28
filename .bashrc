unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)
		if grep -q Microsoft /proc/version; then
			machine=WSL
		else
			machine=Linux
		fi
	;;
    MSYS*)      machine=MSYS;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Change vim to default editor
export VISUAL=vim
export EDITOR="$VISUAL"
export DISPLAY="localhost:0.0" # enable X11 with XcXsrv on windows

# remove old vim undo files
# when last edit is over 45 days ago
find ~/.vim/undo -type f -mtime +45 -delete

# setup git information
source ~/.bash_git

## source functions
# execute setup.sh if error
source ~/h.sh
source ~/cxpgrep.sh
source ~/ltcd.sh
# my bash functions
source ~/myfunctions.sh

## PATH
# Platform related stuff
if [ "$machine" == "MSYS" ]; then
	#MSYS2
	export PATH=$PATH:/${JAVA_HOME//+([:\\])//}/bin
fi

if [ ! -z "$MSVSCODE" ]; then
    # Opened from visual studio code
	cd "$MSVSCODEDIR"
	unset MSVSCODE
	unset MSVSCODEDIR
fi

# extend local bin to PATH
export PATH=$PATH:$HOME/.local/bin

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Bash prompt functions
source ~/myprompt.sh

# ls colors
if [[ ! -f ~/.dircolors ]] ; then
	curl https://raw.githubusercontent.com/aalexx-S/dircolors-solarized/master/dircolors.256dark > ~/.dircolors
fi
eval $(dircolors ~/.dircolors)

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

## Source local settings
if [[ -f ~/localsettings.sh ]] ; then
    source ~/localsettings.sh
fi
