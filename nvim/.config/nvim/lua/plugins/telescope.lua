return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })

		-- Find Errors (Current Buffer only)
		vim.keymap.set("n", "<leader>fe", function()
			builtin.diagnostics({ bufnr = 0 })
		end, { desc = "Find Errors (Current Buffer)" })

		-- Find Errors (All Buffers / Full Workspace)
		vim.keymap.set("n", "<leader>fa", builtin.diagnostics, { desc = "Find All Errors (Workspace)" })
	end,
}
