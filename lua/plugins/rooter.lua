return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- enable AstroNvim root detection, check status with `:AstroRootInfo`
    rooter = {
      -- list of detectors in order of prevelance, elements can be:
      --   "lsp" : lsp detection
      --   string[] : a list of directory patterns to look for
      --   fun(bufnr: integer): string|string[] : a function that takes a buffer number and outputs detected roots
      detector = { "lsp", { ".git", "_darcs", ".hg", ".bzr", ".svn", "lua", "Makefile", "package.json" } },
      -- ignore things from root detection
      ignore = {
        servers = { "julials" }, -- list of language server names to ignore
        dirs = {}, -- list of directory patterns
      },
      -- whether or not to disable automatic working directory updating (update with `:AstroRoot`)
      autochdir = true,
      -- scope of working directory to change ("global"|"tab"|"win")
      scope = "global",
      -- whtether or not to notify on every working directory change
      notify = false,
    },
  },
}
