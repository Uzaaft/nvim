return {
  "jupyter-vim/jupyter-vim",
  ft = { "pyhon", "julia" },
  config = function()
    require("astrocore").set_mappings {
      n = {
        ["<Leader>J"] = { "<Cmd>JupyterConnect<CR>", desc = "Connect to Jupyter" },
        ["<Leader>j"] = { "<Plug>JupyterRunTextObj", desc = "Send to Jupyter" },
      },
      v = {
        ["<Leader>j"] = { "<Plug>JupyterRunVisual", desc = "Send to Jupyter" },
      },
    }
  end,
}
