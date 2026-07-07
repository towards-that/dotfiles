return {
	-- ===========================================================================
	--  Colorscheme: One Dark Pro (Clean, no overrides)
	-- ===========================================================================
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			require("onedarkpro").setup({
				options = {
					transparency = false,
					cursorline = true,
				},
			})
			vim.cmd("colorscheme habamax")
		end,
	},

	-- ===========================================================================
	--  Icons (mini.icons)
	-- ===========================================================================
	{
		"echasnovski/mini.icons",
		lazy = false,
		opts = {},
		specs = {
			{ "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	-- ===========================================================================
	--  Statusline (Lualine)
	-- ===========================================================================
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "onedark", -- This will auto-match One Dark Pro
				globalstatus = true,
				icons_enabled = true,
				section_separators = "",
				component_separators = "",
			},
			sections = {
				lualine_c = {
					{
						"filename",
						path = 1,
						-- Removed manual hex color; letting the theme decide
					},
				},
				lualine_x = {
					{ "filetype" },
				},
			},
		},
	},
}
