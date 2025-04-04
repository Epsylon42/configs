vim.cmd [[
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set smarttab

    set undofile
    set undodir=~/.config/nvim/undodir

    set ignorecase
    set smartcase

    set number
    set scrolloff=5
    set inccommand=nosplit
    set linebreak

    set clipboard=unnamedplus

    set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz,ІЄ;S\",іє;s\',ʼ;~
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

    " do not immediately jump to next find
    nnoremap * :keepjumps normal! mi*`i<CR>
    nnoremap # :keepjumps normal! mi#`i<CR>

    " window navigation
    nnoremap <M-h> <C-w>h
    nnoremap <M-j> <C-w>j
    nnoremap <M-k> <C-w>k
    nnoremap <M-l> <C-w>l
    nnoremap <M-Left> <C-w>h
    nnoremap <M-Down> <C-w>j
    nnoremap <M-Up> <C-w>k
    nnoremap <M-Right> <C-w>l

    " tab offsets
    vmap <Tab> >Vgv
    vmap <S-Tab> <Vgv

    " move lines
    nnoremap <C-j> :m .+1<CR>==
    nnoremap <C-k> :m .-2<CR>==
    vnoremap <C-j> :m '>+1<CR>gv
    vnoremap <C-k> :m '<-2<CR>gv

    " delete function
    nmap dF dt(ds)
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

-- tabs
for i=1,9 do
    vim.keymap.set('n', '<M-'..tostring(i)..'>', tostring(i)..'gt', { silent = true })
    vim.keymap.set('t', '<M-'..tostring(i)..'>', '<C-\\><C-n>'..tostring(i)..'gt', { silent = true })
end
vim.keymap.set('n', '<C-t>', ':tabnew<CR>', { silent = true })
vim.keymap.set('n', '<C-w><C-t>', ':tabclose<CR>', { silent = true })

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
        'nvim-tree/nvim-web-devicons',
        {
            'Wansmer/langmapper.nvim',
            lazy = false,
            priority = 1,
            opts = {}
        },

        'folke/tokyonight.nvim',
        {
            'dracula/vim'
            -- 'Mofiqul/dracula.nvim',
        },
        'nightsense/strawberry',
        {
            'nvim-lualine/lualine.nvim',
            opts = {
                sections = {
                    lualine_x = {
                        'encoding',
                        {
                            'lsp_status',
                            icon = '', -- f013
                            symbols = {
                                -- Standard unicode symbols to cycle through for LSP progress:
                                spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                                -- Standard unicode symbol for when LSP is done:
                                done = '✓',
                                -- Delimiter inserted between LSP names:
                                separator = ' ',
                            },
                            -- List of LSP names to ignore (e.g., `null-ls`):
                            ignore_lsp = {},
                        },
                        'filetype',
                    },
                }
            }
        },
        'machakann/vim-swap',
        'Yggdroot/indentLine',
        'chrisbra/Colorizer',
        {
            'windwp/nvim-autopairs',
            event = 'InsertEnter',
            config = true,
            opts = {}
        },
        {
            'kylechui/nvim-surround',
            event = 'VeryLazy',
            opts = {}
        },
        {
            'numToStr/Comment.nvim',
            opts = {}
        },
        {
            'smoka7/hop.nvim',
            opts = {}
        },

        {
            'nanozuki/tabby.nvim',
            config = function()
                vim.o.showtabline = 2
                for i=1,10 do
                    vim.keymap.set('n', '<M-' .. tostring(i) .. '>', tostring(i) .. 'gt')
                end

                local theme = {
                    fill = 'TabLineFill',
                    -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
                    head = 'TabLine',
                    current_tab = 'TabLineSel',
                    tab = 'TabLine',
                    win = 'TabLine',
                    tail = 'TabLine',
                }

                require('tabby').setup({
                    line = function(line)
                        return {
                            {
                                { '  ', hl = theme.head },
                                line.sep('', theme.head, theme.fill),
                            },
                            line.tabs().foreach(function(tab)
                                local hl = tab.is_current() and theme.current_tab or theme.tab
                                return {
                                    line.sep('', hl, theme.fill),
                                    tab.is_current() and '' or '',
                                    tab.number(),
                                    tab.name(),
                                    line.sep('', hl, theme.fill),
                                    hl = hl,
                                    margin = ' ',
                                }
                            end),
                            --line.spacer(),
                            --{
                                --line.sep('', theme.tail, theme.fill),
                                --{ '  ', hl = theme.tail },
                            --},
                            hl = theme.fill,
                        }
                    end,
                    -- option = {}, -- setup modules' option,
                })
            end
        },
        'sindrets/diffview.nvim',
        {
            'Epsylon42/neo-tree.nvim',
            branch = 'my-improvements',
            lazy = false,
            dependencies = {
                'nvim-lua/plenary.nvim',
                'nvim-tree/nvim-web-devicons',
                'MunifTanjim/nui.nvim',
            },
            opts = {
                sources = {
                    'filesystem',
                    'buffers',
                    'git_status',
                },
                window = {
                    mappings = {
                        ['/'] = 'none',
                        ['u'] = 'navigate_up',
                        ['c'] = {
                            'copy',
                            config = {
                                show_path = 'relative'
                            }
                        },
                        ['m'] = {
                            'move',
                            config = {
                                show_path = 'relative'
                            }
                        },
                        --["<C-/>"] = "fuzzy_finder",
                    }
                },
                use_popups_for_input = false,
                filesystem = {
                    group_empty_dirs = true,
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
            lazy = true,
            cmd = 'Telescope',
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

        -- git
        {
            'NeogitOrg/neogit',
            dependencies = {
                'nvim-lua/plenary.nvim',
                'sindrets/diffview.nvim',
                'nvim-telescope/telescope.nvim',
            },
            lazy = true,
            cmd = 'Neogit',
            opts = {}
        },
        {
            'lewis6991/gitsigns.nvim',
            opts = {
                signs = {
                    add          = { text = '┃' },
                    change       = { text = '┃' },
                    delete       = { text = '-' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '┃' },
                    untracked    = { text = '┆' },
                },
                signs_staged = {
                    add          = { text = '┃' },
                    change       = { text = '┃' },
                    delete       = { text = '-' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '┃' },
                    untracked    = { text = '┆' },
                },
            }
        },

        -- languages
        'othree/html5.vim',
        'alvan/vim-closetag',
        'tmhedberg/matchit',

        'MeanderingProgrammer/render-markdown.nvim',
        {
            'epwalsh/obsidian.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
            },
            lazy = true,
            ft = 'markdown',
            config = function()
                local loaded, workspaces = pcall(require, 'obsidian-workspaces')
                require('obsidian').setup {
                    disable_frontmatter = true,
                    workspaces = loaded and workspaces or {}
                }
            end
        },

        {
            'nvim-treesitter/nvim-treesitter',
            config = function()
                require('nvim-treesitter.configs').setup {
                    ensure_installed = { 'wgsl', 'glsl' },
                    auto_install = true,
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
                require('mason-lspconfig').setup()
                require('mason-lspconfig').setup_handlers {
                    function (server_name) -- default handler (optional)
                        require("lspconfig")[server_name].setup {
                            capabilities = capabilities
                        }
                    end,

                    ['glslls'] = function()
                        require('lspconfig').glslls.setup {
                            cmd = { "glslls", "--stdin", "--target-env=opengl" },
                            capabilities = capabilities
                        }
                    end,
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
                cmp.setup {
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
                }

                cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
            end
        },
    },
    --install = { colorscheme = { "habamax" } },
    --checker = { enabled = true },
}

local function setup_colors()
    local colors = { -- copied from Mofiqul/dracula.nvim
        bg = "#282A36",
        fg = "#F8F8F2",
        selection = "#44475A",
        comment = "#6272A4",
        red = "#FF5555",
        orange = "#FFB86C",
        yellow = "#F1FA8C",
        green = "#50fa7b",
        purple = "#BD93F9",
        cyan = "#8BE9FD",
        pink = "#FF79C6",
        bright_red = "#FF6E6E",
        bright_green = "#69FF94",
        bright_yellow = "#FFFFA5",
        bright_blue = "#D6ACFF",
        bright_magenta = "#FF92DF",
        bright_cyan = "#A4FFFF",
        bright_white = "#FFFFFF",
        menu = "#21222C",
        visual = "#3E4452",
        gutter_fg = "#4B5263",
        nontext = "#3B4048",
        white = "#ABB2BF",
        black = "#191A21",
    }
    local util = require('tokyonight.util')

    local blend_bg = function(color, factor)
        return util.blend(color, factor, util.darken(colors.menu, 0.5))
    end

    local overrides =  {
        DiffAdd = { bg = util.darken(colors.bright_green, 0.15) },
        DiffDelete = { fg = colors.bright_red },
        DiffChange = { bg = blend_bg(colors.cyan, 0.2) },
        DiffText = { bg = util.darken(colors.cyan, 0.45) },
        illuminatedWord = { bg = blend_bg(colors.comment, 0.65) },
        illuminatedCurWord = { bg = blend_bg(colors.comment, 0.65) },
        IlluminatedWordText = { bg = blend_bg(colors.comment, 0.65) },
        IlluminatedWordRead = { bg = blend_bg(colors.comment, 0.65) },
        IlluminatedWordWrite = { bg = blend_bg(colors.comment, 0.65) },

        GitSignsAdd = { fg = colors.green, },
        GitSignsChange = { fg = colors.cyan, },
        GitSignsDelete = { fg = colors.bright_red, },
        GitSignsAddLn = { fg = colors.black, bg = colors.green, },
        GitSignsChangeLn = { fg = colors.black, bg = colors.cyan, },
        GitSignsDeleteLn = { fg = colors.black, bg = colors.bright_red, },
        GitSignsCurrentLineBlame = { fg = colors.white, },
    }

    for hl,value in pairs(overrides) do
        vim.api.nvim_set_hl(0, hl, value)
    end
end

if vim.env.TERM == 'linux' then
    vim.cmd [[ colorscheme dracula ]]
else
    vim.cmd [[
        {{{ colors }}}
    ]]
end
setup_colors()


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

    nnoremap <silent> <leader>DO :DiffviewOpen<CR>
    nnoremap <silent> <leader>DC :DiffviewClose<CR>
    nnoremap <silent> <leader>DH :DiffviewFileHistory<CR>
    nnoremap <silent> <leader>Dh :DiffviewFileHistory %<CR>

    nnoremap <silent> <leader>= :lua vim.lsp.buf.format()<CR>
    nnoremap <silent> <leader>ca :lua vim.lsp.buf.code_action()<CR>

    nnoremap <silent> gd :Telescope lsp_definitions<CR>
    nnoremap <silent> gD :Telescope lsp_declarations<CR>
    nnoremap <silent> gi :Telescope lsp_implementations<CR>
    nnoremap <silent> gr :Telescope lsp_references<CR>

    nnoremap <silent> <leader>gg :Neogit<CR>
    nnoremap <silent> <leader>gh :Gitsigns preview_hunk_inline<CR>
    nnoremap <silent> <leader>gH :Gitsigns preview_hunk<CR>
    nnoremap <silent> <leader>gs :Gitsigns stage_hunk<CR>
    nnoremap <silent> <leader>gb :Gitsigns blame<CR>
]]

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
})

