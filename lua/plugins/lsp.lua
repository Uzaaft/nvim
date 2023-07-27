return {
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        clangd = { capabilities = { offsetEncoding = "utf-8" } },
        julials = { autostart = false },
        lua_ls = { settings = { Lua = { hint = { enable = true, arrayIndex = "Disable" } } } },
        taplo = { evenBetterToml = { schema = { catalogs = { "https://www.schemastore.org/api/json/catalog.json" } } } },
        texlab = {
          settings = {
            texlab = {
              build = { onSave = true },
              forwardSearch = { executable = "zathura", args = { "--synctex-forward", "%l:1:%f", "%p" } },
            },
          },
        },
        tsserver = {
          settings = {
            typescript = {
              inlayHints = {
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
            javascript = {
              inlayHints = {
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
          },
        },
      },
      diagnostics = { update_in_insert = false },
      formatting = { format_on_save = { ignore_filetypes = { "julia" } } },
      setup_handlers = {
        tsserver = false,
        clangd = false,
      },
    },
  },
  {
    "jose-elias-alvarez/typescript.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = function() return { server = require("astrolsp").lsp_opts "tsserver" } end,
  },
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    opts = function()
      return {
        server = require("astrolsp").lsp_opts "clangd",
        extensions = { autoSetHints = false },
      }
    end,
  },
}
