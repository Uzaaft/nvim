-- Remember my mappings.
return {
  {
    "echasnovski/mini.clue",
    event = "VeryLazy",
    opts = function()
      local miniclue = require "mini.clue"
      return {
        triggers = {
          -- Builtins.
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "`" },
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },
          { mode = "n", keys = "<C-w>" },
          { mode = "n", keys = "z" },
          -- Leader triggers.
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },
          -- Moving between stuff.
          { mode = "n", keys = "[" },
          { mode = "n", keys = "]" },
        },
        clues = {
          -- Leader/movement groups.
          -- Useful builtins.
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
        },
        window = {
          delay = 300,
          scroll_down = "<C-f>",
          scroll_up = "<C-b>",
          config = function(bufnr)
            local max_width = 0
            for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
              max_width = math.max(max_width, vim.fn.strchars(line))
            end

            -- Keep some right padding.
            max_width = max_width + 2

            return {
              border = "rounded",
              -- Dynamic width capped at 45.
              width = math.min(45, max_width),
            }
          end,
        },
      }
    end,
  },
}
