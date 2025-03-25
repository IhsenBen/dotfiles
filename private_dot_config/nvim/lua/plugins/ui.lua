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
  -- messages, cmdline and the popupmenu
  { "vim-denops/denops.vim" },
  { "vim-denops/denops-helloworld.vim" },

  -- notifications
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },
  {
    "NvChad/base46",
    branch = "v2.0",
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  -- animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        -- separator_style = "slant",
      },
    },
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        -- globalstatus = false,
        theme = "solarized_dark",
      },
    },
  },

  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      transparent_background = true,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },

  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
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
