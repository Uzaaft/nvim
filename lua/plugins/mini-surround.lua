---@type LazySpec
return {
  "echasnovski/mini.surround",
  keys = {
    { "sa", desc = "Add surrounding", mode = { "n", "v" } },
    { "sd", desc = "Delete surrounding" },
    { "sf", desc = "Find right surrounding" },
    { "sF", desc = "Find left surrounding" },
    { "sh", desc = "Highlight surrounding" },
    { "sr", desc = "Replace surrounding" },
    { "sn", desc = "Update `MiniSurround.config.n_lines`" },
  },
  opts = { n_lines = 200 },
}
