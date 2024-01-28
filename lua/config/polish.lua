vim.filetype.add {
  extension = {
    mdx = "markdown.mdx",
    qmd = "markdown",
    just = "just",
  },
  filename = {
    [".eslintrc.json"] = "jsonc",
    [".env"] = "sh",
    [".env.local"] = "sh",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["justfile"] = "just",
    ["Justfile"] = "just",
    [".Justfile"] = "just",
    [".justfile"] = "just",
  },
  pattern = {
    ["tsconfig*.json"] = "jsonc",
    [".*/%.vscode/.*%.json"] = "jsonc",
  },
}
