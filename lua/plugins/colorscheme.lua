return {
  "AstroNvim/astroui",
  dependencies = {
    "rebelot/kanagawa.nvim",
    lazy = false,
    opts = {
      compile = true,
      transparent = false,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          -- Save an hlgroup with dark background and dimmed foreground
          -- so that you can use it where your still want darker windows.
          -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        }
      end,
    },
  },
  ---@type AstroUIOpts
  opts = {
    colorscheme = "kanagawa",
    style = {
      inactive = true, -- Bool value, toggles inactive window color.
      -- transparent = true, -- Bool value, toggles transperency.transpare
      floating = true, -- Bool value, toggles floating windows background colors.
      popup = true, -- Bool value, toggles popup background color.
      neotree = false, -- Bool value, toggles neo-trees background color.
      italic_comments = true, -- Bool value, toggles italic comments.
    },
  },
}
