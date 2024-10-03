return {
    {
        "hrsh7th/cmp-nvim-lsp",
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip", -- for autocompletion
            "rafamadriz/friendly-snippets", -- useful snippets

            "hrsh7th/cmp-buffer",  -- source for text in buffer
            "hrsh7th/cmp-path",    -- source for file system paths
            "onsails/lspkind.nvim", -- vs-code like pictograms
        },
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")

            local luasnip = require("luasnip")

            local lspkind = require("lspkind")
            require("luasnip.loaders.from_vscode").lazy_load()
            vim.opt.shortmess:append("c")
            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,preview,noselect",
                },
                snippet = { -- configure how nvim-cmp interacts with snippet engine
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                    ["<C-b>"] = cmp.mapping.scroll_docs(5),
                    ["<C-f>"] = cmp.mapping.scroll_docs(-5),
                    ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                }),
                -- sources for autocompletion
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "path" },

                    { name = "buffer" },
                    { name = "luasnip" },
                }),
                vim.keymap.set({ "i", "s" }, "<C-l>", function()
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { silent = true }),

                vim.keymap.set({ "i", "s" }, "<C-h>", function()
                    if luasnip.expand_or_jumpable(-1) then
                        luasnip.expand_or_jump(-1)
                    end
                end, { silent = true }),
                luasnip.config.set_config({
                    history = false,
                    updateevents = "TextChanged,TextChangedI",
                }),
                -- configure lspkind for vs-code like pictograms in completion menu
                formatting = {
                    format = lspkind.cmp_format({
                        maxwidth = 50,
                        ellipsis_char = "...",
                    }),
                },
            })
        end,
    },
}
