return {

  --  Color picker :
  { "nvzone/volt", lazy = true },

  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
  },
  {
    "chaoren/vim-wordmotion",
  },

  -- Add nvim-surround plugin
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          visual = "<C-g>S",
          visual_line = "<C-g>gS",
          delete = "<C-g>d",
        },
        surrounds = {
          ["<"] = {
            add = function()
              local input = require("nvim-surround.config").get_input("Enter the tag name: ")
              return { { "<" .. input .. ">" }, { "</" .. input .. ">" } }
            end,
            find = "<%w+.*>.-</%w+>",
            delete = "^(<%w+.*>)(.-)(</%w+>)$",
          },
          ["["] = {
            add = { "[", "]" },
            find = "%b[]",
            delete = "^([%[])(.*)([%]])$",
          },
        },
      })
    end,
  },

  -- Better increase/descrease for number values
  {
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new({ elements = { "let", "const" } }),
        },
      })
    end,
  },

  -- lazygit integration for nvim
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
