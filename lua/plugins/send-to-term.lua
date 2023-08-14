local prefix = "<Leader>r"
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
          [prefix] = { desc = " REPL" },
          [prefix .. "r"] = { "<Plug>Send", desc = "Send to REPL" },
          [prefix .. "l"] = { "<Plug>SendLine", desc = "Send line to REPL" },
          [prefix .. "<CR>"] = { "<Cmd>SendHere<CR>", desc = "Set REPL" },
        },
        v = {
          [prefix] = { "<Plug>Send", desc = "Send to REPL" },
        },
      },
    },
  },
}
