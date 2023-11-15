return {
  "HiPhish/rainbow-delimiters.nvim",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          auto_disable_rainbow_delimeters = {
            {
              event = "BufRead",
              callback = function(args)
                if vim.b[args.buf].large_buf then require("rainbow-delimiters").disable(args.buf) end
              end,
            },
          },
        },
        mappings = {
          n = {
            ["<Leader>ur"] = {
              function()
                require("rainbow-delimiters").toggle(0)
                require("astrocore").notify(
                  string.format(
                    "Buffer rainbow delimeters %s",
                    require("rainbow-delimiters.lib").buffers[vim.api.nvim_get_current_buf()] and "on" or "off"
                  )
                )
              end,
              desc = "Toggle rainbow delimeters (buffer)",
            },
          },
        },
      },
    },
  },
  event = "User AstroFile",
  main = "rainbow-delimiters.setup",
  opts = {},
}
