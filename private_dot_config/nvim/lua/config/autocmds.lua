-- Ensure `vim.g.autosave` is initialized
vim.g.autosave = vim.g.autosave or false
-- local wk = require("which-key")
local create_cmd = vim.api.nvim_create_user_command
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.wo.conceallevel = 1
  end,
})

local function clear_cmdarea()
  vim.defer_fn(function()
    vim.api.nvim_echo({}, false, {})
  end, 801)
end

-- autosave functions

local function autosave()
  -- Clear existing autocommands to prevent duplication
  vim.api.nvim_clear_autocmds({ event = { "InsertLeave", "TextChanged" } })

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

        -- clear msg after 501ms
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

-- Run autosave initially if it's enabled
if vim.g.autosave then
  autosave()
end
