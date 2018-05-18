noremap ww :w<CR>
noremap <C-P> @:<CR>
map <leader>d <Plug>(ale_fix)
map <leader>f :file<CR>
noremap <leader>o <C-W>gf
noremap gb :tabprevious<CR>
nnoremap gw <C-w><C-w> <CR>

"set nocompatible
syntax on
set nowrap
set encoding=utf8

" Show linenumbers
set number
"set cursorcolumn
set ruler

"highlight ModeMsg ctermbg=230
"highlight MoreMsg ctermbg=230
"highlight StatusLine ctermbg=230
"highlight StatusLineTerm ctermbg=230

highlight SpellBad ctermbg=red ctermbg=NONE

highlight Normal ctermbg=232

highlight TabLineSel ctermbg=232 ctermfg=240
highlight TabLine ctermbg=16 ctermfg=237
highlight TabLineFill ctermbg=16 ctermfg=16

highlight StatusLine ctermfg=237 ctermbg=233     
highlight StatusLineNC ctermfg=237 ctermbg=233   

highlight LineNr ctermfg=Black ctermbg=16
highlight CursorLineNr cterm=NONE ctermbg=234 ctermfg=darkgray guibg=NONE guifg=NONE

highlight CursorLine cterm=NONE ctermbg=234

highlight Visual cterm=NONE ctermbg=52
"ctermfg=NONE guibg=NONE guifg=NONEZZ
"highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE


highlight NonText cterm=NONE ctermbg=NONE
highlight EndOfBuffer cterm=NONE ctermbg=16 ctermfg=233

set cursorline

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
set cursorline

" Theme and Styling 
set t_Co=256
"set background=dark

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


"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"
execute pathogen#infect()

syntax on
filetype plugin indent on

let g:ale_fixers = { 'javascript': ['eslint'], }

let &t_SI = "\e[3 q"
let &t_EI = "\e[5 q"



" Statusline
"set noshowmode 
"set statusline=%t\ %m%r%y%=(ascii=\%03.3b,hex=\%02.2B)\ (%l/%L,%c)\ (%P)
"set laststatus=2
"" change highlighting based on mode
"if version >= 700
"    highlight statusLine cterm=bold ctermfg=black ctermbg=red
"      au InsertLeave * highlight StatusLine cterm=bold ctermfg=black ctermbg=red
"        au InsertEnter * highlight StatusLine cterm=bold ctermfg=black ctermbg=green
"      endif

" find files and populate the quickfix list
fun! FindFiles(filename)
  let error_file = tempname()
  silent exe '!find . -iname "'.a:filename.'*" | xargs file | sed "s/:/:1:/" > '.error_file
  set errorformat=%f:%l:%m
  exe "cfile ". error_file
  copen
  call delete(error_file)
endfun
command! -nargs=1 FindFile call FindFiles(<q-args>)

set switchbuf+=newtab
