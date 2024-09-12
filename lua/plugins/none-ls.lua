-- to add a new linter/ formatter, add its source here and go download it from mason by runnint the "Mason" commmand
return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				-- prettier not working
				null_ls.builtins.completion.spell,
				null_ls.builtins.formatting.prettier,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
