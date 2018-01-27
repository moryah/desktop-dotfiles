noremap ww :w<CR>

"set nocompatible
syntax on
set nowrap
set encoding=utf8

" Show linenumbers
set number
set ruler

" Set Proper Tabs
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
    
" Always display the status line
"set laststatus=2

" Enable Elite mode, No ARRRROWWS!!!!
"let g:elite_mode=1

" Enable highlighting of the current line
"set cursorline

" Theme and Styling 
set t_Co=256
set background=dark

"if (has("termguicolors"))
"  set termguicolors
"endif

"let base16colorspace=256  " Access colors present in 256 colorspace
"colorscheme spacegray
" colorscheme spacemacs-theme

"let g:spacegray_underline_search = 1
"let g:spacegray_italicize_comments = 1

" Vim-Airline Configuration
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1 
"let g:airline_theme='hybrid'
"let g:hybrid_custom_term_colors = 1
"let g:hybrid_reduced_contrast = 1 

" Syntastic Configuration
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_enable_elixir_checker = 1
" let g:syntastic_elixir_checkers = ["elixir"]


execute pathogen#infect()

syntax on
filetype plugin indent on
