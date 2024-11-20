return {
  "MeanderingProgrammer/render-markdown.nvim",
  cmd = "RenderMarkdown",
  ft = function()
    local plugin = require("lazy.core.config").spec.plugins["render-markdown.nvim"]
    local opts = require("lazy.core.plugin").values(plugin, "opts", false)
    return opts.file_types or { "markdown" }
  end,
  opts = {
    pipe_table = { enabled = false },
    sign = { enabled = false },
  },
  specs = {
    {
      "catppuccin",
      optional = true,
      ---@type CatppuccinOptions
      opts = { integrations = { render_markdown = true } },
    },
  },
}
