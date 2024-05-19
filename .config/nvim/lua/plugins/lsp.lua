return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.root_dir = opts.root_dir
        or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
      opts.sources = vim.list_extend(opts.sources or {}, {})
      nls.builtins.formatting.biome.with({
        filetype = { "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescriptreact" },
        args = {
          "check",
          "--apply-unsafe",
          "--formatter-enabled=true",
          "--organize-imports-enabled=true",
          "--skip-errors",
          "--stdin-file-path=$FILENAME",
        },
      })
    end,
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   ---@class PlaginLspOpts
  --   opts = {
  --     inlay_hints = { enabled = true },
  --     codelens = { enabled = true },
  --     ---@type lspconfig.options
  --     servers = {
  --       millet = {},
  --     },
  --   },
  -- },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   opts = {
  --     automatic_installation = {
  --       exclude = { "millet" },
  --     },
  --   },
  -- },
}
