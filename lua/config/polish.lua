vim.filetype.add {
  extension = {
    mdx = "markdown.mdx",
    qmd = "markdown",
  },
  filename = {
    [".eslintrc.json"] = "jsonc",
    [".env"] = "sh",
    [".env.local"] = "sh",
    ["docker-compose.yaml"] = "yaml.docker-compose",
  },
  pattern = {
    ["tsconfig*.json"] = "jsonc",
    [".*/%.vscode/.*%.json"] = "jsonc",
  },
}
