" vi: foldmethod=marker foldlevel=0

" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'alvan/vim-closetag'
Plug 'arcticicestudio/nord-vim'
" Plug 'fatih/vim-go'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'

call plug#end()
" }}}

" Settings {{{
" colors
set termguicolors
let g:nord_bold=1
let g:nord_italic=1
let g:nord_underline=1
let g:nord_italic_comments=1
au ColorScheme nord highlight Folded cterm=italic,bold ctermbg=0 ctermfg=10 guibg=#3B4252 guifg=#5E81AC
colorscheme nord

" general
let mapleader="\<space>"
set grepprg=rg
set scrolloff=5
set relativenumber
set number
set lazyredraw
set hidden

" indentation
set shiftwidth=4
let &softtabstop=&shiftwidth
set expandtab

" find/replace
set ignorecase
set smartcase
set gdefault

" wildmenu
set wildignorecase fileignorecase
set wildignore+=*.pyc,*.o,*~,**/.git/**,**/tmp/**,**/node_modules/**,**/_build/**,**/deps/**,**/target/**,**/uploads/**

" highlight trailing whitespace
highlight TrailingWhitespace guibg=#cc6666 ctermbg=darkred
match TrailingWhitespace / \+$/
" }}}

" Window splitting {{{
" resize splits when window is resized
au VimResized * :wincmd =

" split correctly
set splitright splitbelow

" cursorline only in active window
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
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

" disable line numbers
autocmd TermOpen * setlocal nonumber norelativenumber

" use escape to return to normal mode
tnoremap <Esc> <C-\><C-n>
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
" }}}

" CoC.nvim {{{
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

highlight CocErrorSign guifg=#BF616A
highlight CocWarningSign guifg=#EBCB8B
highlight CocErrorHighlight guisp=#BF616A gui=undercurl
highlight CocWarningHighlight guisp=#EBCB8B gui=undercurl

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

let g:coc_global_extensions=["coc-json", "coc-eslint", "coc-tsserver"]
" }}}

" FZF {{{
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>t :BTags<CR>
nnoremap <leader>T :Tags<CR>
nnoremap <leader>g :Rg<space>
" }}}

" Auto-pairs {{{
let g:AutoPairsCenterLine=0
let g:AutoPairsMultilineClose=0
" }}}

" Lightline {{{
let g:lightline = { 'colorscheme': 'nord' }
" }}}

