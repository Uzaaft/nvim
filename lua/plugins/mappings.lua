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

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      -- first key is the mode
      n = {
        ["q:"] = ":",
        ["-"] = { "<C-x>", desc = "Descrement number" },
        ["+"] = { "<C-a>", desc = "Increment number" },
        ["<leader>s"] = { switch_case },

        -- { "ﬁ", mode = { "n",  } },
        -- { "ª", mode = { "n", "v" } },
        -- { "√", mode = { "n", "v" } },
        -- { "˛", mode = { "n", "v" } },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
  },
}
