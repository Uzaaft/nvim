return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    servers = { "pylance" },
    ---@diagnostic disable: missing-fields
    config = {
      clangd = { capabilities = { offsetEncoding = "utf-8" } },
      julials = { autostart = false },
      lua_ls = { settings = { Lua = { hint = { enable = true, arrayIndex = "Disable" } } } },
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
            build = {
              args = { "-shell-escape", "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
              onSave = true,
            },
            forwardSearch = { executable = "zathura", args = { "--synctex-forward", "%l:1:%f", "%p" } },
          },
        },
      },
      tsserver = {
        settings = {
          typescript = {
            inlayHints = {
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
          javascript = {
            inlayHints = {
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
    capabilities = { workspace = { didChangeWatchedFiles = { dynamicRegistration = false } } },
    diagnostics = { update_in_insert = false },
    formatting = { format_on_save = { ignore_filetypes = { "julia" } } },
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
}
