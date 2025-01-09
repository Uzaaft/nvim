return {
  "echasnovski/mini.snippets",
  dependencies = "rafamadriz/friendly-snippets",
  opts_extend = { "snippets" },
  opts = function(_, opts)
    local mini_snippets = require "mini.snippets"
    local gen_loader = mini_snippets.gen_loader
    opts.snippets = vim.list_extend(opts.snippets or {}, {
      -- global snippets file
      gen_loader.from_file(vim.fn.stdpath "config" .. "/snippets/global.json"),
      -- load language specific snippets from runtime
      gen_loader.from_lang(),
      -- load global, project local snippets
      gen_loader.from_file ".vscode/project.code-snippets",
      -- load language specific, project local snippets
      function(context)
        local rel_path = ".vscode/" .. context.lang .. ".code-snippets"
        return vim.fn.filereadable(rel_path) == 1 and mini_snippets.read_file(rel_path)
      end,
    })
  end,
  specs = {
    {
      "Saghen/blink.cmp",
      dependencies = "echasnovski/mini.snippets",
      optional = true,
      opts = { snippets = { preset = "mini_snippets" } },
    },
    -- HACK: remove when fixed upstream
    { "AstroNvim/astrocore", opts = { options = { opt = { showmode = true } } } },
    { "L3MON4D3/LuaSnip", enabled = false },
  },
}
