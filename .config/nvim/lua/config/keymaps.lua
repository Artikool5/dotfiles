-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set('n', '<leader>;', function()
    local line = vim.fn.getline('.')
    vim.fn.setline(".", line .. ";")
end, { desc = "Append semicolon at end of line" })
