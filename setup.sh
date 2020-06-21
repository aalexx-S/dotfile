# download h if not exist
if [[ ! -f ~/h.sh ]] ; then
	echo "Downloading h, a better grep highlighter tool build on ack."
	set -x
	curl https://raw.githubusercontent.com/dczhu/mch/master/h > ~/h.sh
	{ set +x; } 2>/dev/null
fi

# download cxpgrep if not exist
if [[ ! -f ~/cxpgrep.sh ]] ; then
	echo "Downloading cxpgrep, a grep wrapper."
	set -x
	curl https://raw.githubusercontent.com/dczhu/cxpgrep/master/cxpgrep > ~/cxpgrep.sh
	{ set +x; } 2>/dev/null
fi

# download ltcd if not exist
if [[ ! -f ~/ltcd.sh ]] ; then
	echo "Downloading ltcd, a cd wrapper."
	set -x
	curl https://raw.githubusercontent.com/dczhu/ltcd/master/ltcd > ~/ltcd.sh
	{ set +x; } 2>/dev/null
fi

# download dircolors
if [[ ! -f ~/.dircolors ]] ; then
	echo "Downloading dircolors."
	curl https://raw.githubusercontent.com/aalexx-S/dircolors-solarized/master/dircolors.256dark > ~/.dircolors
fi

# copy files to home dir
CPFILE=(.bash_aliases .bash_git .bashrc gitautofixup.sh .git_show_description.sh .inputrc my_functions.sh myprompt.sh .pylintrc .vimrc)
CPDIR=(templates .vim)

echo "Ignoring .shh folder."

for i in "${CPFILE[@]}"; do
	echo "Copy $i to ~/"
	cp "$i" ~/
done

for i in "${CPDIR[@]}"; do
	echo "Copy $i to ~/"
	cp -r $i ~/
done

# install pylint
pip3 install pylint --user

# install jedi
pip3 install jedi --user

## init vim
vim +PlugInstall +qa

# install coc plugins
vim "+CocInstall coc-python coc-json" +qa
