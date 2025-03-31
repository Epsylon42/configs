vim.cmd [[
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
]]

vim.cmd [[
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

    set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz,І;S,і;s
]]

vim.cmd [[
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
]]

vim.g.airline_powerline_fonts = 1
vim.g.rainbow_active = 1
vim.g.vim_json_conceal=0

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
    spec = {
        {
            'dracula/vim',
            config = function()
                vim.cmd [[ colorscheme dracula ]]
            end
        },
        'jiangmiao/auto-pairs',
        'vim-airline/vim-airline',
        'vim-airline/vim-airline-themes',
        'tpope/vim-surround',
        'preservim/nerdcommenter',
        'airblade/vim-gitgutter',
        'machakann/vim-swap',
        'Yggdroot/indentLine',
        'chrisbra/Colorizer',

        'sindrets/diffview.nvim',
        {
            'nvim-neo-tree/neo-tree.nvim',
            lazy = false,
            dependencies = {
                'nvim-lua/plenary.nvim',
                'nvim-tree/nvim-web-devicons',
                'MunifTanjim/nui.nvim',
            },
            opts = {
                sources = {
                    "filesystem",
                    "buffers",
                    "git_status",
                },
                window = {
                    mappings = {
                        ["/"] = "none",
                        --["<C-/>"] = "fuzzy_finder",
                    }
                },
            }
        },
        {
            'folke/trouble.nvim',
            opts = {
                warn_no_results = false,
                open_no_results = true,
                keys = {
                    D = {
                        action = function()
                            vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
                        end,
                        desc = 'Toggle multiline diagnostics'
                    },
                }
            },
            cmd = 'Trouble',
            keys = {
                {
                    '<leader>d',
                    '<cmd>Trouble diagnostics toggle<CR>'
                },
            }
        },
        {
            'nvim-telescope/telescope.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
            },
            config = function()
                local actions = require('telescope.actions')
                require('telescope').setup {
                    defaults = {
                        mappings = {
                            i = {
                                ['<C-q>'] = actions.close
                            },
                            n = {
                                ['q'] = actions.close
                            },
                        }
                    }
                }
            end
        },

        {
            'smoka7/hop.nvim',
            config = function()
                require('hop').setup {}
            end
        },

        -- languages
        'othree/html5.vim',
        'alvan/vim-closetag',
        'tmhedberg/matchit',

        'MeanderingProgrammer/render-markdown.nvim',

        {
            'nvim-treesitter/nvim-treesitter',
            config = function()
                require('nvim-treesitter.configs').setup {
                    ensure_installed = { 'wgsl', 'glsl' },
                    highlight = { enable = true },
                    indent = { enable = true },
                }
            end
        },

        -- completion
        {
            'neovim/nvim-lspconfig',
        },
        {
            'williamboman/mason.nvim',
        },
        {
            'williamboman/mason-lspconfig.nvim',
            dependencies = {
                'hrsh7th/cmp-nvim-lsp',
                'williamboman/mason.nvim',
                'neovim/nvim-lspconfig',
            },
            config = function()
                local capabilities = require('cmp_nvim_lsp').default_capabilities()

                require('mason').setup()
                require("mason-lspconfig").setup()
                require("mason-lspconfig").setup_handlers {
                    function (server_name) -- default handler (optional)
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities
                        }
                    end,

                    ["glslls"] = function()
                        require('lspconfig').glslls.setup({
                            cmd = { "glslls", "--stdin", "--target-env=opengl" },
                            capabilities = capabilities
                        })
                    end
                }
            end
        },
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-nvim-lsp-signature-help',
            },
            config = function()
                local cmp = require('cmp')
                cmp.setup({
                    completion = { completeopt = 'menu,menuone,noinsert,noselect' },
                    mapping = cmp.mapping.preset.insert {
                        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-f>'] = cmp.mapping.scroll_docs(4),
                        ['<C-Space>'] = cmp.mapping.complete {},
                        ['<CR>'] = cmp.mapping.confirm {
                          behavior = cmp.ConfirmBehavior.Replace,
                          select = true,
                        },
                        ['<Tab>'] = cmp.mapping(function(fallback)
                          if cmp.visible() then
                            cmp.select_next_item()
                          else
                            fallback()
                          end
                        end, { 'i', 's' }),
                        ['<S-Tab>'] = cmp.mapping(function(fallback)
                          if cmp.visible() then
                            cmp.select_prev_item()
                          else
                            fallback()
                          end
                        end, { 'i', 's' }),
                    },

                    sources = {
                        { name = 'nvim_lsp' },
                        { name = 'path' },
                        { name = 'buffer' },
                        { name = 'nvim_lsp_signature_help' },
                    }
                })
            end
        },
    },
    --install = { colorscheme = { "habamax" } },
    checker = { enabled = true },
}

vim.cmd [[
    nnoremap <silent> <leader>f :Neotree toggle<CR>
    nnoremap <silent> <leader>v :Neotree reveal<CR>
    nnoremap <silent> <leader>b :Neotree toggle buffers right<CR>
    nnoremap <silent> <leader>s :Neotree toggle git_status right<CR>

    nmap <M-w> :HopWordAC<CR>
    nmap <M-b> :HopWordBC<CR>
    nmap <M-S-w> :HopWordBC<CR>
    nmap <M-c> :HopChar1<CR>
    nmap <M-s> :HopLineStart<CR>

    nnoremap <silent> <leader>Do :DiffviewOpen<CR>
    nnoremap <silent> <leader>Dc :DiffviewClose<CR>
    nnoremap <silent> <leader>Dh :DiffviewFileHistory<CR>
    nnoremap <silent> <leader>DH :DiffviewFileHistory %<CR>

    nnoremap <silent> <leader>= :lua vim.lsp.buf.format()<CR>
    nnoremap <silent> <leader>ca :lua vim.lsp.buf.code_action()<CR>

    nnoremap <silent> gd :Telescope lsp_definitions<CR>
    nnoremap <silent> gD :Telescope lsp_declarations<CR>
    nnoremap <silent> gi :Telescope lsp_implementations<CR>
    nnoremap <silent> gr :Telescope lsp_references<CR>
]]

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
})
