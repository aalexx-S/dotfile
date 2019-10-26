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

# youtube-dl
function ytd() {
	X_FORMAT="mp3"
	if [[ $# -eq 2 ]] ; then
		X_FORMAT=$2
	fi
	command youtube-dl -x --audio-format $X_FORMAT $1
}
