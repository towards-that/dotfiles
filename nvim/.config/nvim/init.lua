require("config.options")
require("config.keybinds")
require("config.lazy")

vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  command = "silent! update",
  desc = "Autosave file when leaving buffer",
})
