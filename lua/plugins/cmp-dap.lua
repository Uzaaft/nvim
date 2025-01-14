return {
  "rcarriga/cmp-dap",
  lazy = true,
  specs = {
    {
      "Saghen/blink.cmp",
      optional = true,
      dependencies = "rcarriga/cmp-dap",
      specs = { "Saghen/blink.compat", version = "*", lazy = true, opts = {} },
      opts = {
        enabled = function()
          return (
            vim.bo.buftype ~= "prompt"
            or vim.tbl_contains({ "dap-repl", "dapui_watches", "dapui_hover" }, vim.bo.filetype)
          ) and vim.b.completion ~= false
        end,
        sources = {
          per_filetype = {
            ["dap-repl"] = { "dap" },
            ["dapui_watches"] = { "dap" },
            ["dapui_hover"] = { "dap" },
          },
          providers = {
            dap = {
              name = "dap",
              module = "blink.compat.source",
              score_offset = 100,
            },
          },
        },
      },
    },
  },
}
