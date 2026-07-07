-- =============================================================================
--  General Options
-- =============================================================================
--  This file controls the look and feel of Neovim.
--  It sets up line numbers, indentation, colors, and core behavior.

-- === UI & Appearance ===
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false

-- === Indentation ===
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- === Window Splitting ===
vim.opt.splitright = true
vim.opt.splitbelow = true

-- === Persistent Undo ===
vim.opt.undofile = true

-- === Clipboard Sync ===
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- =============================================================================
-- FOLDING OPTIONS (Tree-sitter)
-- =============================================================================
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Beautiful fold text
vim.opt.foldtext = "v:lua.CustomFoldText()"

function _G.CustomFoldText()
	local line = vim.fn.getline(vim.v.foldstart)
	local line_count = vim.v.foldend - vim.v.foldstart + 1

	line = line:gsub("^%s*", "")

	return "    " .. line .. "    " .. line_count .. " lines"
end

vim.opt.showcmd = true
vim.opt.showcmdloc = "statusline"

-- n-v-c:block  -> Normal, Visual, Command modes use a steady Block
-- i-ci-ve:ver25 -> Insert mode uses a Vertical Bar (25% width)
-- blinkwait/off/on -> Controls the blinking speed (in milliseconds)
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25-blinkwait700-blinkoff400-blinkon250"
