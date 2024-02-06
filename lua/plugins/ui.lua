return {
	{
		"lmburns/lf.nvim",
		dependencies = { "akinsho/toggleterm.nvim" },
		keys = {
			{ "<leader>e", "<cmd>Lf<cr>", desc = "lf file manager", remap = true },
		},
		event = "VeryLazy",
		config = function()
			-- This feature will not work if the plugin is lazy-loaded
			vim.g.lf_netrw = 1

			require("lf").setup({
				escape_quit = false,
				border = "rounded",
				-- height = vim.fn.float2nr(vim.fn.round(0.75 * vim.o.lines)), -- height of the *floating* window
				-- width = vim.fn.float2nr(vim.fn.round(0.75 * vim.o.columns)), -- width of the *floating* window
				width = math.floor(vim.o.columns * 1.5),
				height = math.floor(vim.o.lines * 0.75),
				-- width = function()
				-- 	return math.floor(vim.o.columns * 0.75)
				-- end,
				-- height = function()
				-- 	return math.floor(vim.o.lines * 0.75)
				-- end,
				-- height = vim.fn.float2nr(vim.fn.round(0.85 * vim.cmd.winheight)), -- height of the *floating* window
				-- width = vim.fn.float2nr(vim.fn.round(0.95 * vim.cmd.winwidth)), -- width of the *floating* window
			})
		end,
	},
	{
		"niuiic/git-log.nvim",
		dependencies = { "niuiic/core.nvim" },
		event = "BufReadPost",
	},
	{
		"Wansmer/symbol-usage.nvim",
		event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
		config = function()
			local function text_format(symbol)
				local fragments = {}

				if symbol.references then
					local usage = symbol.references <= 1 and "usage" or "usages"
					local num = symbol.references == 0 and "no" or symbol.references
					table.insert(fragments, ("%s %s"):format(num, usage))
				end

				if symbol.definition then
					table.insert(fragments, symbol.definition .. " defs")
				end

				if symbol.implementation then
					table.insert(fragments, symbol.implementation .. " impls")
				end

				return table.concat(fragments, ", ")
			end

			require("symbol-usage").setup({
				text_format = text_format,
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		enabled = true,
		event = "VeryLazy",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				always_show_bufferline = true,
			},
		},
	},
	{
		"Tyler-Barham/floating-help.nvim",
		config = function(_, opts)
			local fh = require("floating-help")

			fh.setup({
				-- Defaults
				width = 80, -- Whole numbers are columns/rows
				height = 0.9, -- Decimals are a percentage of the editor
				position = "NE", -- NW,N,NW,W,C,E,SW,S,SE (C==center)
			})

			-- Create a keymap for toggling the help window
			vim.keymap.set("n", "<F1>", fh.toggle)
			-- Create a keymap to search cppman for the word under the cursor
			vim.keymap.set("n", "<F2>", function()
				fh.open("t=cppman", vim.fn.expand("<cword>"))
			end)

			-- Only replace cmds, not search; only replace the first instance
			local function cmd_abbrev(abbrev, expansion)
				local cmd = "cabbr "
					.. abbrev
					.. ' <c-r>=(getcmdpos() == 1 && getcmdtype() == ":" ? "'
					.. expansion
					.. '" : "'
					.. abbrev
					.. '")<CR>'
				vim.cmd(cmd)
			end

			-- Redirect `:h` to `:FloatingHelp`
			cmd_abbrev("h", "FloatingHelp")
			cmd_abbrev("help", "FloatingHelp")
			cmd_abbrev("helpc", "FloatingHelpClose")
			cmd_abbrev("helpclose", "FloatingHelpClose")
		end,
	},
	{
		"luckasRanarison/nvim-devdocs",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			dir_path = vim.fn.stdpath("data") .. "/devdocs", -- installation directory
			telescope = {}, -- passed to the telescope picker
			telescope_alt = { -- when searching globally without preview
				layout_config = {
					width = 75,
				},
			},
			float_win = { -- passed to nvim_open_win(), see :h api-floatwin
				relative = "editor",
				height = 25,
				width = 100,
				border = "rounded",
			},
			wrap = false, -- text wrap
			previewer_cmd = "glow", -- for example: "glow"
			cmd_args = { "-s", "dark", "-w", "80" },
			picker_cmd = true,
			picker_cmd_args = { "-p" },
			ensure_installed = {
				"numpy-1.23",
				"python-3.11",
				"matplotlib-3.7",
				"bash",
				"git",
				"rust",
				"lua-5.4",
				"latex",
			}, -- get automatically installed
		},
	},
	{ --Smooth scrolling in terminal
		"declancm/cinnamon.nvim",
		event = "VeryLazy",
		opts = {
			extended_keymaps = true,
		},
	},
	{ -- Hexadecimal coloring
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			filetypes = { "*", "!lazy" },
			buftype = { "*", "!prompt", "!nofile" },
			user_default_options = {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = false, -- "Name" codes like Blue
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				AARRGGBB = false, -- 0xAARRGGBB hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes: foreground, background
				-- Available modes for `mode`: foreground, background,  virtualtext
				mode = "background", -- Set the display mode.
				virtualtext = "■",
			},
		},
	},
	{ --Theme
		"navarasu/onedark.nvim",
		version = false,
		lazy = true,
		opts = {
			style = "deep",
			-- transparent = true,
			toggle_style_key = "<leader>od", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
			toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between
			colors = {
				od_grey = "#494d55",
			}, -- Override default colors
			highlights = {
				["@comment"] = { fg = "$od_grey" },
			}, -- Override highlight groups
		},
	},
	{ --Theme
		"folke/tokyonight.nvim",
		version = false,
		lazy = true,
	},
	{ --colorscheme setting
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "onedark",
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = { spelling = true },
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register({
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["gz"] = { name = "+surround" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader><tab>"] = { name = "+tabs" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>c"] = { name = "+code" },
				["<leader>d"] = { name = "+debug" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				["<leader>gh"] = { name = "+hunks" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>s"] = { name = "+search" },
				["<leader>sn"] = { name = "+noice" },
				["<leader>u"] = { name = "+ui" },
				["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			window = {
				position = "right",
			},
		},
		keys = {

			{ "<leader>fe", false },
			{ "<leader>fE", false },
			{ "<leader>e", false },
			{ "<leader>E", false },
		},
		filesystem = {
			bind_to_cwd = false,
			follow_current_file = true,
			window = {
				mappings = {
					["<space>"] = "none",
					["o"] = "system_open",
				},
			},
			commands = {
				system_open = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					vim.api.nvim_command("silent !open -g " .. path)
					vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
				end,
			},
		},
		commands = {
			system_open = function(state)
				local node = state.tree:get_node()
				local path = node:get_id()
				vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
			end,
		},
	},
	{
		"nguyenvukhang/nvim-toggler",
		config = true,
		keys = {
			{
				"<leader>i",
				function()
					require("nvim-toggler").toggle()
				end,
				desc = "Invert bool",
				remap = true,
			},
		},
	},
	{
		"chrisbra/csv.vim",
		ft = "csv",
	},
}
