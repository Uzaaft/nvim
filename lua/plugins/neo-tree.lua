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
    event_handlers = {
      { -- hide cursor in normal mode for neo-tree window
        event = "neo_tree_buffer_enter",
        handler = function(_)
          -- save old values
          old_guicursor = vim.go.guicursor
          old_cursor = vim.api.nvim_get_hl(0, { name = "Cursor", create = false })
          -- make cursor invisible
          vim.opt.guicursor:append { "n:Cursor/lCursor" }
          vim.cmd "highlight Cursor blend=100"
        end,
      },
      { -- restore cursor visibility when leaving neo-tree buffer
        event = "neo_tree_buffer_leave",
        handler = function(_)
          if old_guicursor then -- if old value found, use it
            vim.go.guicursor = old_guicursor
          else -- if not, revert original operation directly
            vim.opt.guicursor:remove { "n:Cursor/lCursor" }
          end
          if old_cursor then -- if old value found, use it
            vim.api.nvim_set_hl(0, "Cursor", old_cursor)
          else -- if not, fallback to no blend
            vim.cmd "highlight Cursor blend=0"
          end
        end,
      },
    },
  },
}
