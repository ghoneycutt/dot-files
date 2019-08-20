" Disable Ale with ALEToggle

" turn off auto adding comments on next line
" so you can cut and paste reliably
" http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
set fo=tcq

execute pathogen#infect()

syntax on

" make backspace work in insert mode
set backspace=indent,eol,start

" set default comment color to cyan instead of darkblue
" which is not very legible on a black background
highlight comment ctermfg=cyan

set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2

" turn off ALE, which does lint checking, of puppet erb templates. As I type,
" the text is moved around and it is not helpful
let g:ale_pattern_options = {
\   '.*\.erb$': {'ale_enabled': 0},
\   '.*templates/.*\.erb$': {'ale_enabled': 0},
\}

" default is 200ms
let g:ale_lint_delay = 1000

let g:signify_skip_filename_pattern = [ 'templates/.*\.erb$' ]
" use :SignifyToggle to turn on
let g:signify_disable_by_default = 1

" used by signify plugin
let g:signify_vcs_list = ['git']

" promptline
let g:promptline_preset = 'clear'
let g:promptline_theme = 'darkjelly'

" nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" control-o to open file window
map <C-o> :NERDTreeToggle<CR>

highlight LiteralTabs ctermbg=darkgreen guibg=darkgreen
match LiteralTabs /\s\	/
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

" Show me a ruler
set ruler

" Highlight search results
set hlsearch

" ****************************************************************************
" Misc Stuff
" ****************************************************************************
filetype plugin indent on

au BufRead,BufNewFile *.pp set filetype=puppet

set mmp=500000

autocmd FileType make setlocal noexpandtab

set encoding=UTF-8
