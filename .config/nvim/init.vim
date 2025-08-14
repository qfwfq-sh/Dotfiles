call plug#begin()

Plug 'rebelot/kanagawa.nvim'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'tpope/vim-surround'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'windwp/nvim-autopairs'
Plug 'lervag/vimtex'
Plug 'goolord/alpha-nvim'

call plug#end()

set encoding=UTF-8
set number

colorscheme kanagawa

nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <silent><C-l> <Cmd>exe v:count1 . "ToggleTerm"<CR>

filetype plugin indent on
syntax enable

let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexmk'

colorscheme kanagawa
highlight Normal guibg=#000000
highlight NormalNC guibg=#000000
highlight NormalFloat guibg=#000000
highlight Pmenu guibg=#000000

highlight LineNr guibg=#000000
highlight CursorLineNr guibg=#000000

lua << END
require('lualine').setup()
require("toggleterm").setup()
require("nvim-autopairs").setup {}
vim.o.cursorline = true

require("kanagawa").setup({
  overrides = function(colors)
    return {
      Normal         = { bg = "#000000" },
      NormalFloat    = { bg = "#000000" },
      FloatBorder    = { bg = "#000000" },
      Pmenu          = { bg = "#000000" },
      LineNr         = { fg = colors.dimmed3, bg = "#000000" },
      CursorLine     = { bg = "#1a1a1a" },
      CursorLineNr   = { fg = "#ffffff", bg = "#1a1a1a", bold = true },
    }
  end,
})

vim.cmd("colorscheme kanagawa")

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {

	[[       ████ ██████           █████      ██                     ]],
	[[      ███████████             █████                             ]],
	[[      █████████ ███████████████████ ███   ███████████   ]],
	[[     █████████  ███    █████████████ █████ ██████████████   ]],
	[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
	[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
	[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
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

END
