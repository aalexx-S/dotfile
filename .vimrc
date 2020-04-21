"*****************************************
"vim-plug, a vim plugin manager.
"*****************************************
source ~/.vim/myvimplug.vim

"*****************************************
"plugin settings
"*****************************************
" coc
source ~/.vim/mycoc.vim

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

" Nerdtree
" Open nerdtree if no file on opening vim
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | wincmd w | endif
" Open nerdtree if vim open with directory instead of file
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Close vim if the only window left is nerdtree
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"*****************************************
"The leader key
"*****************************************
" Reset the leader key, default is '\'
" let mapleader = ","
nnoremap <leader><space> :noh <bar> :pclose<cr>
" place cursor to the character after search pattern
nnoremap <leader>e gn<Esc>l
" pasting from outside (with shift-insert)
nnoremap <leader>p :set invpaste paste?<CR>
" Open nerdtree
nnoremap <leader>n :NERDTreeToggle<CR>
" read template
nnoremap <leader>rt :-1r!vread<space>~/templates/
" Quick command from insert mode
imap <C-\> <C-O>


"*****************************************
"General vim settings
"*****************************************
set ttimeoutlen=50
set noshowmode
set laststatus=0
set cmdheight=1
set bs=2
set history=50
set scrolloff=4
set ruler
set splitbelow
set showcmd
set hlsearch
set wildmenu
set wildmode=longest,list,full
set ignorecase smartcase

" set up for buffer usage
set hidden
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

" folding
setlocal foldmethod=indent
set foldopen-=block
au FileType python set foldignore=
au FileType c,cpp setlocal foldmethod=syntax
" set fold to manual when entering insert mode to avoid auto expanding fold
" when entering unmatched bracket
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
" reset fold method after leaving insert mode
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" Habit making... disable cursor key in normal mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" tab
au FileType python set expandtab
set tabstop=4
set softtabstop=0
set shiftwidth=4
set ai smarttab

" Line number
set nu rnu
au FocusLost * :set nu nornu
au FocusGained * :set nu rnu
au InsertEnter * :set nu nornu
au InsertLeave * :set nu rnu

"If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"Display
set t_Co=256
syntax on
set encoding=utf-8
" installed colorscheme: violet, gruvbox, gruvbox-material
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
" line number
hi LineNr ctermfg=241
" tabe
source ~/.vim/tabelabel.vim
hi TabLineSel ctermfg=251 ctermbg=30
hi TabLine ctermfg=251 ctermbg=241
hi TabLineFill ctermbg=241

"Set cursor
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue

" rulers
"git commit message shouldn't be too long
au FileType gitcommit set tw=72 cc=+1
"pep8 ruler, not practical
""au FileType python set tw=79 cc=+1

"restore cursor postion after closing a file
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"setup shell env
set shell=bash\ --login


"*****************************************
"Custom functions
"*****************************************
"markdown preview in web browser
map <C-p> :call Preview_file()<Enter><C-l>
func Preview_file()
	exec 'w'
	if &filetype=='markdown'
		silent exec "!open %:p"
	elseif &filetype=='tex'
		silent exec "!open %<.pdf"
	endif
endfunc

"F9 compile ^^
map <F9> :call Compile()<Enter>
func Compile()
	exec 'w'
	if &filetype=='c' || &filetype=='cpp'
		exec "!g++ -Wall -std=c++11 % -o %<"
	elseif &filetype=='tex'
		exec "!xelatex %"
	else
		echo "Unsupported filetype."
	endif
endfunc

" execute command in current line from vim
nnoremap <F6> :exec '!'.getline('.')<CR>

"F7 auto fix indent
map <F7> mzgg=G`z
