return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
    dependencies = { "williamboman/mason.nvim" },
    init = function(plugin) require("astrocore").on_load("mason.nvim", plugin.name) end,
    opts = {
      ensure_installed = {
        -- Language Servers
        "ansiblels",
        "astro",
        "clangd",
        "cssls",
        "gopls",
        "hls",
        "html",
        "intelephense",
        "jsonls",
        "julials",
        "lua_ls",
        "marksman",
        "neocmake",
        { "pylance", version = "2023.12.101" }, -- last known working version
        "tailwindcss",
        "taplo",
        "texlab",
        "vtsls",
        "yamlls",

        -- Linters
        "ansible-lint",
        "ruff",
        "shellcheck",

        -- Formatters
        "prettier",
        "shfmt",
        "stylua",

        -- Debuggers
        "bash-debug-adapter",
        "cpptools",
        "debugpy",
        "delve",
        "haskell-debug-adapter",
        "js-debug-adapter",
        "php-debug-adapter",
      },
    },
    config = function(_, opts)
      local mason_tool_installer = require "mason-tool-installer"
      mason_tool_installer.setup(opts)
      mason_tool_installer.run_on_start()
    end,
  },
  { "jay-babu/mason-nvim-dap.nvim", optional = true, init = false },
  { "williamboman/mason-lspconfig.nvim", optional = true, init = false },
  { "jay-babu/mason-null-ls.nvim", optional = true, init = false },
}
