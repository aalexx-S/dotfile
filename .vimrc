"*****************************************
"vim-plug, a vim plugin manager.
"jump to 'vimrc start' tag to skip
"*****************************************
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nocompatible              " be iMproved, required

call plug#begin('~/.vim/bundle')

""" Make sure you use single quotes
"" 1. Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'ntpeters/vim-better-whitespace'
" better status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" buffer explorer
Plug 'jlanzarotta/bufexplorer'
" base16 color theme
Plug 'ashfinal/vim-colors-violet'
" nerd tree
Plug 'scrooloose/nerdtree'
" vimtex
Plug 'lervag/vimtex'
"" 2. Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

"" 3. Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

"" 4. On-demand loading
"Plug 'scrooloose/nerdtree', {'on':  'NERDTreeToggle'}

"" 5. Using a non-master branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"" CoC config
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <C-k> <Plug>(coc-diagnostic-prev)
nmap <C-j> <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <leader>k :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

""""""""""""
"vimrc start
""""""""""""

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
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | wincmd w | endif
" Open nerdtree if vim open with directory instead of file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Close vim if the only window left is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

set ttimeoutlen=50
set noshowmode
set laststatus=0
set cmdheight=1
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
" pasting from outside (with shift-insert)
nnoremap <leader>p :set invpaste paste?<CR>
" Open nerdtree
nnoremap <leader>n :NERDTreeToggle<CR>

" Quick command from insert mode
imap <C-\> <C-O>

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
