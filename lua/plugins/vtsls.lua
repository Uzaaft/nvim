return {
  "yioneko/nvim-vtsls",
  lazy = true,
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      autocmds = {
        nvim_vtsls = {
          {
            event = "LspAttach",
            desc = "Load nvim-vtsls with vtsls",
            callback = function(args)
              if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "vtsls" then
                require("vtsls")._on_attach(args.data.client_id, args.buf)
                vim.api.nvim_del_augroup_by_name "nvim_vtsls"
              end
            end,
          },
        },
      },
    },
  },
  config = function(_, opts) require("vtsls").config(opts) end,
}
