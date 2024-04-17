---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = "catppuccin",
    highlights = {
      init = function(colors_name)
        local get_hlgroup = require("astroui").get_hlgroup

        -- Global Highlights --
        local highlights = {
          CursorLineFold = { link = "CursorLineNr" }, -- highlight fold indicator as well as line number
          GitSignsCurrentLineBlame = { fg = get_hlgroup("NonText").fg, italic = true }, -- italicize git blame virtual text
          ZenBg = { link = "Normal" }, -- Set zen-mode background to Normal mode
        }

        -- NvChad like Telescope Theme --
        if not colors_name:match "^catppuccin.*" then
          local normal = get_hlgroup "Normal"
          local fg, bg = normal.fg, normal.bg
          local bg_alt = get_hlgroup("Visual").bg
          local green = get_hlgroup("String").fg
          local red = get_hlgroup("Error").fg
          highlights.TelescopeBorder = { fg = bg_alt, bg = bg }
          highlights.TelescopeNormal = { bg = bg }
          highlights.TelescopePreviewBorder = { fg = bg, bg = bg }
          highlights.TelescopePreviewNormal = { bg = bg }
          highlights.TelescopePreviewTitle = { fg = bg, bg = green }
          highlights.TelescopePromptBorder = { fg = bg_alt, bg = bg_alt }
          highlights.TelescopePromptNormal = { fg = fg, bg = bg_alt }
          highlights.TelescopePromptPrefix = { fg = red, bg = bg_alt }
          highlights.TelescopePromptTitle = { fg = bg, bg = red }
          highlights.TelescopeResultsBorder = { fg = bg, bg = bg }
          highlights.TelescopeResultsNormal = { bg = bg }
          highlights.TelescopeResultsTitle = { fg = bg, bg = bg }
        end

        return highlights
      end,
    },
  },
}
