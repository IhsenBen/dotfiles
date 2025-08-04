return {
  -- themes
  {
    "vague2k/huez.nvim",
    import = "huez-manager.import",
    branch = "stable",
    event = "UIEnter",
    config = function()
      require("huez").setup({})
    end,
  },

  {
    "NvChad/base46",
    branch = "v2.0",
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  --- to easily switch btw nvim window & tmux panels
  {
    "aserowy/tmux.nvim",

    config = function()
      return require("tmux").setup({
        copy_sync = {
          enable = false,
        },
      })
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  -- quick access to a terminal
  -- Not really needed with tmux
  -- {
  --   "NvChad/nvterm",
  --   plugin = true,
  --   opts = {
  --     keys = {
  --       { "t", "<A>i", "<cmd>lua require('nvterm.terminal').toggle('float')<cr>", { noremap = true } },
  --       { "t", "<A-h>", "<cmd>lua require('nvterm.terminal').toggle('horizontal')<cr>", { noremap = true } },
  --       { "t", "<A-v>", "<cmd>lua require('nvterm.terminal').toggle('vertical')<cr>", { noremap = true } },
  --
  --       { "n", "<A-i>", "<cmd>lua require('nvterm.terminal').toggle('float')<cr>", { noremap = true } },
  --       { "n", "<A-h>", "<cmd>lua require('nvterm.terminal').toggle('horizontal')<cr>", { noremap = true } },
  --       { "n", "<A-v>", "<cmd>lua require('nvterm.terminal').toggle('vertical')<cr>", { noremap = true } },
  --
  --       -- new
  --       { "n", "<leader>h", "<cmd>lua require('nvterm.terminal').new('horizontal')<cr>", { noremap = true } },
  --       { "n", "<leader>v", "<cmd>lua require('nvterm.terminal').new('vertical')<cr>", { noremap = true } },
  --     },
  --   },
  --   config = function()
  --     require("nvterm").setup({
  --       window = {
  --         margin = { vertical = 0, horizontal = 1 },
  --       },
  --     })
  --   end,
  -- },

  -- dashboard logo
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          -- Knowledge Before Speech and Work
          header = [[
                  ▄ ▄                   
              ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     
              █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     
           ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     
         ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  
         █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄
       ▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █
       █▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █
           █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    
 ]],
        },
      },
    },
  },
}
