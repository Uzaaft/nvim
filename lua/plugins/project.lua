---@type LazySpec
return {
  "jay-babu/project.nvim",
  name = "project_nvim",
  event = "VeryLazy",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        opts.mappings.n["<Leader>fp"] = { "<Cmd>Telescope projects<CR>", desc = "Find projects" }
      end,
    },
  },
  init = function()
    require("astrocore").on_load("telescope.nvim", function() require("telescope").load_extension "projects" end)
  end,
  opts = { ignore_lsp = { "lua_ls", "julials" } },
}
