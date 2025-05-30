return {
  on_attach = function(_, bufnr)
    require("astrocore").set_mappings({
      n = {
        ["<Leader>lB"] = { "<Cmd>TexlabBuild<CR>", desc = "LaTeX Build" },
        ["<Leader>lF"] = { "<Cmd>TexlabForward<CR>", desc = "LaTeX Forward Search" },
      },
    }, { buffer = bufnr })
  end,
  settings = {
    texlab = {
      build = { onSave = true },
      forwardSearch = { executable = "zathura", args = { "--synctex-forward", "%l:1:%f", "%p" } },
    },
  },
}
