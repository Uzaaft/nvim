-- Example customization of mason plugins
return {
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
