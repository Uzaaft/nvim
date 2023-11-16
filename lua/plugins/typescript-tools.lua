return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "AstroNvim/astrolsp", opts = { handlers = { tsserver = false } } },
  ft = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  opts = function()
    -- get AstroLSP provided options like `on_attach` and `capabilities`
    return require("astrocore").extend_tbl(require("astrolsp").lsp_opts "typescript-tools", {
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    })
  end,
}
