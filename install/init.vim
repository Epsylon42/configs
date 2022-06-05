call plug#begin('~/.config/nvim/plugins')

Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-surround'
Plug 'vim-scripts/DrawIt'
Plug 'preservim/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'preservim/nerdtree'
nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-swap'
Plug 'Yggdroot/indentLine'

Plug 'othree/html5.vim'
Plug 'alvan/vim-closetag'
Plug 'tmhedberg/matchit'

Plug 'posva/vim-vue'
Plug 'evanleck/vim-svelte'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'ron-rs/ron.vim'
Plug 'salpalvv/vim-gluon'
Plug 'tikhomirov/vim-glsl'
Plug 'rust-lang/rust.vim'
Plug 'calviken/vim-gdscript3'
Plug 'cespare/vim-toml'
Plug 'chrisbra/Colorizer'
Plug 'Freedzone/kerbovim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'colepeters/spacemacs-theme.vim'
Plug 'dracula/vim', {'name':'dracula'}
Plug 'nightsense/strawberry'

Plug 'easymotion/vim-easymotion'
map <Leader> <Plug>(easymotion-prefix)
map <Leader>l <Plug>(easymotion-bd-jk)
let g:EasyMotion_smartcase = 1

call plug#end()

if (has("termguicolors"))
    set termguicolors
endif
if $TERM == 'linux'
    colorscheme dracula
else
    {{{ colors }}}
endif

set tabstop=4
set shiftwidth=4
set softtabstop=1
set expandtab
set smarttab

set undofile
set undodir=~/.config/nvim/undodir

set ignorecase
set smartcase
set inccommand=nosplit
set linebreak

set clipboard=unnamedplus

au! BufNewFile,BufRead *.mst setlocal filetype=html
au! FileType gdscript3 setlocal noexpandtab

let g:vim_json_conceal=0

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

"paste from clipboard in insert mode
inoremap <C-y> <Esc>"+pa

"exit to command mode in terminal
tnoremap <Esc> <C-\><C-n>

" exit editing mode
inoremap fd <Esc>

" window navigation
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
nnoremap <M-Left> <C-w>h
nnoremap <M-Down> <C-w>j
nnoremap <M-Up> <C-w>k
nnoremap <M-Right> <C-w>l

" single press tabs and commenting
vmap <Tab> >Vgv
vmap <S-Tab> <Vgv
vmap <M-c> <Leader>c<Space>Vgv

" move lines
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv
vnoremap <C-k> :m '<-2<CR>gv

" delete function
nmap dF dt(ds)

" coc settings
runtime coc.vim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz,І;S,і;s

function Clear_regs()
    let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"' | 
    let i=0 | 
    while (i<strlen(regs)) | 
        exec 'let @'.regs[i].'=""' | 
        let i=i+1 | 
    endwhile | 
    unlet regs
endfunction

" Refresh window size. Necessary in some terminals
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
