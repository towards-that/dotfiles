return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.setup({
      plugins = { spelling = true },
    })

    wk.add({
      -- UPDATED: Uses :Ex for Netrw instead of NvimTree
      { "<leader>e",  "<cmd>Ex<CR>",                   desc = "Explorer (Netrw)" },
      
      { "<leader>f",  group = "Files" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>",    desc = "Buffers" },
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>",  desc = "Live Grep" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>",  desc = "Help" },

      {
        "<leader>fm",
        function() require("conform").format({ lsp_fallback = true }) end,
        desc = "Format File",
      },
      
      -- If you install an outline plugin later, this works.
      -- If not, you can remove it.
      { "<leader>o", "<cmd>Outline<CR>", desc = "Outline" },
    })
  end,
}
