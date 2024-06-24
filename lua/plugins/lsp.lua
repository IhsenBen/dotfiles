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
	{ "digitaltoad/vim-pug" },
	{ "dNitro/vim-pug-complete" },
}
