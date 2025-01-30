local servers = {} -- only add local servers if their commands are available
for server, cmd in pairs { julials = "julia" } do
  if vim.fn.executable(cmd) == 1 then table.insert(servers, server) end
end

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
    servers = servers,
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
      julials = {
        on_new_config = function(new_config)
          -- check for nvim-lspconfig julia sysimage shim
          local found_shim
          for _, depot in
            ipairs(
              vim.env.JULIA_DEPOT_PATH and vim.split(vim.env.JULIA_DEPOT_PATH, vim.fn.has "win32" == 1 and ";" or ":")
                or { vim.fn.expand "~/.julia" }
            )
          do
            local bin = vim.fs.joinpath(depot, "environments", "nvim-lspconfig", "bin", "julia")
            local file = (vim.uv or vim.loop).fs_stat(bin)
            if file and file.type == "file" then
              found_shim = bin
              break
            end
          end
          if found_shim then
            new_config.cmd[1] = found_shim
          else
            new_config.autostart = false -- only auto start if sysimage is available
          end
        end,
        on_attach = function(client)
          local environment = vim.tbl_get(client, "settings", "julia", "environmentPath")
          if environment then client.notify("julia/activateenvironment", { envPath = environment }) end
        end,
        settings = {
          julia = {
            completionmode = "qualify",
            lint = { missingrefs = "none" },
          },
        },
      },
      lua_ls = { settings = { Lua = { hint = { enable = true, arrayIndex = "Disable" } } } },
      markdown_oxide = { capabilities = { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } } },
      metals = {
        settings = {
          inlayHints = {
            hintsInPatternMatch = { enable = true },
            implicitArguments = { enable = true },
            implicitConversions = { enable = true },
            inferredTypes = { enable = true },
            typeParameters = { enable = true },
          },
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
            build = { onSave = true },
            forwardSearch = { executable = "zathura", args = { "--synctex-forward", "%l:1:%f", "%p" } },
          },
        },
      },
      typos_lsp = { single_file_support = false },
      volar = { init_options = { vue = { hybridMode = true } } },
      vtsls = {
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "vue",
        },

        before_init = function(_, config)
          local registry_ok, registry = pcall(require, "mason-registry")
          if not registry_ok then return end
          local vuels = registry.get_package "vue-language-server"

          if vuels:is_installed() then
            local volar_install_path = vuels:get_install_path() .. "/node_modules/@vue/language-server"

            local vue_plugin_config = {
              name = "@vue/typescript-plugin",
              location = volar_install_path,
              languages = { "vue" },
              configNamespace = "typescript",
              enableForWorkspaceTypeScriptVersions = true,
            }

            require("astrocore").list_insert_unique(config.settings.vtsls.tsserver.globalPlugins, { vue_plugin_config })
          end
        end,
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {},
            },
          },
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
    mason_lspconfig = {
      servers = {
        nextflow_ls = {
          package = "nextflow-language-server", -- required package name in Mason (string)
          filetypes = { "nextflow" }, -- required filetypes that apply (string or a list of strings)
          config = { -- optional default configuration changes (table or a function that returns a table)
            cmd = { "nextflow-language-server" },
          },
        },
      },
    },
  },
}
