return {
	{
		"ashinkarov/nvim-agda",
		enabled = false,
		filetype = "agda",
		config = true,
	},
	{
		"NeogitOrg/neogit",
		dependencies = "nvim-lua/plenary.nvim",
		opts = {
			kind = "auto",
		},
		config = true,
		keys = {
			{
				"<leader>gg",
				function()
					require("util").neogit()
				end,
				desc = "Neogit",
				remap = true,
			},
		},
	},
	{
		"sindrets/diffview.nvim",
		config = true,
		-- event = "BufEnter",
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git diff", remap = true },
		},
	},
	{
		"nvim-orgmode/orgmode",
		ft = "org",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("orgmode").setup_ts_grammar()

			-- Treesitter configuration
			require("nvim-treesitter.configs").setup({
				-- If TS highlights are not enabled at all, or disabled via `disable` prop,
				-- highlighting will fallback to default Vim syntax highlighting
				highlight = {
					enable = true,
					-- Required for spellcheck, some LaTex highlights and
					-- code block highlights that do not have ts grammar
					additional_vim_regex_highlighting = { "org" },
				},
				ensure_installed = { "org" }, -- Or run :TSUpdate org
			})

			require("orgmode").setup({
				-- org_agenda_files = { "~/Dropbox/org/*", "~/my-orgs/**/*" },
				-- org_default_notes_file = "~/Dropbox/org/refile.org",
			})
		end,
	},
	{ -- This plugin
		"Zeioth/compiler.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		dependencies = { "stevearc/overseer.nvim" },
		opts = {},
	},
	{ -- The task runner we use
		"stevearc/overseer.nvim",
		commit = "19aac0426710c8fc0510e54b7a6466a03a1a7377",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		opts = {
			task_list = {
				direction = "bottom",
				min_height = 25,
				max_height = 25,
				default_detail = 1,
				bindings = {
					["q"] = function()
						vim.cmd("OverseerClose")
					end,
				},
			},
		},
	},
	{
		"HakonHarnes/img-clip.nvim",
		event = "BufEnter",
		opts = {
			-- add options here
			-- or leave it empty to use the default settings
		},
		keys = {
			-- suggested keymap
			{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
		},
	},
	{ --Paste images from clipboard
		"postfen/clipboard-image.nvim",
		enabled = false,
		keys = {
			{ "<leader>p", "<cmd>PasteImg<cr>", desc = "Paste image", remap = true },
		},
		opts = {
			default = {
				img_dir = "images",
				img_name = function()
					return os.date("%Y-%m-%d-%H-%M-%S")
				end, -- Example result: "2021-04-13-10-04-18"
				affix = "<\n  %s\n>", -- Multi lines affix
			},
			-- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
			-- If you're uncertain what to name your field to, you can run `lua print(vim.bo.filetype)`
			-- Missing options from `markdown` field will be replaced by options from `default` field
			markdown = {
				img_dir = { "%:p:h", "images" }, -- Use table for nested dir (New feature form PR #20)
				img_dir_txt = "images",
				-- img_handler = function(img) -- New feature from PR #22
				-- 	local script = string.format('./image_compressor.sh "%s"', img.path)
				-- 	os.execute(script)
				-- end,
			},
		},
	},

	-- markdown preview
	{
		"toppair/peek.nvim",
		enabled = true,
		build = "deno task --quiet build:fast",
		opts = { theme = "dark", app = "webview" },
		-- opts = { theme = "dark", app = "chromium" },
		ft = "markdown",
		config = function()
			require("peek").setup()
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
	{ "echasnovski/mini.pairs", enabled = false },
	{
		"windwp/nvim-autopairs",
		event = "BufEnter",
		enabled = true,
		opts = {
			enable_check_bracket_line = true,
			disable_filetype = { "TelescopePrompt", "vim", "gitcommit" },
		},
	},
	{
		"roobert/statusline-action-hints.nvim",
		enabled = false,
		config = function()
			require("statusline-action-hints").setup({
				definition_identifier = "gd",
				template = "%s ref:%s",
			})
		end,
	},
	{
		"altermo/ultimate-autopair.nvim",
		enabled = false,
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			require("ultimate-autopair").setup({})
		end,
	},
	{
		"hrsh7th/nvim-pasta",
		enabled = false,
		event = "BufReadPost",
		config = function()
			vim.keymap.set({ "n", "x" }, "p", require("pasta.mappings").p)
			vim.keymap.set({ "n", "x" }, "P", require("pasta.mappings").P)
			vim.keymap.set({ "n" }, "<C-p>", require("pasta.mappings").toggle_pin)

			-- This is the default. You can omit `setup` call if you don't want to change this.
			require("pasta").setup({
				paste_mode = false,
				fix_cursor = true,
				fix_indent = true,
				prevent_diagnostics = false,
				next_key = vim.api.nvim_replace_termcodes("<C-p>", true, true, true),
				prev_key = vim.api.nvim_replace_termcodes("<C-n>", true, true, true),
			})
			require("pasta").setup.filetype({ "markdown", "yaml" }, {
				converters = {},
			})
		end,
	},
	{
		"gbprod/yanky.nvim",
		enabled = false,
		event = "BufReadPost",
		config = function()
			require("yanky").setup({
				highlight = {
					timer = 150,
				},
				ring = {
					storage = jit.os:find("Windows") and "shada",
				},
			})

			vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")

			vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
			vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
			vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
			vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

			vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
			vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

			vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
			vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
			vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
			vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

			vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
			vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
			vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
			vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

			vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
			vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")

			vim.keymap.set("n", "<leader>P", function()
				require("telescope").extensions.yank_history.yank_history({})
			end, { desc = "Paste from Yanky" })
		end,
	},
}
