return {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },

  before_init = function(_, config)
    local registry_ok, registry = pcall(require, "mason-registry")
    if not registry_ok then return end
    local vuels = registry.get_package "vue-language-server"

    if vuels:is_installed() then
      local volar_install_path = vim.fn.expand "$MASON/packages/vue-language-server/node_modules/@vue/language-server"

      local vue_plugin_config = {
        name = "@vue/typescript-plugin",
        location = volar_install_path,
        languages = { "vue" },
        configNamespace = "typescript",
        enableForWorkspaceTypeScriptVersions = true,
      }

      require("astrocore").list_insert_unique(config.settings.vtsls.tsserver.globalPlugins, { vue_plugin_config })
    end
  end,
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {},
      },
    },
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = false },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true, suppressWhenTypeMatchesName = false },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
      updateImportsOnFileMove = { enabled = "always" },
    },
    javascript = {
      inlayHints = {
        parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = false },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true, suppressWhenTypeMatchesName = false },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
      updateImportsOnFileMove = { enabled = "always" },
    },
  },
}
