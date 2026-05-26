-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- formatting on save
vim.g.autoformat = false

vim.o.relativenumber = false
vim.o.tildeop = true
vim.o.inccommand = "split"
vim.o.previewheight = 20

vim.o.langmap =
  "йp,цl,уd,кw,еz,нj,гf,шo,щu,з\\,,х\\;,ъ]," ..
  "фn,ыr,вt,аs,пg,рy,оh,лa,дe,жi,э/," ..
  "яq,чx,сb,мc,иv,тk,ьm,б\\',юy"
