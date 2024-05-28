return {
	{
		"neovim/nvim-lspconfig",
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "mason.nvim" },
		config = function()

			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({
				function (server_name)
					if server_name == "clangd" then
						require("lspconfig").clangd.setup({
							capabilities = capabilities,
							filetypes = {
								"c", "cpp"
							},
						})
					elseif server_name == "lua_ls" then
						require("lspconfig").lua_ls.setup({
							capabilities = capabilities,
							settings =  {
								Lua = {
									diagnostics = {
										globals = { 'vim' }
									}
								}
							}
						})
					elseif server_name == "pylsp" then
						require("lspconfig").pylsp.setup({
							capabilities = capabilities,
							settings = {
								pylsp = {
									plugins = {
										jedi_completion = {
											enabled = true,
											include_params = true,
										},
									}
								}
							}
						})
					else
						require("lspconfig")[server_name].setup({
							capabilities = capabilities
						})
					end
				end
			})
		end
	},
}
