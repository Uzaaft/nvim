-- AstroCore provides a central place to modify mappings set up as well as which-key menu titles
local function switch_case()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local word = vim.fn.expand "<cword>"
  local word_start = vim.fn.matchstrpos(vim.fn.getline ".", "\\k*\\%" .. (col + 1) .. "c\\k*")[2]

  -- Detect camelCase
  if word:find "[a-z][A-Z]" then
    -- Convert camelCase to snake_case
    local snake_case_word = word:gsub("([a-z])([A-Z])", "%1_%2"):lower()
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { snake_case_word })
  -- Detect snake_case
  elseif word:find "_[a-z]" then
    -- Convert snake_case to camelCase
    local camel_case_word = word:gsub("(_)([a-z])", function(_, l) return l:upper() end)
    vim.api.nvim_buf_set_text(0, line - 1, word_start, line - 1, word_start + #word, { camel_case_word })
  else
    print "Not a snake_case or camelCase word"
  end
end

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
      ["<leader>s"] = { switch_case },

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
