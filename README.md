# dotfile

Dotfiles, also include some vim related files.

# Bash features and commands

Some self-defined functions and features.

### commands

### v

Readline programs now use vi mode!!

Enter visual mode to open editor to edit command.

This is the same as &lt;C-x>&lt;C-e>

### git

* git branch --show-description

* git log -o / git log -og

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

# Vimrc features and commands

Use vim-plug as plugin manager.

Run ``` vim +PlugInstall``` to install plugins and use ```vim +PlugUpdate``` to updates.

### CoC

A really powerful autocompletion and linting engine.

- python: ```pip install jedi```
- bash: ```npm i -g bash-language-server```
- LaTeX: vimtex is needed.

Movement:

- Ctrl-j: move to the next anchor.

- Ctrl-k: move to the previous anchor.

- gd: goto definition.

- gr: show all usage (reference).

- &lt;leader>k: show document.


### &lt;leader> command

"Leader" is set to '\\'.

- &lt;leader>&lt;space>: noh & pclose.

- &lt;leader>p: toggle paste mode.
	- Notice that when paste is on, all the mapping in insert mode will be temporary disabled.

- &lt;leader>bt: toggle buffer explorer window. (Added by bufexplorer.)

Ctrl:

- [insert mode] ctrl + \: map to ctrl + O. For quick commands in insert mode.



The following program need to be installed for ale to work.

- javascript: jshint (npm install)

- python: pylint

### Ctrl-p

- Markdown: save the file and execute ```open %```. In windows WSL, since markdown file cannot be associate with any program, bash will use chrome instead.
