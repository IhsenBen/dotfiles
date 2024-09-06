---@type Huez.ThemeConfig
local M = {
  styles = { "moon", "day", "night", "storm" },
  set_theme = function(theme)
    local base_conf = {
      styles = {
        functions = { bold = true, italic = true },
        variables = { italic = true },
        keywords = { bold = true, italic = true },
      },
      background = "white",
      on_colors = function(colors) end,
      on_highlights = function(highlights, colors)
        highlights["Type"] = { bold = true, italic = true }
        highlights["@string.javascript"] = { bold = true, italic = true, fg = colors.green }
      end,
    }

    vim.cmd("colorscheme " .. theme)
    return true
  end,
}
