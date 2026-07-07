return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost",
    opts = {
      indent = {
        char = "│", 
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
      whitespace = {
        remove_blankline_trail = true,
      },
    },
  }
}
