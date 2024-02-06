return {
	{
		"lervag/vimtex",
		ft = "tex",
		enabled = true,
		config = function()
			vim.g.vimtex_quickfix_ignore_filters = { "Underfull", "Overfull" }
			-- vim.g.vimtex_view_method = "sioyek"
			vim.g.latex_view_general_viewer = "zathura"
			vim.g.vimtex_compiler_progname = "nvr"
			vim.g.vimtex_quickfix_mode = 0
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = "LazyFile",
		opts = {
			-- Event to trigger linters
			events = { "BufWritePost", "BufReadPost", "InsertLeave" },
			linters_by_ft = {
				python = { "ruff" },
				shell = { "shellcheck" },
				markdown = { "markdownlint" },
				yaml = { "yamllint" },
				["yaml.ansible"] = { "ansible_lint" }, -- line 196
				-- Use the "*" filetype to run linters on all filetypes.
				-- ['*'] = { 'global linter' },
				-- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
				-- ['_'] = { 'fallback linter' },
			},
			-- LazyVim extension to easily override linter options
			-- or add custom linters.
			---@type table<string,table>
			linters = {},
		},
	},
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			inlay_hints = { enabled = true },
			servers = {
				ansiblels = {},
				bashls = {},
				lua_ls = {},
				jsonls = {},
				rust_analyzer = {},
				yamlls = {},
			},
		},
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"ansible-language-server",
				"ansible-lint",
				"black",
				"clangd",
				"cmakelang",
				"luacheck",
				"markdownlint",
				"marksman",
				"prettierd",
				"shellcheck",
				"shfmt",
				"stylua",
				"yamlfmt",
				"yamllint",
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				shell = { "shfmt" },
				markdown = { "prettierd" },
				python = { "black" },
				["yaml.ansible"] = { "" },
				yaml = { "yamlfmt" },
				xml = { "xmlfmt" },
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
			-- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"Dosx001/cmp-commit",
		},
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local luasnip = require("luasnip")
			local cmp = require("cmp")

			opts.completion = {
				completeopt = "menu,menuone,noselect",
				keyword_length = 0,
				keyword_pattern = [[\k\+]],
			}
			cmp.setup.filetype({ "gitcommit" }, {
				sources = {
					{ name = "commit" },
					{ name = "buffer" },
				},
			})
			opts.sources = cmp.config.sources({
				{
					name = "path",
					option = {
						trailing_slash = true,
					},
				},
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
			})
			opts.mapping = vim.tbl_extend("force", opts.mapping, {
				["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<Up>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<Down>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<Left>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<Right>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			})
		end,
	},
}
