local org_folder = "~/documents/orgfiles/"
local opts = {
  orgmode = {
    org_agenda_files = org_folder .. "**/*",
    org_default_notes_file = org_folder .. "refile.org",
    org_tags_column = 120,
    org_todo_keywords = { 'TODO(t)', 'NEXT', 'WAITING', 'BLOCKED', '|', 'DONE', 'CANCELLED'},
    org_todo_keyword_faces = {
      TODO = ':foreground #f38ba8',
      NEXT = ':foreground #a6e3a1 :weight bold',
      REVIEW = ':foreground #cba6f7',
      WAITING = ':foreground #f9e2af',
      BLOCKED = ':foreground #181825 :background #f38ba8 :weight bold',
      DONE = ':foreground #181825 :background #a6e3a1 :slant italic',
      CANCELLED = ':foreground #808080 :strikethrough on',
    },
    -- 'overview' | 'content' | 'showeverything' | 'inherit'
    org_startup_folded = "content",
  },
  org_super_agenda = {
    org_directories = { org_folder },
  },
}

return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    dependencies = {
      "nvim-orgmode/org-bullets.nvim",
      "Saghen/blink.cmp",
    },
    ft = { "org" },
    config = function()
      require("orgmode").setup(opts.orgmode)
      require("org-bullets").setup()
      require("org-super-agenda").setup(opts.org_super_agenda)
      -- require("headlines").setup()

      -- Experimental LSP support
      vim.lsp.enable("org")
    end,
  },
  -- {
  --   "lukas-reineke/headlines.nvim",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   config = true, -- or `opts = {}`
  -- },
  {
    "hamidi-dev/org-super-agenda.nvim",
    dependencies = {
      "nvim-orgmode/orgmode",
      -- { "lukas-reineke/headlines.nvim", config = true },
    },
    -- config = function ()
    --   require("org-super-agenda").setup(opts.org_super_agenda)
    -- end
  },
}
