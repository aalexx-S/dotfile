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

# Vimrc features and commands

Use Vundle as plugin manager.

Run ``` vim +PluginInstall``` to install plugins and use ```vim +PluginUpdate``` to updates.

If it hangs on YCM, kill the job, and goto YCM folder under vundle folder in .vim and execute install.py.

After executing install.py, try again.

### &lt;leader> command

"Leader" is set to '\\'.

- &lt;leader>d: YcmCompleter GetDoc.

- &lt;leader>&lt;space>: noh & pclose.

- &lt;leader>p: r!cat. This enable pasting with shift-insert. Press ctrl-d (eof) after pasting.

- &lt;leader>bt: toggle buffer explorer window. (Added by bufexplorer.)

### Ale

- Ctrl-j: move to the next anchor.

- Ctrl-k: move to the previous anchor.

The following program need to be installed for ale to work.

- javascript: jshint (npm install)

- python: pylint

### Ctrl-p

- Markdown: save the file and execute ```open %```. In windows WSL, since markdown file cannot be associate with any program, bash will use chrome instead.
