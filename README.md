# dotfile

Dotfiles, also include some vim related files.

# Bash features and commands

Some self-defined functions and features.

### commands

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

Use Vundle as plugin manager.

Run ``` vim +PluginInstall``` to install plugins and use ```vim +PluginUpdate``` to updates.

If it hangs on YCM, kill the job, and goto YCM folder under vundle folder in .vim and execute install.py.

After executing install.py, try again.

### Jedi-Vim

Auto completion tool better than ycm.

- &lt;C-Space>: auto complete. Enter to select.

- &lt;leader>d: goto definition.

- &lt;leader>n: show all usage.

- &lt;leader>k: show document.


### &lt;leader> command

"Leader" is set to '\\'.

- &lt;leader>&lt;space>: noh & pclose.

- &lt;leader>p: toggle paste mode.
	- Notice that when paste is on, all the mapping in insert mode will be temporary disabled.

- &lt;leader>bt: toggle buffer explorer window. (Added by bufexplorer.)

Ctrl:

- [insert mode] ctrl + \: map to ctrl + O. For quick commands in insert mode.

### Ale

- Ctrl-j: move to the next anchor.

- Ctrl-k: move to the previous anchor.

The following program need to be installed for ale to work.

- javascript: jshint (npm install)

- python: pylint

### Ctrl-p

- Markdown: save the file and execute ```open %```. In windows WSL, since markdown file cannot be associate with any program, bash will use chrome instead.
