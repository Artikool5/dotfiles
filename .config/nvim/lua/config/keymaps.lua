-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/conf/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")

vim.keymap.set("i", "<C-l>", "<Esc>la")

vim.keymap.set("i", ",.", "<Esc>")

vim.keymap.set({ "n", "v" }, "<leader>cw", require("nvim-emmet").wrap_with_abbreviation)

vim.keymap.set(
	{ "n", "v" },
	"<leader>e",
	require("mini.files").open,
	{ noremap = true, silent = true, desc = "Explore files" }
)

local TC = require("tree-climber")
local keyopts = { noremap = true, silent = true }
vim.keymap.set({ "n", "v", "o" }, "<C-k>", TC.goto_parent, keyopts)
vim.keymap.set({ "n", "v", "o" }, "<C-j>", TC.goto_child, keyopts)
vim.keymap.set({ "n", "v", "o" }, "<C-l>", TC.goto_next, keyopts)
vim.keymap.set({ "n", "v", "o" }, "<C-h>", TC.goto_prev, keyopts)
vim.keymap.set({ "v", "o" }, "inn", TC.select_node, keyopts)
vim.keymap.set("n", "<A-k>", TC.swap_prev, keyopts)
vim.keymap.set("n", "<A-j>", TC.swap_next, keyopts)
