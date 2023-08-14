return {
  "mtikekar/nvim-send-to-term",
  init = function() vim.g.send_disable_mapping = true end,
  keys = { "<Plug>Send", "<Plug>SendLine" },
  cmd = "SendHere",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>r"] = { desc = " REPL" },
          ["<Leader>rr"] = { "<Plug>Send", desc = "Send to REPL" },
          ["<Leader>rl"] = { "<Plug>SendLine", desc = "Send line to REPL" },
          ["<Leader>r<CR>"] = { "<Cmd>SendHere<CR>", desc = "Set REPL" },
        },
        v = {
          ["<Leader>r"] = { "<Plug>Send", desc = "Send to REPL" },
        },
      },
    },
  },
}
