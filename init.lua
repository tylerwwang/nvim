--Plugins
require("config.lazy")
require("config.neogitcolor")

--TexCommands
require("config.TexCommands")

--Initial things in VimScript
local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
