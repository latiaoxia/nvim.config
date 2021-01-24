call plug#begin('~/.local/share/nvim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'joshdick/onedark.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'google/vim-searchindex'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'easymotion/vim-easymotion'

call plug#end()

" Miscellaneous
let mapleader=" "
filetype plugin indent on
set noexpandtab
set softtabstop=8
set tabstop=8
set shiftwidth=8
" set expandtab
" set softtabstop=4
" set tabstop=4
" set shiftwidth=4
set smartindent
set smartcase
set splitbelow
set splitright
" set wildignorecase
set ignorecase
set colorcolumn=80
set cursorline
" cursorcolumn cause performance issue
" set cursorcolumn
set ruler
set nowrap
set number relativenumber
set termguicolors
syntax enable
syntax on
set hidden
" fix terminal last line issue
let g:neoterm_autoscroll=1

" make search result middle
silent! nmap <silent><unique> n nzz<Plug>SearchIndex
silent! nmap <silent><unique> N Nzz<Plug>SearchIndex

silent! map <unique> *  <Plug>ImprovedStar_*zz<Plug>SearchIndex
silent! map <unique> #  <Plug>ImprovedStar_#zz<Plug>SearchIndex
silent! map <unique> g* <Plug>ImprovedStar_g*zz<Plug>SearchIndex
silent! map <unique> g# <Plug>ImprovedStar_g#zz<Plug>SearchIndex

set ttimeoutlen=100

set wildoptions=pum
set pumblend=20
set pumheight=15
set signcolumn=yes

" theme
let g:onedark_terminal_italics=1
colorscheme onedark

"reload file
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" key binding

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F5> :set hlsearch! hlsearch?<CR>

nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

nnoremap <M-=> <C-w>=

nnoremap <M-q> :q<CR>
nnoremap <M-w> :w<CR>

autocmd BufNewFile,BufRead *.h set ft=c

" -------------------whitespace----------------
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()
" ++++++++++++++++++whitespace++++++++++++++++

" --------------------- lightline begin ---------------------------
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }
"+++++++++++++++++++ light end +++++++++++++++++++++++++++++++++++

" --------------------------- lsp begin ---------------------------
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> gh :call <SID>show_documentation()<CR>
" Find symbol of current document
nnoremap <silent> gs  :<C-u>CocList outline<cr>

" Formatting selected code.
xmap <leader>=  <Plug>(coc-format-selected)
nmap <leader>=  <Plug>(coc-format-selected)

" Remap for rename current word
nmap <silent> <F2> <Plug>(coc-rename)

inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <c-space> coc#refresh()
" Escape: exit autocompletion, go to Normal mode
inoremap <silent><expr> <Esc> pumvisible() ? "\<C-e><Esc>" : "\<Esc>"

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
"++++++++++++++++++++++++++lsp end+++++++++++++++++++++++++

" ---------------------- leaderf begin -------------------------------
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_NoChdir=1
let g:Lf_RecurseSubmodules=1
let g:Lf_WindowPosition = 'popup'
let g:Lf_JumpToExistingWindow=0

let g:Lf_GtagsSource=2
let g:Lf_GtagsfilesCmd = {
    \ '.git': 'rg --no-messages --files -tc -tcpp',
    \ 'default': 'rg --no-messages --files -tc -tcpp'
    \}

let g:Lf_PreviewResult = { 'BufTag': 0 }

nmap <silent> <M-d> :<C-U>Leaderf gtags --by-context<CR>
" search word under cursor, the pattern is treated as regex, and enter normal mode directly
nnoremap <leader>g :<C-U><C-R>=printf("Leaderf rg -e %s ", expand("<cword>"))<CR>
nnoremap <leader>lg :<C-U><C-R>=printf("Leaderf rg %s -e %s ", expand("%:p:h"), expand("<cword>"))<CR>
nnoremap <leader>lf :<C-U><C-R>=printf("Leaderf file %s ", expand("%:p:h"))<CR><CR>
noremap <leader>t :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
" +++++++++++++++++++++ leaderf end +++++++++++++++++++++++++

"------------------------- nerdcommenter begin----------------------
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

let g:NERDCreateDefaultMappings = 0

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 0

map <M-c> <plug>NERDCommenterToggle

" +++++++++++++++++++++++nerdcommenter end ++++++++++++++++

" ------------------------glsl begin------------------------
autocmd! BufNewFile,BufRead *.vsh,*.fsh set ft=glsl
" ++++++++++++++++++++ glsl end +++++++++++++++++++++

" --------------------------easymotion start -----------------
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)
vmap s <Plug>(easymotion-s2)
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" ++++++++++++++++++++++++++easymotion end+++++++++++++++++++
