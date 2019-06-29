call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tikhomirov/vim-glsl'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdcommenter'
Plug 'qpkorr/vim-bufkill'
Plug 'ntpeters/vim-better-whitespace'
Plug 'google/vim-searchindex'

Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
" " Multi-entry selection UI. FZF
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
 Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

call plug#end()

" Miscellaneous
let mapleader=" "
filetype plugin indent on
" set noexpandtab
" set softtabstop=8
" set tabstop=8
" set shiftwidth=8
set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4
set smartindent
set smartcase
set splitbelow
set splitright
" set wildignorecase
set ignorecase
set colorcolumn=80
set cursorline
set cursorcolumn
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

tnoremap <M-h> <C-\><C-N><C-w>h
tnoremap <M-j> <C-\><C-N><C-w>j
tnoremap <M-k> <C-\><C-N><C-w>k
tnoremap <M-l> <C-\><C-N><C-w>l
inoremap <M-h> <C-\><C-N><C-w>h
inoremap <M-j> <C-\><C-N><C-w>j
inoremap <M-k> <C-\><C-N><C-w>k
inoremap <M-l> <C-\><C-N><C-w>l
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
tnoremap <Esc> <C-\><C-n>

nnoremap <M-=> <C-w>=
inoremap <M-=> <C-\><C-N><C-w>=
tnoremap <M-=> <C-\><C-N><C-w>=
nnoremap <M-n> <C-w>n
nnoremap <M-v> :vnew<CR>
inoremap <M-n> <C-\><C-N><C-w>n
inoremap <M-v> <C-\><C-N>:vnew<CR>
tnoremap <M-n> <C-\><C-N><C-w>n
tnoremap <M-v> <C-\><C-N>:vnew<CR>

nnoremap <M-q> :q<CR>
nnoremap <M-w> :w<CR>
inoremap <M-q> <C-\><C-N>:q<CR>
inoremap <M-w> <C-\><C-N>:w<CR>
tnoremap <M-q> <C-\><C-N>:q<CR>

nnoremap <leader>t :terminal<cr>a
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>
nnoremap <leader>tcd :tcd %:p:h<cr>:pwd<cr>
nnoremap <leader>lcd :lcd %:p:h<cr>:pwd<cr>

" disable terminal line number
au TermOpen * setlocal nonumber norelativenumber

autocmd BufNewFile,BufRead *.h set ft=c

" -------------------vim-bufkill-----------------------
let g:BufKillCreateMappings=0
" nnoremap <leader>d :BD!<CR>
" +++++++++++++++++++vim-bufkill+++++++++++++++++++++

" -------------------vim-better-whitespace----------------
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_max_file_size=0
let g:strip_whitespace_confirm=0
" ++++++++++++++++++vim-better-whitespace++++++++++++++++

" --------------------- airline begin ---------------------------
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif


let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:airline#extensions#tabline#enabled = 1
" Just show the filename (no path) in the tab
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
"+++++++++++++++++++ airline end +++++++++++++++++++++++++++++++++++

" --------------------------- lsp begin ---------------------------
" Remap keys for gotos
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> gh :call <SID>show_documentation()<CR>
" Find symbol of current document
nnoremap <silent> gs  :<C-u>CocList outline<cr>

" Escape: exit autocompletion, go to Normal mode
inoremap <silent><expr> <Esc> pumvisible() ? "\<C-e><Esc>" : "\<Esc>"

"Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <silent> <F2> <Plug>(coc-rename)

"++++++++++++++++++++++++++lsp end+++++++++++++++++++++++++

" ---------------------- fzf begin -------------------------------
" nnoremap <silent> <leader>b :Buffers<CR>
" nnoremap <silent> <leader>f :Files<cr>
" +++++++++++++++++++++ fzf end +++++++++++++++++++++++++

" ---------------------- leaderf begin -------------------------------
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
nmap <silent> <M-d> :<C-U>Leaderf gtags --by-context<CR>
" search word under cursor, the pattern is treated as regex, and enter normal mode directly
nnoremap <leader>g :<C-U><C-R>=printf("Leaderf rg -e %s ", expand("<cword>"))<CR>
nnoremap <leader>lg :<C-U><C-R>=printf("Leaderf rg %s -e %s ", expand("%:p:h"), expand("<cword>"))<CR>
nnoremap <leader>lf :<C-U><C-R>=printf("Leaderf file %s ", expand("%:p:h"))<CR><CR>
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

