return {
  "mfussenegger/nvim-lint",
  event = "User AstroFile",
  dependencies = { "williamboman/mason.nvim" },
  opts = {
    linters_by_ft = {
      sh = { "shellcheck" },
      ["yaml.ansible"] = { "ansible_lint" },
    },
  },
  config = function(_, opts)
    local lint = require "lint"
    lint.linters_by_ft = opts.linters_by_ft

    lint.try_lint() -- start linter immediately
    local timer = vim.loop.new_timer()
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
      group = vim.api.nvim_create_augroup("auto_lint", { clear = true }),
      desc = "Automatically try linting",
      callback = function()
        timer:start(100, 0, function()
          timer:stop()
          vim.schedule(lint.try_lint)
        end)
      end,
    })
  end,
}
