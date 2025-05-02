---@type LazySpec
return {
  "Kaiser-Yang/blink-cmp-git",
  lazy = true,
  dependencies = "nvim-lua/plenary.nvim",
  specs = {
    {
      "Saghen/blink.cmp",
      opts = function(_, opts)
        local per_filetype = {}
        for _, filetype in ipairs { "gitcommit", "octo", "NeogitCommitMessage" } do
          local git_sources = vim.tbl_get(opts, "sources", "per_filetype", filetype) or {}
          table.insert(git_sources, "git")
          git_sources.inherit_defaults = true
          per_filetype[filetype] = git_sources
        end
        return require("astrocore").extend_tbl(opts, {
          sources = {
            per_filetype = per_filetype,
            providers = {
              git = {
                name = "Git",
                module = "blink-cmp-git",
                async = true,
                score_offset = 100,
              },
            },
          },
        })
      end,
    },
  },
}
