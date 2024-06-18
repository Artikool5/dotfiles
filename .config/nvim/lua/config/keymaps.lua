-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/conf/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")

vim.keymap.set("i", "<C-l>", "<Esc>la")

vim.keymap.set("i", ",.", "<Esc>")

vim.keymap.set({ "n", "v" }, "<leader>cw", require("nvim-emmet").wrap_with_abbreviation)
-- vim.keymap.set({ "n", "v" }, "<leader><leader>s", function()
--   require("terminal_send").send("sml " .. vim.fn.expand("%:p") .. "\\n")
-- end, { desc = "Run current file in SML/NJ" })

-- local jump = require("jump-tag")
--
-- vim.keymap.set("n", "<A-l>", jump.jumpNextSibling, { noremap = true, silent = true })
-- vim.keymap.set("n", "<A-h>", jump.jumpPrevSibling, { noremap = true, silent = true })
-- vim.keymap.set("n", "<A-t>", jump.jumpChild, { noremap = true, silent = true })
-- vim.keymap.set("n", "<A-n>", jump.jumpParent, { noremap = true, silent = true })

local TC = require("tree-climber")
local keyopts = { noremap = true, silent = true }
vim.keymap.set({ "n", "v", "o" }, "<C-k>", TC.goto_parent, keyopts)
vim.keymap.set({ "n", "v", "o" }, "<C-j>", TC.goto_child, keyopts)
vim.keymap.set({ "n", "v", "o" }, "<C-l>", TC.goto_next, keyopts)
vim.keymap.set({ "n", "v", "o" }, "<C-h>", TC.goto_prev, keyopts)
vim.keymap.set({ "v", "o" }, "in", TC.select_node, keyopts)
vim.keymap.set("n", "<A-k>", TC.swap_prev, keyopts)
vim.keymap.set("n", "<A-j>", TC.swap_next, keyopts)
vim.keymap.set("n", "<A-h>", TC.highlight_node, keyopts)
