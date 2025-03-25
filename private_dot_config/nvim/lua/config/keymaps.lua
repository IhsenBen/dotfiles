local keymap = vim.keymap
local opts = { noremap = true, silent = true }

local telescope = require("telescope")

-- Load the Telescope extension for projects
telescope.load_extension("projects")

--  switch btw projects; w to select in n
vim.api.nvim_set_keymap("n", "<leader>fp", "<cmd>Telescope projects<CR>", { noremap = true, silent = true })

-- mimic nvchad nvterm behavioour , toggle floating terminal for quick cli.
-- keymap.set("t", "<A-i>", "<C-\\><C-n>:lua require('nvterm.terminal').toggle('float')<CR>")
-- keymap.set("n", "<A-i>", ":lua require('nvterm.terminal').toggle('float')<CR>")

---  for vscode line up and down behaviour
keymap.set("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
keymap.set("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)

--- set keymaps for closing windows and tabs
keymap.set("n", "<Leader>q", ":q<CR>", opts)

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

--AutoSave Toggle
keymap.set("n", "<Leader>A", ":AsToggle<CR>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "`l", "<C-w>l")

-- Resize window
keymap.set("n", "<C-z><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Markdown preview
keymap.set("n", "<Leader>md", ":MarkdownPreviewToggle<CR>", opts)

-- Toggle DBUI
keymap.set("n", "<Leader>db", ":DBUIToggle<CR>", opts)

-- Theme Switcher
local pickers = require("huez.pickers")
keymap.set("n", "<leader>th", pickers.themes, {})
