" vi: foldmethod=marker foldlevel=0

" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'romainl/vim-qf'
Plug 'romainl/vim-qlist'
Plug 'sheerun/vim-polyglot'
Plug 'tmsvg/pear-tree'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'

call plug#end()
" }}}

" Settings {{{
" colors
set termguicolors
let g:nord_bold=1
let g:nord_italic=1
let g:nord_underline=1
let g:nord_italic_comments=1
augroup Colors
    autocmd!
    autocmd ColorScheme nord highlight Folded cterm=italic,bold ctermbg=0 ctermfg=10 guibg=#3B4252 guifg=#5E81AC

    autocmd ColorScheme nord highlight CocErrorSign guifg=#BF616A
    autocmd ColorScheme nord highlight CocWarningSign guifg=#EBCB8B
    autocmd ColorScheme nord highlight CocErrorHighlight guisp=#BF616A gui=undercurl
    autocmd ColorScheme nord highlight CocWarningHighlight guisp=#EBCB8B gui=undercurl

    autocmd ColorScheme nord highlight fzf1 guifg=#ECEFF4 guibg=#4C566A
    autocmd ColorScheme nord highlight fzf2 guifg=#ECEFF4 guibg=#4C566A
    autocmd ColorScheme nord highlight fzf3 guifg=#ECEFF4 guibg=#4C566A
augroup END

colorscheme nord

" general
let mapleader="\<space>"
set updatetime=300
set grepprg=rg\ --vimgrep
set scrolloff=5
set lazyredraw
set hidden
set autoread

" indentation
set shiftwidth=4
let &softtabstop=&shiftwidth
set expandtab

" find/replace
set ignorecase
set smartcase
set gdefault

" wildmenu
set wildmode=longest:full,full
set wildignorecase fileignorecase
set wildignore+=*.pyc,*.o,*~,**/.git/**,**/tmp/**,**/node_modules/**,**/_build/**,**/deps/**,**/target/**,**/uploads/**,**/build/**,**/built/**

" highlight trailing whitespace
highlight TrailingWhitespace guibg=#cc6666 ctermbg=darkred
match TrailingWhitespace / \+$/
" }}}

" Keybindings {{{
" rebind j and k only when a count is not supplied
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> gj (v:count == 0 ? 'j' : 'gj')
nnoremap <expr> gk (v:count == 0 ? 'k' : 'gk')

" keep search matches in the middle of the screen
nnoremap n nzzzv
nnoremap N Nzzzv

" clear highlighting and redraw
nnoremap <silent> <leader>l :nohl<CR><C-l>

" split navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" fast search/replace
nnoremap <leader>r :'{,'}s/\<<C-r>=expand('<cword>')<CR>\>/
nnoremap <leader>R :%s/\<<C-r>=expand('<cword>')<CR>\>/
xnoremap <leader>r :<C-u>'{,'}s/<C-r>=functions#GetVisualSelection()<CR>/
xnoremap <leader>R :<C-u>%s/<C-r>=functions#GetVisualSelection()<CR>/

" make Y behave like D and C
nnoremap Y y$

" linewise reselection after paste
nnoremap <leader>V V`]

" open terminal in new tab
nnoremap <leader>s :tabnew \| :terminal<CR>i

" tab navigation
nnoremap <c-Left> gT
nnoremap <c-Right> gt
inoremap <c-Left> <Esc>gTi
inoremap <c-Right> <Esc>gti
tnoremap <c-Left> <C-\><C-n>gTi
tnoremap <c-Right> <C-\><C-n>gti
" }}}

" Window splitting {{{

" split correctly
set splitright splitbelow

augroup Splits
    autocmd!

    " resize splits when window is resized
    autocmd VimResized * :wincmd =

    " cursorline only in active window
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END
" }}}

" Terminal {{{
let g:terminal_color_0='#1d1f21'
let g:terminal_color_1='#cc6666'
let g:terminal_color_2='#b5bd68'
let g:terminal_color_3='#f0c674'
let g:terminal_color_4='#81a2be'
let g:terminal_color_5='#b294bb'
let g:terminal_color_6='#8abeb7'
let g:terminal_color_7='#ecebec'
let g:terminal_color_8='#1d1f21'
let g:terminal_color_9='#cc6666'
let g:terminal_color_10='#b5bd68'
let g:terminal_color_11='#f0c674'
let g:terminal_color_12='#81a2be'
let g:terminal_color_13='#b294bb'
let g:terminal_color_14='#8abeb7'
let g:terminal_color_15='#ecebec'

augroup Terminal
    autocmd!

    " disable line numbers
    autocmd TermOpen * setlocal nonumber norelativenumber scrolloff=0
augroup END

" use escape to return to normal mode
tnoremap <Esc> <C-\><C-n>
" }}}

" {{{ vim-qf
nmap <leader>q <Plug>(qf_qf_toggle)
nmap [q <Plug>(qf_qf_previous)
nmap ]q <Plug>(qf_qf_next)
" }}}

" CoC.nvim {{{
set shortmess+=c
set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

let g:coc_global_extensions=["coc-json", "coc-eslint", "coc-tsserver", "coc-python"]
" }}}

" FZF {{{
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>t :BTags<CR>
nnoremap <leader>T :Tags<CR>
nnoremap <leader>g :Rg<space>

let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction

let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
" }}}

" pear-tree {{{
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
" }}}

" Lightline {{{
let g:lightline = { 'colorscheme': 'nord' }
" }}}

