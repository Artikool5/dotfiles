-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/conf/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")

vim.keymap.set("i", "<C-l>", "<Esc>ea")

vim.keymap.set("i", ",.", "<Esc>")

-- vim.keymap.set({ "n", "v" }, "<leader><leader>s", function()
--   require("terminal_send").send("sml " .. vim.fn.expand("%:p") .. "\\n")
-- end, { desc = "Run current file in SML/NJ" })

local jump = require("jump-tag")

vim.keymap.set("n", "<A-l>", jump.jumpNextSibling, { noremap = true, silent = true })
vim.keymap.set("n", "<A-h>", jump.jumpPrevSibling, { noremap = true, silent = true })
vim.keymap.set("n", "<A-t>", jump.jumpChild, { noremap = true, silent = true })
vim.keymap.set("n", "<A-n>", jump.jumpParent, { noremap = true, silent = true })
