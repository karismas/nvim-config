-- ┌────────┐
-- │        │
-- │  TABS  │
-- │        │
-- └────────┘

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- ┌────────────────┐
-- │                │
-- │  LINE NUMBERS  │
-- │                │
-- └────────────────┘

vim.wo.relativenumber = true
vim.opt.number = true

-- ┌───────┐
-- │       │
-- │  LSP  │
-- │       │
-- └───────┘

-- Stops LSP warnings/errors from
-- blocking line numbers
vim.opt.signcolumn = "no"

-- ┌──────────┐
-- │          │
-- │  SPLITS  │
-- │          │
-- └──────────┘

-- Commands that cause screen splits
-- will appear at bottom instead of top
-- (:h for example)
vim.opt.splitbelow = true

-- ┌─────────────┐
-- │             │
-- │  LINE WRAP  │
-- │             │
-- └─────────────┘

vim.opt.wrap = false


-- ┌────────────────┐
-- │                │
-- │  VISUAL BLOCK  │
-- │                │
-- └────────────────┘

-- Allows visual block to extend
-- into blank space
vim.opt.virtualedit = "block"

-- ┌────────────┐
-- │            │
-- │  COMMANDS  │
-- │            │
-- └────────────┘

-- Allows tab-autocomplete for vim commands
-- to work regardless of case
vim.opt.ignorecase = true

-- ┌─────────────┐
-- │             │
-- │  SEARCHING  │
-- │             │
-- └─────────────┘

-- Shows all searched text in bottom window
vim.opt.inccommand = "split"

-- ┌──────────┐
-- │          │
-- │  COLORS  │
-- │          │
-- └──────────┘

-- Optionally enable 24-bit color
vim.opt.termguicolors = true

-- Makes background transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Highlights all cases of search
vim.opt.hlsearch = true

-- Allows modification of buffers (this is enabled for keybind that calls undo from vim.cmd)
-- Although I'm not sure it is actually necessary
vim.opt.modifiable = true

-- Show matching search cases as
-- search is typed
vim.opt.incsearch = true

-- Writes swap file to disk when nothing
-- is typed for this amount of time
vim.opt.updatetime = 50

-- Forces cursor to be at center
-- at all times (except at beginning/end of file)
vim.opt.scrolloff = 999

-- Combines typical register and system clipboard
-- vim.opt.clipboard = "unnamedplus"

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Other netrw options
-- vim.g.netrw_liststyle = 3
-- vim.g.netrw_banner = 0
-- vim.g.netrw_browse_split = 2
-- vim.g.netrw_altv = 1
-- vim.g.netrw_winsize = 85
-- augroup ProjectDrawer
--   autocmd!
--   autocmd VimEnter * :Vexplore
-- augroup END

-- Changes MarkdownPreview CSS
vim.cmd([[let g:mkdp_markdown_css = '/Users/hubers001/basic.css']])
