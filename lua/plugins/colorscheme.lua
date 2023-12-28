return {
  "AstroNvim/astroui",
  dependencies = {
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      ---@type CatppuccinOptions
      opts = {
        transparent_background = true,
        dim_inactive = {
          enabled = true,
          percentage = 0.1,
        },
        integrations = {
          mini = true,
          noice = true,
          notify = true,
          ufo = true,
          overseer = true,
          telescope = {
            enabled = true,
          },
          which_key = true,
        },
      },
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
