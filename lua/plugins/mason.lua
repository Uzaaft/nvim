-- Example customization of mason plugins
return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        -- "python",
        "codelldb",
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      PATH = "append",
      registries = {
        "lua:custom-registry",
        "github:mason-org/mason-registry",
      },
    },
  },
}
