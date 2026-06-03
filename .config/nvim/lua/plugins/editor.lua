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
