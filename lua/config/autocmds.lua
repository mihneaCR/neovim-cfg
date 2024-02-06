local links = {
	["@lsp.type.namespace"] = "@namespace",
	["@lsp.type.type"] = "@type",
	["@lsp.type.class"] = "@type",
	["@lsp.type.enum"] = "@type",
	["@lsp.type.interface"] = "@type",
	["@lsp.type.struct"] = "@structure",
	["@lsp.type.parameter"] = "@parameter",
	["@lsp.type.variable"] = "@variable",
	["@lsp.type.property"] = "@property",
	["@lsp.type.enumMember"] = "@constant",
	["@lsp.type.function"] = "@function",
	["@lsp.type.method"] = "@method",
	["@lsp.type.macro"] = "@macro",
	["@lsp.type.decorator"] = "@function",
}
-- -- vim.cmd([[autocmd! BufEnter * if &ft ==# 'help' | wincmd L | endif]])
-- vim.cmd([[autocmd! BufEnter * if &ft ==# 'vimdoc' | wincmd L | endif]])
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		for newgroup, oldgroup in pairs(links) do
			vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
		end
	end,
})

-- Toggle Spell and Wrap for text files
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit", "markdown", "tex" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- vim.api.nvim_create_autocmd("BufUnload", {
-- 	callback = function()
-- 		if vim.b.knap_viewerpid then
-- 			os.execute("pkill -f live-server")
-- 			os.execute("pkill -f qutebrowser")
-- 		end
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*",
-- 	callback = function(args)
-- 		local extra_lang_args = {
-- 			["yaml.ansible"] = { lsp_fallback = "always", name = "ansiblels" },
-- 		}
-- 		local extra_args = extra_lang_args[vim.bo[args.buf].filetype] or {}
-- 		require("conform").format(vim.tbl_deep_extend("keep", { bufnr = args.buf, lsp_fallback = true }, extra_args))
-- 	end,
-- })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.ansible" },
	command = "setfiletype yaml.ansible",
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "haskell", "markdown" },
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})
local function augroup(name, commands)
	local id = vim.api.nvim_create_augroup(name, { clear = true })
	for _, autocmd in ipairs(commands) do
		local is_callback = type(autocmd.command) == "function"
		vim.api.nvim_create_autocmd(autocmd.event, {
			group = id,
			pattern = autocmd.pattern,
			desc = autocmd.description,
			callback = is_callback and autocmd.command or nil,
			command = not is_callback and autocmd.command or nil,
			once = autocmd.once,
			nested = autocmd.nested,
			buffer = autocmd.buffer,
		})
	end
	return id
end
augroup("pdf_view", {
	{
		event = "BufEnter",
		pattern = "*.pdf",
		command = function()
			vim.fn.jobstart("zathura " .. '"' .. vim.fn.expand("%") .. '"')
			vim.cmd("bdelete " .. vim.fn.expand("%"))
		end,
	},
})
augroup("img_view", {
	{
		event = "BufEnter",
		pattern = "*.png",
		command = function()
			vim.fn.jobstart("imv " .. '"' .. vim.fn.expand("%") .. '"')
			vim.cmd("bdelete " .. vim.fn.expand("%"))
		end,
	},
})
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = { "help", "vimdoc" },
-- 	callback = function() end,
-- })
-- augroup("help", {
-- 	{
-- 		pattern = { "help", "vimdoc" },
-- 		event = "BufEnter",
-- 		command = ":wincmd L<CR>",
-- 		-- command = function()
-- 		-- 	vim.cmd("wincmd L")
-- 		-- end,
-- 	},
-- })
