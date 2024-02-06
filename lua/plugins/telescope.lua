local Util = require("lazyvim.util")
return {
	{
		"nvim-telescope/telescope.nvim",
		opts = {
			defaults = {
				file_ignore_patterns = {
					"COMMIT_EDITMSG",
				},
				prompt_prefix = "   ",
				selection_caret = "  ",
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 60,
			},
		},
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		event = "BufEnter",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		keys = {
			-- { "<leader>e", "<cmd>Telescope file_browser<cr>", desc = "Files" },
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{
				"debugloop/telescope-undo.nvim",
			},
			{
				"jvgrootveld/telescope-zoxide",
				dependencies = {
					"nvim-lua/popup.nvim",
					"nvim-lua/plenary.nvim",
					"nvim-telescope/telescope.nvim",
				},
				config = true,
				keys = {
					{ "<leader>fz", "<cmd>Telescope zoxide list<cr>", desc = "Most Used Dirs" },
					{ "<leader>fB", "<cmd>Telescope file_browser<cr>", desc = "Files" },
					{ "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
				},
			},
		},
		-- apply the config and additionally load fzf-native
		config = function(_, opts)
			local telescope = require("telescope")
			opts.defaults = telescope.setup(opts)
			telescope.load_extension("fzf")
			telescope.load_extension("file_browser")
			telescope.load_extension("undo")
			telescope.load_extension("zoxide")
		end,
	},
}
