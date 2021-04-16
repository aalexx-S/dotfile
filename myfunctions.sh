# BEEP!!
function beep() {
	while /bin/true;
		do echo -ne "\a";
	done
}

# git alias
function git() {
	if [[ $@ == "branch --show-description" ]]; then
		bash ~/.git_show_description.sh
	elif [[ $@ == "log -o" ]]; then
		command git log --oneline
	elif [[ $@ == "log -og" ]]; then
		command git log --oneline --graph
	elif [[ $1 == "ff" ]]; then
		local STEP
		STEP=2
		if [[ ! -z $2 ]]; then
			STEP=$2
		fi
		echo "Autofixup last $STEP commits. Fix up commits whose message is 'ff'."
		export GIT_SEQUENCE_EDITOR=~/gitautofixup.sh
		git rebase -i HEAD~$STEP
		unset GIT_SEQUENCE_EDITOR
	else
		command git "$@"
	fi
}

# open for wsl
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

# remove swp file
function rswp() {
	rm -f ./.*.swp
}

# mkdir & cd
function mkcd() {
	command mkdir -p -- "$1"
	command cd -P -- "$1"
}

# virtualenv activate
# pipenv
function prp() {
	command pipenv run python $@
}

# virtualenv activate
# consider use pipenv instead
function activate() {
	if [[ $# -eq 1 ]] ; then
		command source "$@"/bin/activate
	else
		command activate "$@"
	fi
}

# cat a file from templates
function vread() {
	command cd ~/templates
	cat $1
}

vread_comp="$(ls ~/templates)"
complete -W "${vread_comp}" vread

# youtube-dl
function ytd() {
	X_FORMAT="mp3"
	if [[ $# -eq 2 ]] ; then
		X_FORMAT=$2
	fi
	command youtube-dl -x --audio-format $X_FORMAT $1
}

# Search parrent dir for match pattern
# Example:
#   pwd = /path/fruit/red/apple
#   $ pdir fruit
#   and
#   $ pdir fr
#   will return /path/fruit. It searches "pattern*" i.e. prefix.
# Usage:
#   cd $(pdir my_project_root)/other/dir
#
# Sadly, this doesn't benefit from path auto completion.
# Warning: Watchout when there are spaces in pwd.
function pdir(){
    cur="$(pwd)"

    if [[ -z $2 ]] ; then
        count=1
    else
        count=$2
    fi

    while [[ ! -z $cur ]] ; do
        token="${cur##*/}"
        if [[ $token == $1* ]] ; then
            count=$(($count-1))
            if [[ $count -eq 0 ]] ; then
                echo "$cur"
                return
            fi
        fi
        cur="${cur%/*}"
    done

    >&2 echo "No matched parent dir pattern found."
    exit 1
}

