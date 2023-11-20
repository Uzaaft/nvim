return {
  "pmizio/typescript-tools.nvim",
  dependencies = {
    "AstroNvim/astrolsp",
    opts = {
      handlers = { tsserver = false },
      config = {
        ["typescript-tools"] = {
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
        },
      },
    },
  },
  ft = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  opts = function() return require("astrolsp").lsp_opts "typescript-tools" end,
}
