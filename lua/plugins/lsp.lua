-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      servers = { "rust_analyzer", "tailwindcss" },
      features = {
        inlay_hints = false,
      },
      diagnostics = {
        update_in_insert = false,
        virtual_text = true,
        underline = true,
      },
      handlers = {
        dart = false,
        tsserver = false,
      },
      formatting = {
        format_on_save = {
          enabled = true, -- enable or disable format on save globally
        },
        timeout_ms = 1000, -- default format timeout
      },
      ---@diagnostic disable: missing-fields
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
        pylance = {
          filetypes = { "python" },
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(unpack {
              "pyproject.toml",
              "setup.py",
              "setup.cfg",
              "requirements.txt",
              "Pipfile",
              "pyrightconfig.json",
            })(...)
          end,
          cmd = { "pylance", "--stdio" },
          single_file_support = true,
          settings = {
            python = {
              pythonPath = vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV .. "/bin/python",
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
                autoImportCompletions = true,
                completeFunctionParens = true,
                indexing = true,
                inlayHints = {
                  variableTypes = true,
                  functionReturnTypes = true,
                  callArgumentNames = true,
                  pytestParameters = true,
                },
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
          handlers = {
            ["workspace/executeCommand"] = function(_, result)
              if result and result.label == "Extract Method" then
                vim.ui.input({ prompt = "New name: ", default = result.data.newSymbolName }, function(input)
                  if input and #input > 0 then vim.lsp.buf.rename(input) end
                end)
              end
            end,
          },
          commands = {
            PylanceExtractMethod = {
              function()
                local arguments =
                  { vim.uri_from_bufnr(0):gsub("file://", ""), require("vim.lsp.util").make_given_range_params().range }
                vim.lsp.buf.execute_command { command = "pylance.extractMethod", arguments = arguments }
              end,
              description = "Extract Method",
              range = 2,
            },
            PylanceExtractVariable = {
              function()
                local arguments =
                  { vim.uri_from_bufnr(0):gsub("file://", ""), require("vim.lsp.util").make_given_range_params().range }
                vim.lsp.buf.execute_command { command = "pylance.extractVariable", arguments = arguments }
              end,
              description = "Extract Variable",
              range = 2,
            },
          },
          docs = {
            description = "https://github.com/microsoft/pylance-release\n\n`pylance`, Fast, feature-rich language support for Python",
          },
        },
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
              updateImportsOnFileMove = "always",
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
              updateImportsOnFileMove = "always",
            },
          },
        },
      },
      capabilities = { workspace = { didChangeWatchedFiles = { dynamicRegistration = false } } },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
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
