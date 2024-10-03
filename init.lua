-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.maplocalleader = "\\"

vim.g.mapleader = " "
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>y', ':%y+<CR>', { noremap = true, silent = true })

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',  -- Highlight group to use
            timeout = 300,           -- Time in milliseconds the highlight lasts
        })
    end,
})


vim.diagnostic.config({
    virtual_text = true,  -- Disable virtual text if you don't want inline errors
    float = {
        border = "rounded",
        wrap = true,  -- Enable wrapping in diagnostic floats
    },
})



-- Simple brace generation without adding lines or indent
vim.api.nvim_set_keymap('i', '{', '{}<Esc>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '(', '()<Esc>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '[', '[]<Esc>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '"', '""<Esc>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', "'", "''<Esc>i", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '`', '``<Esc>i', { noremap = true, silent = true })


vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"
require("lazy").setup("plugins")

