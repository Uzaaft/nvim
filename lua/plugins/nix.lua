return {
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      local astrocore = require "astrocore"
      opts.servers = astrocore.list_insert_unique(opts.servers, { "nixd" })
      return astrocore.extend_tbl(opts, {
        config = {
          nixd = {
            settings = {
              nixd = {
                formatting = {
                  command = { "alejandra" },
                },
              },
            },
          },
        },
      })
    end,
  },
}
