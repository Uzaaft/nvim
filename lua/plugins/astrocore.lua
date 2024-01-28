---@type AstroCoreOpts
local opts = {
  features = {
    max_file = { size = 1024 * 100, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
    autopairs = true, -- enable autopairs at start
    cmp = true, -- enable completion at start
    highlighturl = true, -- highlight URLs at start
    notifications = true, -- enable notifications at start
  },
  autocmds = {
    auto_spell = {
      {
        event = "FileType",
        desc = "Enable wrap and spell for text like documents",
        pattern = { "gitcommit", "markdown", "text", "plaintex" },
        callback = function()
          vim.opt_local.wrap = true
          vim.opt_local.spell = true
        end,
      },
    },
    autohide_tabline = {
      {
        event = "User",
        desc = "Auto hide tabline",
        pattern = "AstroBufsUpdated",
        callback = function()
          local new_showtabline = #vim.t.bufs > 1 and 2 or 1
          if new_showtabline ~= vim.opt.showtabline:get() then vim.opt.showtabline = new_showtabline end
        end,
      },
    },
  },
  mappings = {
    n = {
      -- better buffer navigation
      ["]b"] = false,
      ["[b"] = false,
      ["L"] = {
        function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
        desc = "Next buffer",
      },
      ["H"] = {
        function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
        desc = "Previous buffer",
      },
    },
  },
}

return { "AstroNvim/astrocore", opts = opts }
