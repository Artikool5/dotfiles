return {
  { "folke/flash.nvim", opts = {
    labels = "aoeuhtnsidpgcrlqjkvwmbxyfz",
  } },
  {
    "barrett-ruth/live-server.nvim",
    build = "pnpm add -g live-server",
    cmd = { "LiveServerStart", "LiveServerStop" },
    config = true,
  },
  -- {
  -- 	"saghen/blink.cmp",
  -- 	-- Don't show completion menu until key is pressed
  -- 	opts = {
  -- 		completion = {
  -- 			-- Completion still works in the background and it's possible to `C-y` to insert
  -- 			-- Uncomment to disable completely
  -- 			trigger = { show_on_keyword = false, show_on_trigger_character = false },
  -- 			menu = {
  -- 				auto_show = false,
  -- 			},
  -- 		},
  -- 	},
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Shells
        "bash",
        "fish",

        -- Web
        "javascript",
        "typescript",
        "html",
        "css",
        "csv",
        "graphql",
        "http",

        -- ???
        "c",
        "make",
        "cpp",

        -- configs
        "lua",
        "luadoc",
        "json",
        "jsdoc",
        "yaml",
        "toml",
        "ini",
        "xml",

        -- extra?
        "markdown",
        "markdown_inline",
        "regex",
      },
    },
  },
}
