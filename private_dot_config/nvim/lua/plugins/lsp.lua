return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "luacheck",
        "markdownlint",
        "gopls",
        "goimports",
        "typescript",
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
          vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
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

        -- Adding Go-specific configuration
        gopls = function(_, opts)
          -- Setup gopls with formatting
          require("lspconfig").gopls.setup({
            on_attach = function(client, bufnr)
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
              -- Enable formatting on save
              if client.server_capabilities.documentFormattingProvider then
                vim.api.nvim_create_autocmd("BufWritePre", {
                  pattern = "*.go",
                  callback = function()
                    vim.lsp.buf.format({ async = true })
                  end,
                })
              end
            end,
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true,
                },
                staticcheck = true,
              },
            },
          })
          return true
        end,
      },
    },
  },
}
