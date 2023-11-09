return {
  { "AstroNvim/astrolsp", opts = { formatting = { disabled = true } } },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          opts.commands.Format = {
            function(args)
              local range = nil
              if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                  start = { args.line1, 0 },
                  ["end"] = { args.line2, end_line:len() },
                }
              end
              require("conform").format { async = true, lsp_fallback = true, range = range }
            end,
            desc = "Format buffer",
            range = true,
          }
          opts.mappings.n["<leader>lf"] = { function() vim.cmd.Format() end, desc = "Format buffer" }
        end,
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
      format_on_save = {
        lsp_fallback = true,
      },
    },
    init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
  },
}
