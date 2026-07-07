return {
	-- 1. Java Support (JDTLS)
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		-- Note: Real Java power requires a complex setup function here.
		-- For now, we load the plugin so it is available.
	},

	-- 2. Main LSP Configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp", -- Required to link LSP with Auto-Completion
		},

		config = function()
			-- A. SETUP MASON
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			-- B. CAPABILITIES (Wire up Autocomplete)
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- C. KEYBINDINGS (Run when LSP attaches)
			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, silent = true }

				-- Navigation
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition", buffer = bufnr })
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation", buffer = bufnr })
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation", buffer = bufnr })

				-- Refactoring
				-- Note: We use <leader>rn for IncRename in utils.lua, but we keep this as a backup
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol", buffer = bufnr })
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buffer = bufnr })

				-- Diagnostics
				vim.keymap.set(
					"n",
					"<leader>d",
					vim.diagnostic.open_float,
					{ desc = "Show Diagnostics", buffer = bufnr }
				)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
			end

			-- D. SETUP SERVERS
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- C / C++
					"clangd",

					-- Python
					"pyright",

					-- JavaScript / JSX / TS / TSX
					"ts_ls",
					"eslint",

					-- Web
					"html",
					"cssls",
					"tailwindcss",

					-- Java
					"jdtls",

					-- Lua (for Neovim itself)
					"lua_ls",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end,
				},
			})
		end,
	},
}
