
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
" colorscheme
Plug 'ashfinal/vim-colors-violet'
Plug 'sainnhe/gruvbox-material'
" file navigation
Plug 'ctrlpvim/ctrlp.vim'
" search function definition with regex
Plug 'tacahiroy/ctrlp-funky'
" vimtex
Plug 'lervag/vimtex'
" vim writegood
Plug 'davidbeckingsale/writegood.vim'
" vim-surround
Plug 'tpope/vim-surround'

"" 2. Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

"" 3. Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

"" 4. On-demand loading
"Plug 'scrooloose/nerdtree', {'on':  'NERDTreeToggle'}

"" 5. Using a non-master branch
if v:version >= 800
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

call plug#end()
