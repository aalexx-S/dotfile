# dotfile

Dotfiles, also include some vim related files.

# Bash features and commands

Some self-defined functions and features.

## Warning messages

1. git stash
2. virtualenv (for python)
3. .sourceme.sh

## commands

### tprompt

Toggle between long prompt (default) and short prompt (focus mode).

### v

Readline programs now use vi mode!!

Enter visual mode to open editor to edit command.

This is the same as &lt;C-x>&lt;C-e>

### git

- ```git branch --show-description```
	- Show description of current branch. Not very usefull...

- ```git log -o``` / ```git log -og```
	- ```-o``` for oneline, and ```-og``` for oneline and graph. 

-  ```git ff (number)```
	- autofixup the last commit if the message is "ff" (or up to 'number' - 1 cocmmits)

### open

Open a file.

Since windows does not know what to do with markdown, it is manually opened in the function.

### rswp

Remove .*.swp files in the current directory.

### activate (Switch to pipenv)

Source activate file for python virtualenv. Switch to pipenv instead.

### h

Highlight tool.

### cd

Ltcd. Use ```cd --``` to select and ```cd -n``` to go to last n dir.

### mkcd

Combined mkdir and cd.

### vread

Cat a file from ~/templates/.

Call this in vim ```:r!vread <file>``` to insert.

### ytd

Usage: ytd [url] (format)

youtube-dl. Defualt format=mp3

# Vimrc features and commands

Remember to copy all the content from .vim.

Use vim-plug as plugin manager.

Run ``` vim +PlugInstall``` to install plugins and use ```vim +PlugUpdate``` to updates.

### CoC

A really powerful autocompletion and linting engine.

- c/c++/obj-c: clangd
	```
	sudo apt-get install clang-tools-8
	sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-8 100
	```

	Check out ```https://clang.llvm.org/extra/clangd/Installation.html``` for more help.


- python: ```pip install jedi pylint --user```

- bash: ```npm i -g bash-language-server```
	- May encounter permission issue due to WSL 1.

- LaTeX: vimtex is needed. Already in .vimrc.

- text: language tool. check ```https://github.com/languagetool-org/languagetool```

Movement:

- Ctrl-j: move to the next anchor.

- Ctrl-k: move to the previous anchor.

- gd: goto definition.

- gr: show all usage (reference).

- &lt;leader>k: show document.

### vim surround

### vim ctrlp

- fuzzy file search.

### Other custom commands

"Leader" is set to '\\'.

- &lt;leader>&lt;space>: noh & pclose.

- &lt;leader>p: toggle paste mode.
	- Notice that when paste is on, all the mapping in insert mode will be temporary disabled.

- &lt;leader>bt: toggle buffer explorer window. (Added by bufexplorer.)

Ctrl:

- [insert mode] ctrl + \: map to ctrl + O. For quick commands in insert mode.

### F6 execute command

- F6 to execute command in current line with current shell.

### F9 compile

- c/cpp: save the file and compile with gcc/g++
- LaTeX: save the file and compile with xelatex

### Ctrl-p

- Markdown: save the file and execute ```open %```. In windows WSL, since markdown file cannot be associate with any program, bash will use chrome instead.
- LaTeX: save the file and open pdf with the same name.
