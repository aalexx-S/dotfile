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

# if in interactive mode
if [[ $- == *i* ]]; then
	echo "Machine=${machine}"
fi

export LANG=zh_TW.UTF-8

alias cd..="cd .."
alias sl="sl -e"
alias ls="ls --color=auto"
alias ll="ls -l --color=auto"
alias l="ls"
alias rm="rm -i"
alias cls="clear"

#thefuck
#eval "$(thefuck --alias)"

source ~/.bash_git

function beep() {
	while /bin/true;
		do echo -ne "\a";
	done
}

function git() {
	if [[ $@ == "branch --show-description" ]]; then
		bash ~/.git_show_description.sh
	elif [[ $@ == "log -o" ]]; then
		command git log --oneline
	elif [[ $@ == "log -og" ]]; then
		command git log --oneline --graph
	else
		command git "$@"
	fi
}

function open() {
	if [[ $machine == "WSL" ]]; then
		if [[ $@ == "" ]]; then
			echo "Nothing to open!!"
			return
		fi
		# set default program for markdown
		if [[ $@ == *.md ]]; then
			# prepend chrome to the argument
			# use chrome to open .md files.
			command set -- chrome "$@"
		fi
		command cmd.exe /c start "$@"
	else

		command xdg-open "$@"
	fi
}

# virtualenv activate
function activate() {
	if [[ $# -eq 1 ]] ; then
		command source "$@"/bin/activate
	else
		command activate "$@"
	fi
}

# hhighlighter setup
# download ack if not exist
if [[ ! -f ~/bin/ack ]] ; then
	echo "Downloading ack, a better grep tool."
	set -x
	mkdir -p ~/bin/
	curl https://beyondgrep.com/ack-2.16-single-file > ~/bin/ack && chmod 0755 ~/bin/ack
	{ set +x; } 2>/dev/null
fi
# download hhighlighter if not exist
if [[ ! -f ~/hhighlighter.sh ]] ; then
	echo "Downloading hhighlighter, a better grep tool build on ack."
	set -x
	curl https://raw.githubusercontent.com/paoloantinori/hhighlighter/b9c90bd100e68cb3e22d652200c200431ded9069/h.sh > ~/hhighlighter.sh
	{ set +x; } 2>/dev/null
fi
# load hhighlighter script
source ~/hhighlighter.sh

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
function git_stash_check_current_branch(){
	if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1 ; then
		branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
		stashes=`git stash list | grep -i "on $branch"`
		if [[ $stashes ]] ; then
			echo -e " \033[1;31;7m!!Stash!!"
		fi
	fi
}

function parse_current_directory(){
	cur=${PWD/$HOME/"~"}
	if [[ $cur == "~" ]] ; then
		cur="~/"
	fi
	echo -e "\033[38;5;26m${cur%/*}/\e[38;5;208m${cur##*/}"
}

function virtualenv_check(){
	if [[ "$VIRTUAL_ENV" != "" ]] ; then
		echo -e "\033[01;32m(virtualenv: ${VIRTUAL_ENV##*/})"
	fi
}

# Bash prompt magic
function set_bash_prompt() {
	PS1='\n \[\e[38;5;26m\]\d \[\e[00;36m\][ \t ]\n \[\e[36m\][\!] ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u @ \h\[\033[00m\]: $(parse_current_directory) $(virtualenv_check)\[\e[0m\]\[\033[00m\]\n\[\033[1;31m\]$(__git_ps1)$(git_stash_check_current_branch)\[\033[00m\] \$ '
}

if [ "$color_prompt" = yes ]; then
	PROMPT_COMMAND=set_bash_prompt
else
    PS1='\n${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

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
