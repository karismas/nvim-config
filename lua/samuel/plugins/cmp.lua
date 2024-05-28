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

			vim.keymap.set({"i", "s"}, "<C-x>", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, {silent = true})

			vim.keymap.set({"i", "s"}, "<C-z>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, {silent = true})

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
					{name = 'nvim_lsp'},
					{name = 'luasnip'},
					-- {name = 'buffer'},
					-- {name = 'path'},
				},
				--- (Optional) Show source name in completion menu
				formatting = cmp_format,
				mapping = cmp.mapping.preset.insert({
					['<C-k>'] = cmp.mapping.select_prev_item(),
					['<C-j>'] = cmp.mapping.select_next_item(),
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-q>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = false }),
				})

			})
		end
	}
}
