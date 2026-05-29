return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavor = "mocha",
      transparent_background = true,
      float = { transparent = true },
      styles = {
        keywords = { "bold" },
        conditionals = { "bold" },
        loops = { "bold" },
      },
      custom_highlights = function(colors)
        return {
          -- Normal = { bg = colors.mantle },
          -- NormalNC = { bg = colors.mantle },
          -- EndOfBuffer = { bg = colors.mantle },
          ["@function.call"] = { link = "@function" },
          ["@function.builtin"] = { link = "@function" },
          ["@function.method"] = { link = "@function" },
          ["@function.macro"] = { fg = colors.teal, style = { "bold" } },
          ["@lsp.type.macro"] = { fg = colors.teal, style = { "bold" } },

          ["@variable"] = { fg = colors.text },
          ["@variable.member"] = { fg = colors.text },
          ["@constant.builtin"] = { link = "@constant" },
          ["@property"] = { fg = colors.text },
          ["@field"] = { fg = colors.text },

          ["@type.builtin"] = { link = "@type" },
        }
      end,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    } },
  },
  { "blazkowolf/gruber-darker.nvim" },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-nvim" },
  },
}
