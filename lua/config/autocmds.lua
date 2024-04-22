-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim

local create_cmd = vim.api.nvim_create_user_command
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.wo.conceallevel = 0
	end,
})

local function clear_cmdarea()
	vim.defer_fn(function()
		vim.api.nvim_echo({}, false, {})
	end, 800)
end
-- autosave stuff runs automatically with copilot on each vim enter:
local function autosave()
	vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
		callback = function()
			if #vim.api.nvim_buf_get_name(0) ~= 0 and vim.bo.buflisted and vim.g.autosave then
				vim.cmd("silent w")

				-- print nice colored msg
				vim.api.nvim_echo(
					{ { "󰄳", "LazyProgressDone" }, { " file autosaved at " .. os.date("%I:%M %p") } },
					false,
					{}
				)

				-- clear msg after 500ms
				clear_cmdarea()
			end
		end,
	})
end

create_cmd("AsToggle", function()
	vim.g.autosave = not vim.g.autosave

	if vim.g.autosave then
		autosave()
	end

	if vim.g.autosave then
		vim.api.nvim_echo({ { "󰆓 ", "LazyProgressDone" }, { "autosave enabled!" } }, false, {})
	else
		vim.api.nvim_echo({ { "󰚌 ", "LazyNoCond" }, { "autosave disabled" } }, false, {})
	end

	clear_cmdarea()
end, {})

-- run autosave= on startup
autosave()
