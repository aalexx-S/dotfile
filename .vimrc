"*****************************************
"Vundle-vim bundle a vim plugin manager.
"jump to 'vimrc start' tag to skip
"*****************************************

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" ex: Plugin 'tpope/vim-fugitive'
Plugin 'ntpeters/vim-better-whitespace'
" linting engin
Plugin 'w0rp/ale'
" better status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" buffer explorer
Plugin 'jlanzarotta/bufexplorer'
" base16 color theme
Plugin 'ashfinal/vim-colors-violet'
" jedi vim
Plugin 'davidhalter/jedi-vim'

" plugin from http://vim-scripts.org/vim/scripts.html
" ex: Plugin 'L9'

" Git plugin not hosted on GitHub
" ex: Plugin 'git://git.wincent.com/command-t.git'
if ! has ("win32") && ! has ("win32unix")
	" windows and all the stuff under windows shouldn't use thess
	" Plugin 'Valloric/YouCompleteMe'
endif
" git repos on your local machine (i.e. when working on your own plugin)
" ex: Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" ex: Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Avoid a name conflict with L9
" ex: Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" YCM GetDoc shortcut
" map <leader>d :YcmCompleter GetDoc<CR>
" YCM setting
" let g:ycm_seed_identifiers_with_syntax = 1
" let g:ycm_key_detailed_diagnostics = ''

" Jedi-vim setting
let g:jedi#documentation_command=''
map <leader>k :call jedi#show_documentation()<CR>

" better white spaces
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:better_whitespace_ctermcolor=23

" airline
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = '»'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
set ttimeoutlen=50

" ale setting
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_set_highlights = 0
let g:ale_python_pylint_auto_pipenv = 2
"let g:ale_python_pylint_options = "--init-hook import os; act = os.path.join(os.environ['VIRTUAL_ENV'], 'bin', 'activate_this.py');exec(open(act).read(), {'__afile__': act})"
let b:ale_linters = {
			\'javascript': ['jshint'],
			\'python': ['pylint'],
			\}
	"quick navigation
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"vimrc start
set bs=2
set tabstop=4
set softtabstop=0
set shiftwidth=4
set ai relativenumber number smarttab
set history=50
set scrolloff=4
set ruler
set splitbelow
set showcmd
set hlsearch

" pasting from outside (with shift-insert)
map <leader>p :r!cat<CR>

" autosave on swtich buffer
set autowriteall

" set undo file
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "", 0770)
endif
set undofile
set undodir=~/.vim/undo
set undolevels=1000 " how many undos
set undoreload=10000 " lines of undos

set wildmenu
set wildmode=longest,list,full
set ignorecase smartcase

" Reset the leader key, default is '\'
" let mapleader = ","
nnoremap <leader><space> :noh <bar> :pclose<cr>
" place cursor to the character after search pattern
nnoremap <leader>e gn<Esc>l

" set up for buffer usage
set hidden

" tabe labels setting
fu! MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	" append file name
	let winnr = tabpagewinnr(a:n)
	let name = fnamemodify(bufname(buflist[winnr - 1]), ':t')
	let s = empty(name) ? '[unnamed]' : name
	" Add '+' if one of the buffers in the tab page is modified
	for bufnr in buflist
		if getbufvar(bufnr, "&modified")
			let s .= '[+]'
		  	break
		endif
	endfor
	return s
endfu
fu! MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
	" select the highlighting
		if i + 1 == tabpagenr()
			let s .= '%#TabLineSel#'
		else
			let s .= '%#TabLine#'
		endif

		" display tabnumber (for use with <count>gt, etc)
		let s .= ' ('. (i+1) . ') '

		" the label is made by MyTabLabel()
		let s .= '%{MyTabLabel(' . (i + 1) . ')}'

		if i+1 < tabpagenr('$')
			let s .= ' '
		endif
	endfor
	return s
endfu
set tabline=%!MyTabLine()

"folding
setlocal foldmethod=indent

"Habit making... disable cursor key
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"au
au FileType python set expandtab

"Line number
au FocusLost * :set number
au FocusGained * :set relativenumber
au InsertEnter * :set number
au InsertLeave * :set relativenumber

"python
"If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"python syntax
""au FileType python set tw=79 cc=+1


"Display
set t_Co=256
syntax on
set encoding=utf-8
colorscheme violet
set background=dark
hi Normal ctermbg=black
hi Folded ctermbg=235
"python semicolon
hi PythonSemicolon ctermfg=1 guifg=red cterm=reverse
au FileType python syntax match PythonSemicolon /\zs\(;*\s*;\+\)*\ze\s*$/
"cursorline
set cursorline
hi CursorLine term=bold cterm=bold ctermbg=233
" Line number
hi LineNr ctermfg=241
" tabe color
hi TabLineSel ctermfg=251 ctermbg=30
hi TabLine ctermfg=251 ctermbg=241
hi TabLineFill ctermbg=241

"Set cursor
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue

"git commit message shouldn't be too long
au FileType gitcommit set tw=72 cc=+1

"restore cursor postion after closing a file
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"setup shell env
set shell=bash\ --login

"markdown preview in web browser
map <C-p> :call Markdown_preview()<Enter><C-l>
func Markdown_preview()
	exec 'w'
	if &filetype=='markdown'
		silent exec "!open %"
	endif
endfunc

"F9 compile ^^
map <F9> :call Compile()<Enter>
func Compile()
	exec 'w'
	if &filetype=='c' || &filetype=='cpp'
		exec "!g++ -Wall -std=c++11 % -o %<"
	else
		echo "Unsupported filetype."
	endif
endfunc

"F7 auto fix indent
map <F7> mzgg=G`z

"Fuckbug
"F8 fuck bug
com FB call Fuckbug()
map <F8> :call Fuckbug()<Enter>
function Fuckbug()
	r~/.vim/stuff/fuckbug.c
endfunction
