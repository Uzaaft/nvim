return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
    dependencies = { "williamboman/mason.nvim" },
    init = function()
      require("astrocore").on_load("mason.nvim", function() require "mason-tool-installer" end)
    end,
    opts = {
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

        -- Linters
        "shellcheck",

        -- Formatters
        "prettierd",
        "shfmt",
        "stylua",

        -- Debuggers
        "bash-debug-adapter",
        "cpptools",
        "debugpy",
        "js-debug-adapter",
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
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        -- "python",
        "codelldb",
      })
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
