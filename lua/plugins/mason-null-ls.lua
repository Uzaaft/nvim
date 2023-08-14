return {
  "jay-babu/mason-null-ls.nvim",
  opts = {
    ensure_installed = {
      "ansiblelint",
      "shellcheck",
      "stylua",
      "black",
      "isort",
      "prettierd",
      "shfmt",
      "shellcheck",
    },
    handlers = {
      taplo = function() end, -- disable taplo in null-ls, it's taken care of by lspconfig
    },
  },
}
