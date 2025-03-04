return {
  "disrupted/blink-cmp-conventional-commits",
  lazy = true,
  specs = {
    {
      "Saghen/blink.cmp",
      opts = function(_, opts)
        local per_filetype = {}
        for _, filetype in ipairs { "gitcommit", "octo", "NeogitCommitMessage" } do
          local git_sources = vim.tbl_get(opts, "sources", "per_filetype", filetype) or { "buffer" }
          table.insert(git_sources, "conventional_commits")
          per_filetype[filetype] = git_sources
        end
        return require("astrocore").extend_tbl(opts, {
          sources = {
            per_filetype = per_filetype,
            providers = {
              conventional_commits = {
                name = "Conventional Commits",
                module = "blink-cmp-conventional-commits",
                score_offset = 100,
              },
            },
          },
        })
      end,
    },
  },
}
