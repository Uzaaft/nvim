local prefix = "<Leader>r"
---@type LazySpec
return {
  "mtikekar/nvim-send-to-term",
  keys = { "<Plug>Send", "<Plug>SendLine" },
  cmd = "SendHere",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      options = { g = { send_disable_mapping = true } },
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
