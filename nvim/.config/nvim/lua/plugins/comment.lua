return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- This enables correct commenting in React/JSX files
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,

  keys = {
    -- NORMAL MODE: Toggle current line
    { "<C-_>", "<Plug>(comment_toggle_linewise_current)",      mode = "n", desc = "Toggle Comment" },
    { "<C-/>", "<Plug>(comment_toggle_linewise_current)",      mode = "n", desc = "Toggle Comment" },

    -- INSERT MODE: Toggle current line (and return to insert)
    { "<C-_>", "<C-o><Plug>(comment_toggle_linewise_current)", mode = "i", desc = "Toggle Comment" },
    { "<C-/>", "<C-o><Plug>(comment_toggle_linewise_current)", mode = "i", desc = "Toggle Comment" },

    -- VISUAL MODE: Toggle comment AND re-select
    { "<C-_>", "<Plug>(comment_toggle_linewise_visual)gv",     mode = "v", desc = "Toggle Comment & Keep Selection" },
    { "<C-/>", "<Plug>(comment_toggle_linewise_visual)gv",     mode = "v", desc = "Toggle Comment & Keep Selection" },
  },
}
