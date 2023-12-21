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
