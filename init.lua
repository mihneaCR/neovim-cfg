-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.transparency = 0.8
vim.g.neovide_transparency = 0.9
vim.g.neovide_floating_transparency = 0.8
vim.g.python3_host_prog = "/home/mihnea/.pyenv/versions/neovim/bin/python"
vim.g.ruby_host_prog = "/home/mihnea/.rbenv/shims/ruby"
require("config.lazy")
