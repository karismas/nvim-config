require("samuel.lazy")

local set = vim.opt -- set options
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
vim.wo.relativenumber = true
vim.opt.number = true
vim.opt.signcolumn = "number" 

-- vim.g.netrw_liststyle = 3
-- vim.g.netrw_banner = 0
-- vim.g.netrw_browse_split = 2
-- vim.g.netrw_altv = 1
-- vim.g.netrw_winsize = 85
-- augroup ProjectDrawer
--   autocmd!
--   autocmd VimEnter * :Vexplore
-- augroup END

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit color
vim.opt.termguicolors = true

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.opt.hlsearch = true 
vim.opt.incsearch = true 

vim.opt.scrolloff = 8

-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- local hooks = require "core.hooks"

-- hooks.add("setup_mappings", function(map)
-- 
-- 	map("n", "n", "nzzzv")
-- 	map("N", "N", "Nzzzv")
-- 
-- end)
