---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    autocmds = {
      no_insert_inlay_hints = {
        cond = vim.lsp.inlay_hint and "textDocument/inlayHint" or false,
        {
          event = "InsertEnter",
          desc = "disable inlay hints on insert",
          callback = function(args)
            local filter = { bufnr = args.buf }
            if vim.lsp.inlay_hint.is_enabled(filter) then
              vim.lsp.inlay_hint.enable(false, filter)
              vim.api.nvim_create_autocmd("InsertLeave", {
                buffer = args.buf,
                once = true,
                callback = function() vim.lsp.inlay_hint.enable(true, filter) end,
              })
            end
          end,
        },
      },
    },
    ---@diagnostic disable: missing-fields
    config = {
      basedpyright = {
        before_init = function(_, c)
          if not c.settings then c.settings = {} end
          if not c.settings.python then c.settings.python = {} end
          c.settings.python.pythonPath = vim.fn.exepath "python"
        end,
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "basic",
              autoImportCompletions = true,
              stubPath = vim.env.HOME .. "/typings",
              diagnosticSeverityOverrides = {
                reportUnusedImport = "information",
                reportUnusedFunction = "information",
                reportUnusedVariable = "information",
                reportGeneralTypeIssues = "none",
                reportOptionalMemberAccess = "none",
                reportOptionalSubscript = "none",
                reportPrivateImportUsage = "none",
              },
            },
          },
        },
      },
      clangd = { capabilities = { offsetEncoding = "utf-8" } },
      gopls = {
        settings = {
          gopls = {
            codelenses = {
              generate = true, -- show the `go generate` lens.
              gc_details = true, -- Show a code lens toggling the display of gc's choices.
              test = true,
              tidy = true,
              vendor = true,
              regenerate_cgo = true,
              upgrade_dependency = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            semanticTokens = true,
          },
        },
      },
      julials = { autostart = false },
      lua_ls = { settings = { Lua = { hint = { enable = true, arrayIndex = "Disable" } } } },
      markdown_oxide = { capabilities = { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } } },
      ruff = { on_attach = function(client) client.server_capabilities.hoverProvider = false end },
      taplo = { evenBetterToml = { schema = { catalogs = { "https://www.schemastore.org/api/json/catalog.json" } } } },
      texlab = {
        on_attach = function(_, bufnr)
          require("astrocore").set_mappings({
            n = {
              ["<Leader>lB"] = { "<Cmd>TexlabBuild<CR>", desc = "LaTeX Build" },
              ["<Leader>lF"] = { "<Cmd>TexlabForward<CR>", desc = "LaTeX Forward Search" },
            },
          }, { buffer = bufnr })
        end,
        settings = {
          texlab = {
            build = { onSave = true },
            forwardSearch = { executable = "zathura", args = { "--synctex-forward", "%l:1:%f", "%p" } },
          },
        },
      },
      typos_lsp = { single_file_support = false },
      vtsls = {
        settings = {
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
      },
    },
  },
}
