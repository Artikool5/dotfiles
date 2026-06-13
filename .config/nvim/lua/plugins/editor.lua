return {
  { "folke/flash.nvim", opts = {
    labels = "nrtshaeibmwoduluzfxqyp",
  } },
  {
    "barrett-ruth/live-server.nvim",
    build = "pnpm add -g live-server",
    cmd = { "LiveServerStart", "LiveServerStop" },
    config = true,
  },
  {
    "saghen/blink.cmp",
    -- Stick to stable version to get binaries for faster fuzzy matching
    version = "*",
    opts = {
      keymap = { preset = "default" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Languages
        "fish",
        "bash",
        "asm",
        "c",
        "cpp",
        "html",
        "css",
        "javascript",
        "tsx",
        "graphql",
        "lua",
        "markdown",
        "odin",
        "sql",

        -- Configs
        "desktop",
        "dockerfile",
        "dot",
        "git_config",
        "make",
        "cmake",
        "toml",
        "yaml",
        "json",
        "ini",
        "kitty",

        -- Misc / Other
        "doxygen",
        "comment",
        "disassembly",
        "git_rebase",
        "luadoc",
        "http",
        "objdump",
      },
    },
  },
}
