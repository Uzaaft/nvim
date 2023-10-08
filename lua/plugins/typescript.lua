return {
  "pmizio/typescript-tools.nvim",
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  opts = function()
    return require("astrocore").extend_tbl(require("astrolsp").lsp_opts "tsserver", {
      settings = {
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
