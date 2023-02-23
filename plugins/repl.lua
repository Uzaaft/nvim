return {
  {
    "jupyter-vim/jupyter-vim",
    ft = { "pyhon", "julia" },
    config = function()
      require("astronvim.utils").set_mappings {
        n = {
          ["<leader>J"] = { "<cmd>JupyterConnect<cr>", desc = "Connect to Jupyter" },
          ["<leader>j"] = { "<Plug>JupyterRunTextObj", desc = "Send to Jupyter" },
        },
        v = {
          ["<leader>j"] = { "<Plug>JupyterRunVisual", desc = "Send to Jupyter" },
        },
      }
    end,
  },
  {
    "mtikekar/nvim-send-to-term",
    init = function() vim.g.send_disable_mapping = true end,
    keys = { "<Plug>Send", "<Plug>SendLine" },
    cmd = "SendHere",
  },
}
