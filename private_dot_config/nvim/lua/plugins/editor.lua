return {
  -- latex editor
  {
    "lervag/vimtex",
    lazy = false, -- Keep this: lazy-loading will disable inverse search, so it must be false
    config = function()
      -- These are from LazyVim's default config and are kept
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"

      -- Zathura configuration for vimtex (added for live preview)
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_latexmk_engines = {
        _ = "-pdf", -- Ensure latexmk uses pdflatex for PDF output
      }

      -- Optional: Advanced inverse search setup for Zathura
      -- This ensures a robust inverse search (clicking in Zathura to jump to Neovim)
      -- Requires 'xdotool' to be installed (which you've done on Ubuntu).
      -- LazyVim typically ensures your nvim instance has a servername for this to work.
      vim.g.vimtex_view_general_options = {
        "--synctex-forward=%l:%c:%f",
        '--synctex-editor-command="nvim --headless --server $(cat /tmp/nvim.pipe) --remote-send \\"<c-^><c-w>p:call vimtex#view#inverse_search#callback_pipe(\\\'%f\\\', %l, %c)\\""',
      }
    end,
    keys = {
      { "<Leader>t", "", desc = "+vimtex", ft = "tex" },

      -- Add keybindings for common vimtex actions, if you don't already have them
      -- These provide easy access to start/stop compilation and view the PDF
      { "<Leader>tv", ":VimtexView<CR>", desc = "View PDF", mode = "n", ft = "tex" },
      { "<Leader>tc", ":VimtexCompile<CR>", desc = "Compile (continuous)", mode = "n", ft = "tex" },
      { "<Leader>tk", ":VimtexStop<CR>", desc = "Stop Compile", mode = "n", ft = "tex" },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    lazy = false,
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  --  sql db "studio"
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Enable NERD fonts
      vim.g.db_ui_use_nerd_fonts = 1

      -- Add SQLite database connection
      -- vim.g.dbs = {
      -- exemple_db = "sqlite://home/ihsen/work/project/dbpath/sqlfile.db",
      -- }
    end,
  },

  -- good  batch copy/move files
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },

  -- {
  --   "nvim-neorg/neorg",
  --   lazy = false,
  --   version = "*",
  --   config = true,
  --   ft = "norg",
  --   opts = {
  --     load = {
  --       ["core.defaults"] = {},
  --       ["core.dirman"] = {
  --         config = {
  --           workspaces = {
  --             index = "~/notes",
  --             personal = "~/notes/personal",
  --             work = "~/notes/work",
  --           },
  --           default_workspace = "index",
  --         },
  --       },
  --       ["core.concealer"] = {},
  --       ["core.completion"] = { config = { engine = "nvim-cmp" } },
  --       ["core.presenter"] = { config = { zen_mode = "zen-mode" } },
  --       ["core.tangle"] = {},
  --       ["core.itero"] = {},
  --       ["core.ui.calendar"] = {},
  --       ["core.export"] = {},
  --       -- ["core.latex.renderer"] = {},
  --     },
  --   },
  -- },

  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({ disable_legacy_commands = true })

      local opts = { noremap = true, silent = true }

      vim.keymap.set("n", "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>", opts)
      vim.keymap.set("n", "<Leader><Leader>y", "<cmd>IconPickerYank<cr>", opts) --> Yank the selected icon into register
      vim.keymap.set("i", "<C-i>", "<cmd>IconPickerInsert<cr>", opts)
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

      -- stylua: ignore start
      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next")
        end
      end, "Next Hunk")
      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, "Prev Hunk")
      map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
      map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
      map("n", "<leader>ghd", gs.diffthis, "Diff This")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      {
        "//",
        "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
}
