return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  opts = {
    current_line_blame = false, -- Kept false to reduce noise
    signcolumn = true,
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)
  end,
}
