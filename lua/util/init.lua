local M = {}
function M.compile()
	if vim.bo.filetype == "tex" then
		vim.cmd("VimtexCompile")
	elseif vim.bo.filetype == "markdown" then
		-- require("knap").toggle_autopreviewing()
		local peek = require("peek")
		if peek.is_open() then
			peek.close()
		else
			peek.open()
		end
	else
		vim.cmd("CompilerOpen")
	end
end
function M.neogit()
	local neogit = require("neogit")
	local _ = vim.fn.system("git rev-parse --is-inside-work-tree")
	if vim.v.shell_error == 0 then
		neogit.open()
	else
		neogit.open({ cwd = "%:p:h<CR>" })
	end
end
function M.isgit()
	local _ = vim.fn.system("git rev-parse --is-inside-work-tree")
	if vim.v.shell_error ~= 0 then
		local path = vim.fn.expand("%:p:h")
		vim.cmd("lcd " .. path)
	end
end
return M
