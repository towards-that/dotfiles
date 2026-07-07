-- =============================================================================
--  Keybindings Configuration
-- =============================================================================
--  Modes: n=Normal, i=Insert, v=Visual, t=Terminal, c=Command

vim.g.mapleader = " "

-- =============================================================================
--  1. File Operations & Custom Save
-- =============================================================================

local function Save_file()
	if not vim.bo.modifiable then
		vim.notify("Buffer is read-only", vim.log.levels.WARN, { title = "Save" })
		return
	end

	-- If nothing changed, do nothing (no save, no notify)
	if not vim.bo.modified then
		return
	end

	-- pcall prevents the editor from crashing if the write fails
	local ok = pcall(vim.cmd, "write")

	if ok then
		vim.notify("File saved", vim.log.levels.INFO, { title = "Save" })
	end
end

-- Ctrl + s to Save
vim.keymap.set({ "n", "i", "v" }, "<C-s>", Save_file, { silent = true, desc = "Save file" })

-- Ctrl + q to Quit
-- Uses :confirm to prevent accidental exit if buffer is unsaved
vim.keymap.set("n", "<M-q>", ":confirm q<CR>", { desc = "Quit (confirm)" })

-- =============================================================================
--  2. Buffer Navigation (Alt+Tab)
-- =============================================================================

-- Cycle Buffers (Next/Prev) using Alt+Tab
-- Since you use i3/keyd, this will work perfectly.
vim.keymap.set({ "n", "i", "v" }, "<M-Tab>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set({ "n", "i", "v" }, "<M-S-Tab>", "<cmd>bprev<CR>", { desc = "Previous Buffer" })

-- Keeping standard Tab as a fallback just in case
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprev<CR>", { desc = "Previous Buffer" })

-- =============================================================================
--  3. Editing & Productivity
-- =============================================================================

-- Duplicate Line Down (Preserves Column Position)
vim.keymap.set("n", "<M-d>", "yyp", { desc = "Duplicate line down" })
vim.keymap.set("v", "<M-d>", "y'>p", { desc = "Duplicate selection down" })

vim.keymap.set("i", "<M-d>", function()
	local r, c = unpack(vim.api.nvim_win_get_cursor(0)) -- Get current row/col
	vim.cmd("normal! yyp") -- Duplicate line
	vim.api.nvim_win_set_cursor(0, { r + 1, c }) -- Move cursor to correct column on new line
	vim.cmd("startinsert") -- Go back to Insert Mode immediately
end, { desc = "Duplicate line down" })

-- Toggle Word Wrap (Alt + z)
vim.keymap.set({ "n", "i" }, "<M-z>", function()
	vim.opt.wrap = not vim.opt.wrap:get() -- Toggle the boolean value
	if vim.opt.wrap:get() then
		vim.notify("Word Wrap: ON", vim.log.levels.INFO)
	else
		vim.notify("Word Wrap: OFF", vim.log.levels.WARN)
	end
end, { desc = "Toggle Word Wrap" })

-- Move Lines (Alt + Arrows)
vim.keymap.set("n", "<M-Down>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<M-Up>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("i", "<M-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
vim.keymap.set("i", "<M-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
vim.keymap.set("v", "<M-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<M-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Insert New Line (Ctrl+Enter)
vim.keymap.set("i", "<C-Enter>", "<Esc>o", { desc = "New line below" })
vim.keymap.set("n", "<C-Enter>", "o<Esc>", { desc = "New line below" })

-- Visual Indentation
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selection" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Un-indent selection" })

-- Insert Un-indent
vim.keymap.set("i", "<S-Tab>", "<C-d>", { desc = "un-indent line" })

-- Delete without Copying (Black Hole)
vim.keymap.set("n", "<C-S-k>", '"_dd', { desc = "Delete line (Black Hole)" })
vim.keymap.set("i", "<C-S-k>", '<C-o>"_dd', { desc = "Delete line (Black Hole)" })
vim.keymap.set("v", "<C-S-k>", '"_d', { desc = "Delete selection (Black Hole)" })

-- =============================================================================
--  4. System Fixes
-- =============================================================================

-- Disable Suspend (Ctrl+z) in Terminals to prevent freezing
vim.keymap.set("c", "<C-z>", "<Nop>", { desc = "Disable Suspend" })
vim.keymap.set("t", "<C-z>", "<Nop>", { desc = "Disable Suspend" })

-- Ctrl + Backspace to delete previous word (Insert Mode)
vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "Delete previous word" })

-- Shift + Backspace = Forward Delete
vim.keymap.set("i", "<S-Del>", "<Del>", { desc = "Forward Delete" })
vim.keymap.set("c", "<S-Del>", "<Del>", { desc = "Forward Delete in Command Mode" })

-- LSP Signature Help (Show function arguments)
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Show function signature" })

-- Window Navigation (Leader + Tab)
local opts = { noremap = true, silent = true }
vim.keymap.set({ "n", "v" }, "<Leader-Tab>", "<C-w>w", opts)

-- Dismiss all Fidget notifications
vim.keymap.set("n", "<M-n>", function()
	require("fidget.notification").clear()
end, { desc = "Clear Notifications", silent = true })

-- Toggle Folds
vim.keymap.set({ "n", "v" }, "<M-f>", "za", { desc = "Toggle fold" })
vim.keymap.set("i", "<M-f>", "<C-o>za", { desc = "Toggle fold (insert)" })

-- Prevent Backspace from closing the command line when empty
vim.keymap.set("c", "<BS>", function()
	if vim.fn.getcmdline() == "" then
		return "" -- Do nothing if empty
	else
		return "<BS>" -- Otherwise, behave like a normal backspace
	end
end, { expr = true, replace_keycodes = true })

vim.keymap.set("n", "<leader>th", function()
	vim.cmd("colorscheme habamax")
end, { desc = "Theme: habamax" })

vim.keymap.set("n", "<leader>to", function()
	vim.cmd("colorscheme onedark")
end, { desc = "Theme: One Dark" })
