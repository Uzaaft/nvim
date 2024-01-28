---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
    dependencies = { "williamboman/mason.nvim" },
    init = function(plugin) require("astrocore").on_load("mason.nvim", plugin.name) end,
    opts = {
      auto_update = true,
      debounce_hours = 24, -- at least 24 hours between attempts to install/update
      ensure_installed = {
        -- Language Servers
        "clangd",
        "cssls",
        "gopls",
        "hls",
        "html",
        "marksman",
        "neocmake",
        "jsonls",
        "julials",
        "lua_ls",
        "taplo",
        "texlab",
        "yamlls",
        "vtsls",
        "docker_compose_language_service",
        "dockerls",
        "tailwindcss",
        { "pylance", version = "2023.12.101" }, -- last known working version

        -- Linters
        "shellcheck",
        "luacheck",

        -- Formatters
        "prettierd",
        "shfmt",
        "stylua",

        -- Debuggers
        "bash-debug-adapter",
        "cpptools",
        "debugpy",
        "js-debug-adapter",
        "codelldb",
      },
    },
    config = function(_, opts)
      local mason_tool_installer = require "mason-tool-installer"
      mason_tool_installer.setup(opts)
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, "codelldb")
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      PATH = "append",
      registries = {
        "lua:custom-registry",
        "github:mason-org/mason-registry",
      },
    },
  },
  { "jay-babu/mason-nvim-dap.nvim", optional = true, init = false },
  { "williamboman/mason-lspconfig.nvim", optional = true, init = false },
  { "jay-babu/mason-null-ls.nvim", optional = true, init = false },
}
