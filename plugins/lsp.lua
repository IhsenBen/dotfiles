return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "deno",
        "js-debug-adapter",
        "css-lsp",
        "markdownlint",
        "marksman",
        "goimports",
        "gofumpt",
        "gomodifytags",
        "impl",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      setup = {
        tsserver = function(_, opts)
          -- Conditional setup for tsserver and denols
          if vim.fn.glob("deno.json") ~= "" or vim.fn.glob("deno.lock") ~= "" then
            require("lspconfig").denols.setup({})
          else
            require("typescript").setup({ server = opts })
          end
          return true
        end,
      },
    },
  },
}