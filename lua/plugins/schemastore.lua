---@type LazySpec
return {
  "b0o/SchemaStore.nvim",
  specs = {
    {
      "AstroNvim/astrolsp",
      opts = {
        config = {
          jsonls = {
            before_init = function(_, config)
              if not config.settings.json.schemas then config.settings.json.schemas = {} end
              vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
            end,
            settings = { json = { validate = { enable = true } } },
          },
          yamlls = {
            before_init = function(_, config)
              config.settings.yaml.schemas =
                vim.tbl_deep_extend("force", config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
            end,
            settings = { yaml = { schemaStore = { enable = false, url = "" } } },
          },
        },
      },
    },
  },
}
