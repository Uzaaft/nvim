return {
  "AstroNvim/astroui",
  dependencies = {
    { "catppuccin/nvim", name = "catppuccin", opts = {
      no_italic = true,
    } },
    {
      "rose-pine/neovim",
      name = "rose-pine",
      priority = 1000,
      opts = {
        disable_background = true,
      },
      init = function()
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      end,
    },
  },
  ---@type AstroUIOpts
  opts = {
    style = {
      inactive = true, -- Bool value, toggles inactive window color.
      -- transparent = true, -- Bool value, toggles transperency.transpare
      floating = true, -- Bool value, toggles floating windows background colors.
      popup = true, -- Bool value, toggles popup background color.
      neotree = false, -- Bool value, toggles neo-trees background color.
      italic_comments = false, -- Bool value, toggles italic comments.
    },
    colorscheme = "catppuccin",
  },
}
