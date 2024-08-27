-- ┌────────────┐
-- │  STANDARD  │
-- └────────────┘

-- Change movement keys to be like directional arrows
vim.cmd('set langmap=oh,tj,ck,il,O^,I$')

-- Figure out macros later!

-- Change insert mode
vim.keymap.set({ "n", "v" }, "H", "I")

-- Relative yank and place at cursor
vim.keymap.set("n", "<leader>y", function()
	local command = ""
	while true do
		local inp = vim.fn.getchar()
		if inp >= 48 and inp <= 57 then
			command = command .. (inp - 48)
		elseif inp == 105 then
			command = ":-" .. command
			break
		elseif inp == 107 then
			command = ":+" .. command
			break
		elseif inp == 27 then
			return
		end
	end
	command = command .. "y | put<CR>"
	return command
end, {expr = true})

-- l and j movements with Control will move with w/e and ge/b
-- depending on cursor placement
vim.keymap.set({ "n", "v" }, "<C-l>", function()
	local vpos = vim.fn.getcurpos()
	local str = vim.api.nvim_buf_get_lines(0, vpos[2] - 1, vpos[2], false)[1]
	local next_char = string.sub(str, vpos[3] + 1, vpos[3] + 1)
	if next_char == " " then
		return "w"
	else
		return "e"
	end
end, { expr = true })
vim.keymap.set({ "n", "v" }, "<C-j>", function()
	local vpos = vim.fn.getcurpos()
	local str = vim.api.nvim_buf_get_lines(0, vpos[2] - 1, vpos[2], false)[1]
	local prev_char = string.sub(str, vpos[3] - 1, vpos[3] - 1)
	if prev_char == " " then
		return "ge"
	else
		return "b"
	end
end, { expr = true })

-- Change scrolling keys
local neoscroll = require("neoscroll")
vim.keymap.set({"n", "v"}, "<C-c>", function() neoscroll.scroll(-vim.wo.scroll, true, 300) end)
vim.keymap.set({"n", "v"}, "<C-t>", function() neoscroll.scroll(vim.wo.scroll, true, 300) end)

-- Change top/bottom of document keybinds
vim.keymap.set("n", "C", "gg")
vim.keymap.set("n", "T", "G")

-- Indenting only takes one press
vim.keymap.set("n", ">", ">>")
vim.keymap.set("n", "<", "<<")

-- Tabbed selections stay selected
-- The marks make it so screenflicker does not happen (due to scrolloff = 999)
-- Function removes in-between tabs from undo history
TABS_PRESSED = 0
FAKE_ESCAPE = false
DIRECTION = ""
vim.api.nvim_create_autocmd('ModeChanged', {
	callback = function()
		local old_mode = vim.v.event.old_mode
		local new_mode = vim.v.event.new_mode
		if old_mode == 'V' and new_mode == 'n' then
			if FAKE_ESCAPE then

				FAKE_ESCAPE = false

				if TABS_PRESSED ~= 0 then
					vim.cmd('undo!')
				end

				if DIRECTION == "right" then
					TABS_PRESSED = TABS_PRESSED + 1
				elseif DIRECTION == "left" then
					TABS_PRESSED = TABS_PRESSED - 1
				end
				DIRECTION = ""

				local indent_direction = ""
				if TABS_PRESSED > 0 then
					indent_direction = ">"
				elseif TABS_PRESSED < 0 then
					indent_direction = "<"
				end

				local indent_string = ""
				for _ = 1, math.abs(TABS_PRESSED), 1 do
					indent_string = indent_string .. indent_direction
				end

				local keys = vim.api.nvim_replace_termcodes("gv", true, true, false)
				vim.api.nvim_feedkeys(keys, "n", false)
				vim.cmd(":'<,'>" .. indent_string)
				keys = vim.api.nvim_replace_termcodes("gv", true, true, false)
				vim.api.nvim_feedkeys(keys, "n", false)
			else
				TABS_PRESSED = 0
			end
		end
	end
})

vim.keymap.set("v", ">", function()
	local keys = vim.api.nvim_replace_termcodes("mm", true, true, false)
	vim.api.nvim_feedkeys(keys, "v", false)
	DIRECTION = "right"
	FAKE_ESCAPE = true
	return "<esc>"
end, { expr = true })

vim.keymap.set("v", "<", function()
	local keys = vim.api.nvim_replace_termcodes("mm", true, true, false)
	vim.api.nvim_feedkeys(keys, "v", false)
	DIRECTION = "left"
	FAKE_ESCAPE = true
	return "<esc>"
end, { expr = true })

