vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "yml.ansible", "yaml.ansible" },
	command = "setfiletype yaml.ansible",
})
vim.filetype.add({
	extension = {
		["yml.ansible"] = "yaml.ansible",
		["yaml.ansible"] = "yaml.ansible",
	},
	pattern = {
		-- ansible playbook
		[".*/.*playbook.*.ya?ml"] = "yaml.ansible",
		[".*/.*tasks.*/.*ya?ml"] = "yaml.ansible",
		[".*/local.ya?ml"] = "yaml.ansible",
	},
})
