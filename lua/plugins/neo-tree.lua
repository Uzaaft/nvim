local old_guicursor, old_cursor

---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        always_show = { ".github", ".gitignore" },
      },
    },
    window = {
      mappings = {
        ["\\"] = "open_split",
        ["|"] = "open_vsplit",
        s = "noop",
      },
    },
    nesting_rules = {
      docker = {
        pattern = "^dockerfile$",
        ignore_case = true,
        files = { ".dockerignore", "docker-compose.*", "dockerfile*" },
      },
      git_files = {
        pattern = "^%.gitignore$",
        files = { ".gitattributes", ".gitmodules", ".gitmessage", ".mailmap", ".git-blame*" },
      },
      readme = {
        pattern = "^readme.*",
        ignore_case = true,
        files = {
          "authors",
          "backers*",
          "changelog*",
          "citation*",
          "code_of_conduct*",
          "codeowners",
          "contributing*",
          "contributors",
          "copying*",
          "credits",
          "governance.md",
          "history.md",
          "license*",
          "maintainers",
          "readme*",
          "security.md",
          "sponsors*",
        },
      },
      tex = {
        pattern = "^(.*)%.tex$",
        files = {
          "_minted-%1",
          "%1.acn",
          "%1.acr",
          "%1.alg",
          "%1.aux",
          "%1.bbl",
          "%1.blg",
          "%1.fdb_latexmk",
          "%1.fls",
          "%1.glg",
          "%1.glo",
          "%1.gls",
          "%1.idx",
          "%1.ind",
          "%1.ist",
          "%1.lof",
          "%1.log",
          "%1.lot",
          "%1.out",
          "%1.pag",
          "%1.pdf",
          "%1.synctex.gz",
          "%1.toc",
          "%1.xdv",
        },
      },
      tool_versions = {
        pattern = "^%.tool-versions$",
        files = { ".rtx.toml" },
      },
    },
  },
}