local function cmdline_langmap()
    local langmap = {}
    for _,part in pairs(vim.opt.langmap:get()) do
        local pair = vim.fn.split(part, ';')
        for i = 1, math.min(vim.fn.strchars(pair[1]), vim.fn.strchars(pair[2])) do
            local from = vim.fn.strcharpart(pair[1], i-1, 1)
            local to   = vim.fn.strcharpart(pair[2], i-1, 1)
            langmap[from] = to
        end
    end

    vim.api.nvim_create_augroup('CyrillicCommandMap', { clear = true })

    local function apply_mappings()
        for from, to in pairs(langmap) do
            vim.api.nvim_set_keymap('c', from, to, { noremap = true })
        end
    end

    local function clear_mappings()
        for from, _ in pairs(langmap) do
            pcall(function() vim.api.nvim_del_keymap('c', from) end)
        end
    end

    vim.api.nvim_create_autocmd('CmdlineEnter', {
        group = 'CyrillicCommandMap',
        callback = function(evt)
            if evt.match == ':' then
                apply_mappings()
            end
        end
    })

    vim.api.nvim_create_autocmd('CmdlineLeave', {
        group = 'CyrillicCommandMap',
        callback = function()
            clear_mappings()
        end
    })
end

cmdline_langmap()

require('langmapper').automapping({ global = true, buffer = true })
