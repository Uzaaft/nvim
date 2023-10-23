-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      features = {
        inlay_hints = true,
      },
      diagnostics = {
        virtual_text = true,
        underline = true,
      },
      handlers = {
        dart = false,
        rust_analyzer = false,
      },
      formatting = {
        format_on_save = {
          enabled = true, -- enable or disable format on save globally
        },
        timeout_ms = 1000, -- default format timeout
      },

      -- customize language server configuration options passed to `lspconfig`
      config = {
        clangd = { capabilities = { offsetEncoding = "utf-8" } },
        julials = { autostart = false },
        lua_ls = { settings = { Lua = { hint = { enable = true, arrayIndex = "Disable" } } } },
        taplo = { evenBetterToml = { schema = { catalogs = { "https://www.schemastore.org/api/json/catalog.json" } } } },
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
              assist = {
                importEnforceGranularity = true,
                importPrefix = "crate",
              },
              completion = {
                postfix = {
                  enable = false,
                },
              },
              inlayHints = {
                lifetimeElisionHints = {
                  enable = true,
                  useParameterNames = true,
                },
              },
            },
          },
        },
      },
      -- mappings to be set up on attaching of a language server
      mappings = {
        n = {
          gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
        },
      },
    },
  },
  {
    "p00f/clangd_extensions.nvim",
    init = function()
      local augroup = vim.api.nvim_create_augroup("clangd_extensions", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = augroup,
        desc = "Load clangd_extensions with clangd",
        callback = function(args)
          if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "clangd" then
            require "clangd_extensions"
            vim.api.nvim_del_augroup_by_id(augroup)
          end
        end,
      })
    end,
  },
}
