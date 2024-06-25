-- ┌────────────┐
-- │  STANDARD  │
-- └────────────┘

-- Tabbed selections stay selected
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Clear the recent search terms so 
-- hitting "N" or "n" won't cause 
-- highlights to appear again
vim.keymap.set("n", "<C-l>", ":let @/ = \"\"<CR>")
vim.keymap.set("n", "<leader>e", ":let @+=@\"<CR>")

-- Keeps cursor at center when scrolling
-- Interferes with smoothscrolling plugin
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keeps cursor at center when searching for term
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Can select text and move it up and down and autoindents
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Allows use of 'J' without cursor moving
vim.keymap.set("n", "J", "mzJ`z")

-- Quick paste for clipboard register
vim.keymap.set("n", "<leader>p", "\"+p")

-- Keeps word in register after pasting over word
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Quicker yank into system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>d", "\"+d")
vim.keymap.set("v", "<leader>d", "\"+d")

-- Replaces typical "U" operation with redo
vim.keymap.set("n", "U", "<C-r>")

-- Remove ex mode
vim.keymap.set("n", "Q", "<nop>")

-- Search and replace current word hovered over
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- ┌────────────┐
-- │    HELP    │
-- └────────────┘
vim.keymap.set('n', '<leader>h', function()
	 vim.cmd('help ' .. vim.fn.input("Help > "))
	 vim.cmd('resize ' .. vim.api.nvim_win_get_height(0) * 2)
end)

-- ┌─────────────┐
-- │     MAN     │
-- └─────────────┘
vim.keymap.set('n', '<leader>m', function()
	vim.cmd('Man ' .. vim.fn.input("Man > "))
	 vim.cmd('resize ' .. vim.api.nvim_win_get_height(0) * 2)
end)

-- ┌─────────────┐
-- │  TELESCOPE  │
-- └─────────────┘
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>sf', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") }) -- Requires ripgrep
end)

-- ┌─────────────┐
-- │  NVIM-TREE  │
-- └─────────────┘
local api = require("nvim-tree.api")
vim.keymap.set('n', '<leader>tt', api.tree.toggle)
vim.keymap.set('n', '<leader>tl', function() api.tree.close() api.tree.toggle({focus = false}) end)
vim.keymap.set('n', '<leader>th', api.tree.open)

-- ┌───────────┐
-- │  HARPOON  │
-- └───────────┘
local harpoon = require("harpoon")
vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end)
vim.keymap.set('n', '<leader>r', function() harpoon:list():remove() end)
vim.keymap.set("n", "<C-m>", function() harpoon:list():next() end)
vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end)

-- ┌────────────┐
-- │  UNDOTREE  │
-- └────────────┘

vim.cmd([[let g:undotree_SetFocusWhenToggle = 1]])
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Unsure
-- local hooks = require "core.hooks"
-- hooks.add("setup_mappings", function(map)
-- 	map("n", "n", "nzzzv")
-- 	map("N", "N", "Nzzzv")
-- end)
