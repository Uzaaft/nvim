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
    n = {},
  },
}

local function better_search(key)
  return function()
    local searched, error =
      pcall(vim.cmd.normal, { args = { (vim.v.count > 0 and vim.v.count or "") .. key }, bang = true })
    if not searched and type(error) == "string" then require("astrocore").notify(error, vim.log.levels.ERROR) end
  end
end
opts.mappings.n.n = { better_search "n", desc = "Next search" }
opts.mappings.n.N = { better_search "N", desc = "Previous search" }
opts.mappings.n.ga = { function() require("gitsigns").stage_hunk() end, desc = "Stage hunk" }
opts.mappings.n.gA = { function() require("gitsigns").undo_stage_hunk() end, desc = "Undo stage hunk" }
opts.mappings.n.gc = { function() require("tinygit").smartCommit() end, desc = "Commit" }
opts.mappings.n.gp = { function() require("tinygit").push() end, desc = "push" }

return { "AstroNvim/astrocore", opts = opts }
