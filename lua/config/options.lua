vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_perl_provider = 0

local opt = vim.opt

opt.autowrite = false         -- enable auto write
opt.clipboard = "unnamedplus" -- sync with system clipboard
opt.cmdheight = 1
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 0           -- Hide * markup for bold and italic
opt.confirm = true             -- confirm to save changes before exiting modified buffer
opt.cursorcolumn = false
opt.cursorline = true          -- Enable highlighting of the current line
opt.expandtab = false          -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.foldenable = false
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.guifont = "FiraCode Nerd Font:h14"
-- opt.guifont = "Jetbrains Mono:h14"
opt.hidden = true          -- Enable modified buffers in background
opt.ignorecase = true      -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.joinspaces = false     -- No double spaces with join after a dot
opt.laststatus = 0
opt.list = false           -- Show some invisible characters (tabs...
opt.mouse = "a"            -- enable mouse mode
opt.number = true          -- Print line number
opt.numberwidth = 2
opt.pumblend = 10          -- Popup blend
opt.pumheight = 10         -- Maximum number of entries in a popup
opt.relativenumber = true  -- Relative line numbers
opt.ruler = false
opt.scrolloff = 4          -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true      -- Round indent
opt.shiftwidth = 2         -- Size of an indent
opt.showmode = false       -- dont show mode since we have a statusline
opt.shada = "!,'600,<50,s10,h"
opt.sidescrolloff = 8      -- Columns of context
opt.signcolumn = "yes"     -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true       -- Don't ignore case with capitals
opt.smartindent = true     -- Insert indents automatically
opt.spelllang = { "de_de,cjk", "en_us" }
opt.spell = false
opt.splitbelow = true    -- Put new windows below current
opt.splitright = true    -- Put new windows right of current
opt.tabstop = 2          -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.titlestring = [[%f %h%m%r%w %{v:progname}]]
opt.title = true
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200               -- save swap file and trigger CursorHold
opt.whichwrap:append("<>[]hl")
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5                -- minimum window width
opt.wrap = false                   -- Disable line wrap
vim.g.luasnippets_path = "~/.config/nvim/nvim/lua/snippets"
vim.g.neovide_refresh_rate = 60
if vim.call("hostname") == "archdesk" then
	vim.g.neovide_refresh_rate = 144
	-- vim.g.neovide_no_idle = true
end
if vim.fn.has("nvim-0.9.0") == 1 then
	opt.splitkeep = "screen"
	opt.shortmess = "filnxtToOFWIcC"
end

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0
