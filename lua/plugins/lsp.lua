return {
  "p00f/clangd_extensions.nvim",
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      config = {
        clangd = {
          capabilities = { offsetEncoding = "utf-8" },
          on_attach = function() pcall(require, "clangd_extensions") end,
        },
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
      },
      diagnostics = { update_in_insert = false },
      formatting = { format_on_save = { ignore_filetypes = { "julia" } } },
      handlers = {
        tsserver = false, -- handled by typescript-tools.nvim
      },
      mappings = {
        i = {
          ["<C-l>"] = {
            function() vim.lsp.buf.signature_help() end,
            desc = "Signature help",
            cond = "textDocument/signatureHelp",
          },
        },
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
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
  },
}
