return {
  -- Plugin: Mini.bufremove
  -- URL: https://github.com/echasnovski/mini.bufremove
  -- Description: Neovim's default ":q" command closes the *window* (split), not just the file.
  --              This plugin lets you close the file (buffer) while keeping your split layout intact.
  "echasnovski/mini.bufremove",

  -- Version: Use the stable release ("*") rather than the latest git commit.
  version = "*",

  -- OPTIMIZATION: Lazy Loading by Keypress
  -- The plugin code is NOT loaded at startup. It sleeps until you press <C-b>.
  keys = {
    {
      "<M-b>", -- The key to trigger the load
      function()
        -- The action to run: delete buffer (0 = current buffer)
        -- force = false (don't delete if unsaved changes exist)
        require("mini.bufremove").delete(0, false)
      end,
      desc = "Close Buffer" -- Description for WhichKey / Help
    }
  },

  config = function()
    -- Standard setup function required to initialize the plugin
    require("mini.bufremove").setup()
  end,
}
