return {
	-- 'hrsh7th/cmp-buffer',
	-- 'hrsh7th/cmp-path',
	-- 'hrsh7th/cmp-cmdline',
	{
		'hrsh7th/cmp-nvim-lsp',
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			'saadparwaiz1/cmp_luasnip',
			'rafamadriz/friendly-snippets',
		},
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		config = function()
			local ls = require("luasnip")
			-- local s = ls.snippet
			-- local t = ls.text_node
			-- local i = ls.insert_node

			vim.keymap.set({"n", "v"}, "<C-l>", "w")
			vim.keymap.set({"n", "v"}, "<C-j>", "b")

			vim.keymap.set({"i", "s"}, "<C-l>", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, { silent  = true })

			vim.keymap.set({"i", "s"}, "<C-j>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent  = true })

			-- ls.add_snippets("lua", {
			-- 	s("hello", {
			-- 		t('print("hello world")')
			-- 	})
			-- })
		end
	},
	{
		'hrsh7th/nvim-cmp',
		config = function()
			local cmp = require('cmp')
			require("luasnip.loaders.from_vscode").lazy_load()
			-- THE FOLLOWING ALMOST WORKS BUT TAKES WAY TOO MUCH WORK
			-- cmp.event:on('menu_opened',
			-- 	function()
			-- 		if BLA then
			-- 			local keys = vim.api.nvim_replace_termcodes("<C-k><CR>", true, true, true)
			-- 			vim.api.nvim_feedkeys(keys, "m", false)
			-- 		end
			-- 	end)
			cmp.setup({
				experimental = {
					ghost_text = true
				},
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				sources = {
					{name = 'luasnip'},
					{name = 'nvim_lsp'},
					-- {name = 'buffer'},
					-- {name = 'path'},
				},
				--- (Optional) Show source name in completion menu
				-- formatting = cmp_format,
				mapping = cmp.mapping.preset.insert({
					['<C-i>'] = cmp.mapping.select_prev_item(),
					['<C-k>'] = cmp.mapping.select_next_item(),
					['<C-d>'] = function()
						if cmp.visible_docs() then
							cmp.close_docs()
						else
							cmp.open_docs()
						end
					end,
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-q>'] = cmp.mapping.abort(),
					-- ['<C-f>'] = function()
					-- 	cmp.abort()
					-- 	cmp.complete()
					-- end,
					['<CR>'] = cmp.mapping.confirm({ select = false }),

					-- THE FOLLOWING ALMOST WORKS BUT TAKES WAY TOO MUCH WORK
					-- ['<CR>'] = function()

					-- 	if cmp.get_active_entry()['resolved_completion_item'] == nil then
					-- 		if BLA then
					-- 			local choice = cmp.get_entries()[1]['completion_item']['sortText']
					-- 			if choice == nil then
					-- 				local keys = vim.api.nvim_replace_termcodes("<C-q>", true, true, true)
					-- 				vim.api.nvim_feedkeys(keys, "m", false)
					-- 			else
					-- 				if string.find(choice, CHOICE) then
					-- 					cmp.confirm({ select = true })
					-- 				end
					-- 			end
					-- 		end
					-- 		BLA = false
					-- 		return
					-- 	end

					-- 	CHOICE = cmp.get_active_entry()['resolved_completion_item']['insertText']
					-- 	if CHOICE == nil then
					-- 		cmp.confirm({ select = false })
					-- 		return
					-- 	end

					-- 	local found = string.find(CHOICE, "%$0")
					-- 	if found then
					-- 		cmp.confirm({ select = false })
					-- 		return
					-- 	else
					-- 		cmp.abort()
					-- 		cmp.complete()
					-- 		BLA = true
					-- 	end
					-- end
				}),

				-- sorting = {
				-- 	comparators = {
				-- 		-- cmp.config.compare.kind,
				-- 		cmp.config.compare.exact,
				-- 		-- cmp.config.compare.offset,
				-- 		-- cmp.config.compare.score,
				-- 		cmp.config.compare.sort_text,
				-- 		-- cmp.config.compare.length,
				-- 		-- cmp.config.compare.order,
				-- 	}
				-- }
			})
		end
	}
}

-- vim.keymap.set({"i", "s"}, "<C-x>", function()
-- if ls.expand_or_jumpable() then
-- ls.expand_or_jump()
-- end

-- vim.keymap.set({"i", "s"}, "<C-z>", function()
-- if ls.jumpable(-1) then
-- ls.jump(-1)
-- end
