return {
  -- 1. Buffer Close (Keeps split open)
  {
    "echasnovski/mini.bufremove",
    version = "*",
    keys = {
      {
        "<M-b>",
        function() require("mini.bufremove").delete(0, false) end,
        desc = "Close Buffer"
      }
    },
    config = function() require("mini.bufremove").setup() end,
  },

  -- 2. Git Integration
  { 'tpope/vim-fugitive' },

  -- 3. Undo History
  { 'mbbill/undotree' },

  -- 4. Color Highlighting (FIXED for Completion Menu)
  {
    'brenoprata10/nvim-highlight-colors',
    config = function()
      require('nvim-highlight-colors').setup({
        -- "background" renders the color BEHIND the text.
        -- This ensures you can still see the color even if the text turns blue on selection.
        render = 'background', 
        enable_tailwind = true,
      })
    end
  },

  -- 5. Incremental Rename
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
      vim.keymap.set("n", "<leader>rn", ":IncRename ", { desc = "Incremental Rename" })
    end,
  }
}
