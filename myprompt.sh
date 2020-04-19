function git_stash_check_current_branch(){
	if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1 ; then
		branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
		stashes=`git stash list | grep -i "on $branch"`
		if [[ $stashes ]] ; then
			echo -e " \001\033[1;31;7m\002!!Stash!!"
		fi
	fi
}

function parse_current_directory(){
	cur=${PWD/$HOME/"~"}
	if [[ $cur == "~" ]] ; then
		cur="~/"
	fi
	echo -e "\001\033[38;5;39m\002${cur%/*}/\001\e[38;5;208m\002 \b${cur##*/}"
}

function virtualenv_check(){
	if [[ "$VIRTUAL_ENV" != "" ]] ; then
		echo -e "\001\e[38;5;185m\002(virtualenv: ${VIRTUAL_ENV##*/})"
	fi
}

function sourceme_check() {
	if [[ -f ".sourceme.sh" ]]; then
		echo -e "\001\e[38;5;185m\002(.sourceme.sh exists!)"
	fi
}

function user_check(){
	echo -e "\001\e[38;5;150m\002"
}

function error_check(){
	if [[ $__MY_EXIT -gt 127 ]] ; then
		echo -e "\001\e[38;5;208m\002[SIG:$(kill -l $(($__MY_EXIT-128)))] "
	elif [[ $__MY_EXIT -ne 0 ]] ; then
		echo -e "\001\e[1;38;5m\002[ERR:$__MY_EXIT] "
	fi
}

# Bash prompt magic
# this spawns a lot of process.
# You should switch to short prompt on shared servers.
function set_bash_prompt() {
	__MY_EXIT=$? #Save last exit code

	PS1='\n \[\e[38;5;39m\]\d \[\e[38;5;36m\][ \t ] $(virtualenv_check) $(sourceme_check)\n \[\e[38;5;36m\][\!] ${debian_chroot:+($debian_chroot)} $(user_check)\u @ \h\[\033[00m\]: $(parse_current_directory) \[\e[0m\]\[\033[00m\]\n\[\033[1;38;5;196m\]$(__git_ps1)$(git_stash_check_current_branch) $(error_check)\[\033[00m\]\$ '
	# sometimes cursor randomly dissapear...
	echo -en "\e[?25h"
}

# short prompt command
function short_prompt() {
    PS1='\n \[\e[38;5;36m\][\t] ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '
}

if [ "$color_prompt" = yes ]; then
	PROMPT_COMMAND=set_bash_prompt
else
    PS1='\n${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# toggle prompt command, focus mode!!
alias tprompt='if test "$PROMPT_COMMAND" = "set_bash_prompt" ; then PROMPT_COMMAND="short_prompt" ; else PROMPT_COMMAND="set_bash_prompt" ; fi'
