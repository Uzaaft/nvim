---@type LazySpec
return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    dashboard = { enabled = false },
    indent = { enabled = false },
    notifier = { timeout = 1000 },
    gitbrowse = {
      config = function(opts)
        table.insert(opts.remote_patterns, 1, { "^ssh://git%.mehalter%.com/(.*)", "https://code.mehalter.com/%1" })
      end,
      url_patterns = {
        ["code%.mehalter%.com"] = {
          branch = "/~files/{branch}",
          file = "/~files/{branch}/{file}?position=source-{line_start}-{line_end}",
          permalink = "/~files/{commit}/{file}?position=source-{line_start}-{line_end}",
          commit = "/~commits/{commit}",
        },
      },
    },
  },
}
