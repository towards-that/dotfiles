-- =============================================================================
--  Lazy.nvim Bootstrapper & Configuration
-- =============================================================================
--  This file handles the installation and setup of 'lazy.nvim',
--  the modern plugin manager for Neovim.

-- 1. DEFINE PATHS
--    Where to install lazy.nvim? -> Standard data directory (usually ~/.local/share/nvim/lazy)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- 2. BOOTSTRAP (Auto-Install)
--    Check if lazy.nvim is already installed. If not, clone it from GitHub.
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  
  -- Error Handling: If git clone fails, warn the user and exit.
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- 3. LOAD LAZY
--    Add the installed path to Neovim's runtime path so we can `require` it.
vim.opt.rtp:prepend(lazypath)

-- 4. SETUP & CONFIGURATION
require("lazy").setup({
  -- SPEC: Where are your plugins?
  -- This tells lazy to look inside the "lua/plugins/" directory
  -- and load every file returning a plugin table.
  spec = {
    { import = "plugins" },
  },

  -- UI SETTINGS
  -- change_detection: Check for config file changes and reload?
  -- notify = false: Turns off the "Config Changed" notification spam.
  change_detection = { notify = false },
})
