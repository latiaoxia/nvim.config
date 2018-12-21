call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tikhomirov/vim-glsl'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdcommenter'
" Plug 'Yggdroot/indentLine'
Plug 'majutsushi/tagbar'
Plug 'qpkorr/vim-bufkill'
Plug 'ntpeters/vim-better-whitespace'
Plug 'google/vim-searchindex'
" Plug 'tpope/vim-fugitive'

" Plug 'Valloric/YouCompleteMe'
"Plug 'rdnetto/YCM-Generator'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" " Multi-entry selection UI. FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

let mapleader=","
filetype plugin indent on
set expandtab
set softtabstop=8
set tabstop=8
set shiftwidth=8
set smartindent
set smartcase
" set wildignorecase
set ignorecase
set colorcolumn=80
set cursorline
set cursorcolumn
set ruler
set nowrap
set number relativenumber
set termguicolors
set pumheight=15
syntax enable
syntax on
"colorscheme dracula
let g:gruvbox_contrast_dark = 'soft'
set background=dark
colorscheme gruvbox
set hidden
set clipboard+=unnamedplus
set guicursor=
" fix terminal last line issue
let g:neoterm_autoscroll=1
" fix wrong terminal path
set shell=$HOME/.config/nvim/zshwrapper.sh
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F5> :set hlsearch! hlsearch?<CR>

"reload file
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

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
set splitbelow
set splitright
nnoremap <M-n> <C-w>n
nnoremap <M-v> :vnew<CR>
nnoremap <M-,> <C-PageUp>
nnoremap <M-.> <C-PageDown>
inoremap <M-n> <C-\><C-N><C-w>n
inoremap <M-v> <C-\><C-N>:vnew<CR>
inoremap <M-,> <C-\><C-n><C-PageUp>
inoremap <M-.> <C-\><C-n><C-PageDown>
tnoremap <M-n> <C-\><C-N><C-w>n
tnoremap <M-v> <C-\><C-N>:vnew<CR>
tnoremap <M-,> <C-\><C-n><C-PageUp>
tnoremap <M-.> <C-\><C-n><C-PageDown>

nnoremap <M-q> :q<CR>
nnoremap <M-w> :w<CR>
inoremap <M-q> <C-\><C-N>:q<CR>
inoremap <M-w> <C-\><C-N>:w<CR>
tnoremap <M-q> <C-\><C-N>:q<CR>

noremap <M-u> <C-U>
noremap <M-d> <C-D>
noremap <M-i> <C-i>
noremap <M-o> <C-o>
nnoremap <leader>d :BD!<CR>
nnoremap <leader>t :terminal<cr>a
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>
nnoremap <leader>tcd :tcd %:p:h<cr>:pwd<cr>
nnoremap <leader>lcd :lcd %:p:h<cr>:pwd<cr>

" disable terminal line number
au TermOpen * setlocal nonumber norelativenumber

" -------------------vim-better-whitespace----------------
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" --------------------- airline begin ---------------------------
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_theme = 'luna'

" enable/disable detection of whitespace errors
let g:airline#extensions#whitespace#enabled = 0

" Just show the filename (no path) in the tab
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = ''

let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
"airline end

" -----------------------------deoplete begin ---------------------------
let g:deoplete#enable_at_startup = 1
set completeopt-=preview

"use <tab> for completion
function! TabWrap()
    if pumvisible()
        return "\<C-N>"
    elseif strpart( getline('.'), 0, col('.') - 1 ) =~ '^\s*$'
        return "\<tab>"
    elseif &omnifunc !~ ''
        return "\<C-X>\<C-O>"
    else
        return "\<C-N>"
    endif
endfunction

" power tab
imap <silent><expr><tab> TabWrap()

" Enter: complete&close popup if visible (so next Enter works); else: break undo
inoremap <silent><expr> <Cr> pumvisible() ?
            \ deoplete#mappings#close_popup() : "<C-g>u<Cr>"

" Ctrl-Space: summon FULL (synced) autocompletion
inoremap <silent><expr> <C-Space> deoplete#mappings#manual_complete()

" Escape: exit autocompletion, go to Normal mode
inoremap <silent><expr> <Esc> pumvisible() ? "<C-e><Esc>" : "<Esc>"

" deoplete end

" --------------------------- lsp begin ---------------------------
let g:LanguageClient_serverCommands = {
    \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
    \ 'c': ['cquery', '--log-file=/tmp/cq.log'],
    \ }

let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_settingsPath = '$HOME/.config/nvim/settings.json'
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()

function LC_maps()
    if has_key(g:LanguageClient_serverCommands, &filetype)
        nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
        nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
        nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
        nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
        nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
    endif
endfunction
autocmd filetype * call LC_maps()

" lsp end

"----------------------- ycm begin -------------------------------
" let g:ycm_server_python_interpreter = '/usr/bin/python'
" " nnoremap <M-d> :YcmCompleter GoTo<CR>
" nnoremap <silent> gd :YcmCompleter GoTo<CR>
" nnoremap <silent> gh :YcmCompleter GetType<CR>

" set completeopt-=preview
" let g:ycm_cache_omnifunc=0
" let g:ycm_seed_identifiers_with_syntax=1

"ycm end

"------------------------- nerdcommenter begin----------------------
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

let g:NERDCreateDefaultMappings = 0

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

map <M-c> <plug>NERDCommenterToggle

"nerdcommenter end

"------------------ indentLine begin ------------------------
let g:indentLine_color_term = 239
let g:indentLine_conceallevel=2
"indentLine end

"------------------------tagbar begin------------------------
let tagbar_left=1
nnoremap <M-t> :TagbarToggle<CR>
let tagbar_width=32
let g:tagbar_compact=1
let g:tagbar_autoclose=1
let g:tagbar_sort=0
"tagbar end

" ------------------------glsl begin------------------------
autocmd! BufNewFile,BufRead *.vsh,*.fsh set ft=glsl
" glsl end
