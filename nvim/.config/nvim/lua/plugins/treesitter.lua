return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate", -- auto-update parsers
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			ensure_installed = {
				-- Core / Neovim
				"lua",
				"vim",
				"vimdoc",
				"bash",

				-- Data / config
				"json",
				"jsonc",
				"regex",

				-- Web
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"jsdoc",

				-- Backend / systems
				"c",
				"python",
				"java",

				-- Docs
				"markdown",
				"markdown_inline",
			},

			auto_install = true, -- automatically install missing parsers when entering buffer
			ignore_install = {},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
		},
	},
}
