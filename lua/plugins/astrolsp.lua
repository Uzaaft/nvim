local servers = {} -- only add local servers if their commands are available
for server, cmd in pairs { julials = "julia" } do
  if vim.fn.executable(cmd) == 1 then table.insert(servers, server) end
end

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = { signature_help = true },
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
    commands = {
      JuliaActivateEnv = {
        cond = function(client) return client.name == "julials" end,
        function(args)
          local bufnr = vim.api.nvim_get_current_buf()
          local julials_clients = (vim.lsp.get_clients or vim.lsp.get_active_clients) { bufnr = bufnr, name = "julials" }
          if #julials_clients == 0 then
            vim.notify(
              "method julia/activateenvironment is not supported by any servers active on the current buffer",
              vim.log.levels.WARN
            )
            return
          end
          local julia_project_files = { "Project.toml", "JuliaProject.toml" }
          local function _activate_env(environment)
            if environment then
              for _, julials_client in ipairs(julials_clients) do
                julials_client.notify("julia/activateenvironment", { envPath = environment })
              end
              vim.notify("Julia environment activated: \n`" .. environment .. "`", vim.log.levels.INFO)
            end
          end
          if args.args ~= "" then
            local path = vim.fs.normalize(require("plenary.path"):new(args.args):expand())
            local found_env = false
            for _, project_file in ipairs(julia_project_files) do
              local file = (vim.uv or vim.loop).fs_stat(vim.fs.joinpath(path, project_file))
              if file and file.type then
                found_env = true
                break
              end
            end
            if not found_env then
              vim.notify("Path is not a julia environment: \n`" .. path .. "`", vim.log.levels.WARN)
              return
            end
            _activate_env(path)
          else
            local depot_paths = vim.env.JULIA_DEPOT_PATH
                and vim.split(vim.env.JULIA_DEPOT_PATH, vim.fn.has "win32" == 1 and ";" or ":")
              or { vim.fn.expand "~/.julia" }
            local environments = {}
            vim.list_extend(
              environments,
              vim.fs.find(julia_project_files, { type = "file", upward = true, limit = math.huge })
            )
            for _, depot_path in ipairs(depot_paths) do
              local depot_env = vim.fs.joinpath(vim.fs.normalize(depot_path), "environments")
              vim.list_extend(
                environments,
                vim.fs.find(
                  function(name, env_path)
                    return vim.tbl_contains(julia_project_files, name)
                      and string.sub(env_path, #depot_env + 1):match "^/[^/]*$"
                  end,
                  { path = depot_env, type = "file", limit = math.huge }
                )
              )
            end
            environments = vim.tbl_map(vim.fs.dirname, environments)
            vim.ui.select(environments, { prompt = "Select a Julia environment" }, _activate_env)
          end
        end,
        desc = "Activate a julia environment",
        nargs = "?",
        complete = "file",
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
            local bin = vim.fs.joinpath(depot, "environments", "nvim-lspconifg", "bin", "julia")
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
