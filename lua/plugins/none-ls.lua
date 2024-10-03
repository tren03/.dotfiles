return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.shfmt,
                -- null_ls.builtins.completion.spell,
                null_ls.builtins.formatting.prettier.with({ extra_args = { "--tab-width", "4", } }),
            },
        })
        vim.keymap.set("n", "<leader>gf", function()
            local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
            local null_ls_client = nil
            local ts_ls_active = false

            for _, client in pairs(clients) do
                if client.name == "ts_ls" then
                    ts_ls_active = true
                elseif client.name == "null-ls" then
                    null_ls_client = client
                end
            end

            if ts_ls_active and null_ls_client then
                -- Use null-ls for formatting
                print("ts_ls is active. Using null-ls for formatting.")
                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf(), client_id = null_ls_client.id })
            elseif not ts_ls_active then
                -- If ts_ls is not active, fall back to the default formatter
                print("Using default LSP formatter.")
                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            else
                print("null-ls is not available.")
            end
        end, {})
    end,
}