-- Original
-- vim.keymap.set("v", ">", "mm>gv'm")
-- vim.keymap.set("v", "<", "mm<gv'm")

-- Clear the recent search terms so 
-- hitting "N" or "n" won't cause 
-- highlights to appear again
vim.keymap.set("n", "<C-x>", ":let @/ = \"\"<CR>")

-- Moves paste register into system clipboard
vim.keymap.set("n", "<leader>e", ":let @+=@\"<CR>")
-- Moves system clipboard into paste register 
vim.keymap.set("n", "<leader>w", ":let @\"=@+<CR>")

-- Keeps cursor at center when scrolling
-- (Interferes with smoothscrolling plugin)
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keeps cursor at center when searching for term
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Can select text and move it up and down and autoindents
vim.keymap.set("v", "I", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>+1<CR>gv=gv")

-- Allows use of 'J' without cursor moving
vim.keymap.set("n", "Q", "mzJ`z")

-- Quick paste for clipboard register
-- vim.keymap.set("n", "<leader>p", "\"+p")

--- Paste non-terminated buffer onto next/previous line
vim.keymap.set("n", "<leader>p", "o<esc>p")
vim.keymap.set("n", "<leader>P", "O<esc>p")

-- Keeps word in register after pasting over word
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Quicker yank into system clipboard
-- vim.keymap.set("n", "<leader>y", "\"+y")
-- vim.keymap.set("v", "<leader>y", "\"+y")
-- vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>d", "\"+d")
vim.keymap.set("v", "<leader>d", "\"+d")

-- Replaces typical "U" operation with redo
vim.keymap.set("n", "U", "<C-r>")

-- Remove ex mode
-- vim.keymap.set("n", "Q", "<nop>")

-- Search and replace current word hovered over
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Search and replace current selected text
vim.keymap.set("v", "<leader>s", function()

	local str = ""

	-- If in visual mode
	if vim.fn.mode() == 'v' then

		-- Get start and end of visual selection
		local vstart = vim.fn.getpos("v")
		local vend = vim.fn.getpos(".")

		-- If the start is past the end, flip them
		if vstart[3] > vend[3] then
			local temp = vstart
			vstart = vend
			vend = temp
		end

		-- Grab the text in the visual selection
		str = vim.api.nvim_buf_get_text(0, vstart[2] - 1, vstart[3] - 1, vend[2] - 1, vend[3], {})[1]

	-- If in visual line mode
	elseif vim.fn.mode() == 'V' then

		-- Get the cursor position
		local vpos = vim.fn.getcurpos()

		-- Grab the text in the visual line selection
		str = vim.api.nvim_buf_get_lines(0, vpos[2] - 1, vpos[2], false)[1]
	end

	-- Escape all backslashes first
	str = str:gsub("\\", "\\\\")

	-- Escape other important characters
	local metachars = {"*", "%["}
	for i = 1, #metachars do
		str = str:gsub(metachars[i], "\\" .. metachars[i])
	end

	-- Choose first delimiter not already in string
	-- According to Vim Tips Wiki:
	-- "You can use most non-alphanumeric characters (but not \, " or |)."
	local delimiters = {"%", "_", "-", "#", ",", "/"}
	for i = 1, #delimiters do
		if not string.find(str, delimiters[i], 1, true) then
			return ":s" .. delimiters[i] .. str .. delimiters[i] .. delimiters[i] .. "gI<Left><Left><Left>"
		end
	end

	print("All possible delimiters have been used in the highlighted text.")

end, { expr = true })

-- ┌────────────┐
-- │    HELP    │
-- └────────────┘
vim.keymap.set('n', '<leader>h', function()
	vim.ui.input({ prompt = "Help > ", completion = "help" }, function(input)
		if input == nil then return end
		vim.cmd('help ' .. input)
		vim.cmd('resize ' .. vim.api.nvim_win_get_height(0) * 2)
	end)
end)

-- ┌─────────────┐
-- │     MAN     │
-- └─────────────┘
vim.keymap.set('n', '<leader>m', function()
	vim.ui.input({ prompt = "Man > "}, function(input)
		if input == nil then return end
		vim.cmd('Man ' .. input)
		vim.cmd('resize ' .. vim.api.nvim_win_get_height(0) * 2)
	end)
end)

-- ┌─────────────┐
-- │  TELESCOPE  │
-- └─────────────┘
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', function()
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
