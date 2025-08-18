call plug#begin()

Plug 'rebelot/kanagawa.nvim'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'rose-pine/neovim', {'as': 'rose-pine'}
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'tpope/vim-surround'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'windwp/nvim-autopairs'
Plug 'lervag/vimtex'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'goolord/alpha-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'brianhuster/live-preview.nvim'
Plug 'vimwiki/vimwiki'

call plug#end()

set encoding=UTF-8
set number
set mouse=a
set ignorecase
set smartcase
set autoindent
set smartindent
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set nohlsearch
set updatetime=300
set nocompatible
filetype plugin on
syntax on
filetype plugin indent on
syntax enable

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-p> :Telescope find_files<CR>
nnoremap <leader>h :nohlsearch<CR>
nnoremap <leader>m :LivePreview start<CR>


nnoremap <leader>t :ToggleTerm<CR>
inoremap <leader>t <C-\><C-n>:ToggleTerm<CR>

lua << EOF
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'kanagawa',
    component_separators = { '', '' },
    section_separators = { '', '' },
    disabled_filetypes = {
      'alpha',
      'NvimTree',
      'Outline',
    },
    always_last_status = 0,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {'nvim-tree', 'toggleterm'},
})

require("toggleterm").setup({
  size = 20,
  open_mapping = [[<leader>t]],
  hide_numbers = true,
  direction = 'float',
  float_opts = {
    border = 'curved',
    winblend = 3,
    height = 30, 
    width = 80,
    row = nil,
    col = nil,
  },
})

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 't', '<leader>t', '<C-\\><C-n>:ToggleTerm<CR>', { noremap = true, silent = true })
  end
})

require("nvim-autopairs").setup {}

vim.cmd("colorscheme kanagawa")
vim.o.cursorline = true

require("catppuccin").setup({
  flavour = "macchiato",
  background = {
    light = "latte",
    dark = "macchiato",
  },
  transparent_background = false,
  show_compatibility = false,
  integrations = {
    cmp = false,
    gitsigns = true,
    nvimtree = true,
    telescope = true,
    notify = false,
    mini = {
      enabled = true,
      indentscope = {
        mappings = {
          object_scope = "ik",
          next_scope = "]k",
          prev_scope = "[k",
        },
      },
    },
  },
})

require("rose-pine").setup({
  variant = "main",
  dark_variant = "main",
  bold_vert_split = false,
  dim_inactive_windows = false,
  disable_background = false,
  disable_float_background = false,
  disable_italics = false,
  extend_background_behind_borders = true,

  enable = {
    terminal = true,
    markdown = true,
    auto_toggle = false,
  },

  integrations = {
    cmp = false,
    gitsigns = true,
    nvimtree = true,
    telescope = true,
    toggleterm = true,
    lsp_trouble = true,
    barbar = true,
    markdown = true,
    which_key = true,
    semantic_tokens = true,
    valere = true,
  },
})

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
[[neovim]]
}

dashboard.section.buttons.val = {
  dashboard.button("n", "  Novo arquivo", ":ene <BAR> startinsert<CR>"),
  dashboard.button("f", "  Buscar arquivos", ":Telescope find_files<CR>"),
  dashboard.button("r", "  Recentes", ":Telescope oldfiles<CR>"),
  dashboard.button("c", "  Configurações", ":e $HOME/.config/nvim/init.vim<CR>"),
  dashboard.button("q", "  Sair", ":qa<CR>"),
}

dashboard.section.footer.val = "I fight for the users"

dashboard.section.buttons.opts.hl = "Keyword"
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"

alpha.setup(dashboard.opts)

require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "cpp", "python", "javascript", "html", "css", "ruby", "rust", "lua", "vim", "markdown", "markdown_inline", "bash" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
})

require('live-preview').setup({
  vim.api.nvim_create_autocmd({ 'InsertLeavePre', 'TextChanged', 'TextChangedP' }, {
    pattern = '*.md',
    callback = function() vim.cmd('silent! write') end
  })
})

vim.opt.conceallevel = 2
vim.opt.concealcursor = 'n'
EOF
