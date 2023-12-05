vim.filetype.add {
  extension = {
    mdx = "markdown.mdx",
    qmd = "markdown",
  },
  filename = {
    [".eslintrc.json"] = "jsonc",
  },
  pattern = {
    ["tsconfig*.json"] = "jsonc",
    [".*/%.vscode/.*%.json"] = "jsonc",
  },
}

local inlay_hints_group = vim.api.nvim_create_augroup("uzaaft/toggle_inlay_hints", { clear = false })

-- Initial inlay hint display.
-- Idk why but without the delay inlay hints aren't displayed at the very start.
vim.defer_fn(function()
  local mode = vim.api.nvim_get_mode().mode
  vim.lsp.inlay_hint.enable(bufnr, mode == "n" or mode == "v")
end, 500)

vim.api.nvim_create_autocmd("InsertEnter", {
  group = inlay_hints_group,
  desc = "Enable inlay hints",
  buffer = bufnr,
  callback = function() vim.lsp.inlay_hint.enable(bufnr, false) end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  group = inlay_hints_group,
  desc = "Disable inlay hints",
  buffer = bufnr,
  callback = function() vim.lsp.inlay_hint.enable(bufnr, true) end,
})
