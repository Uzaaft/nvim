return {
  "pmizio/typescript-tools.nvim",
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  dependencies = {
    "AstroNvim/astrolsp",
    opts = { handlers = { tsserver = false } },
  },
  opts = function()
    return require("astrocore").extend_tbl(require("astrolsp").lsp_opts "tsserver", {
      settings = {
        tsserver_path = require("mason-registry").get_package("typescript-language-server"):get_install_path()
          .. "/node_modules/typescript/lib/tsserver.js",
        tsserver_file_preferences = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        },
      },
    })
  end,
}
