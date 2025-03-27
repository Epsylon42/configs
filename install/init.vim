call plug#begin('~/.config/nvim/plugins')

Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-surround'
Plug 'vim-scripts/DrawIt'
Plug 'preservim/nerdcommenter'

Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-swap'
Plug 'Yggdroot/indentLine'

Plug 'othree/html5.vim'
Plug 'alvan/vim-closetag'
Plug 'tmhedberg/matchit'

Plug 'DingDean/wgsl.vim'

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

Plug 'smoka7/hop.nvim'
nmap <M-w> :HopWordAC<CR>
nmap <M-b> :HopWordBC<CR>
nmap <M-S-w> :HopWordBC<CR>
nmap <M-c> :HopChar1<CR>
nmap <M-s> :HopLineStart<CR>

Plug 'lervag/wiki.vim'
Plug 'lervag/wiki-ft.vim'
let g:wiki_root = '~/med/log/ve_notes'
nmap <Leader>wt :WikiTagList<CR>
nmap <Leader>wb :WikiGraphFindBacklinks<CR>
nmap <Leader>wo :WikiFzfPages<CR>

Plug 'dkarter/bullets.vim'
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'wiki',
    \]

Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

Plug 'mkotha/conflict3'

Plug 'kaarmu/typst.vim'

Plug 'neovim/nvim-lspconfig'

Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'sindrets/diffview.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim'

call plug#end()

lua << EOF
require('hop').setup()
require("neo-tree").setup({
    window = {
        mappings = {
            ["/"] = "none",
            --["<C-/>"] = "fuzzy_finder",
        }
    },
})

EOF

nnoremap <silent> <Leader>f :Neotree toggle<cr>
nnoremap <silent> <Leader>v :Neotree reveal<cr>
nnoremap <silent> <Leader>b :Neotree toggle buffers right<cr>
nnoremap <silent> <Leader>s :Neotree toggle git_status right<cr>

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

"save file
nnoremap <C-s> :w<CR>

"paste from clipboard in insert mode
inoremap <C-y> <Esc>"+pa

"exit to command mode in terminal
tnoremap <Esc> <C-\><C-n>

" exit editing mode
inoremap fd <Esc>

" clear search
nnoremap <silent> <C-n> :noh<CR>

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

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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
autocmd SwapExists * :let v:swapchoice = ''
