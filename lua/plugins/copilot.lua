return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  opts = {
    panel = {
      auto_refresh = true,
    },
    suggestion = {
      keymap = {
        accept = "<C-l>",
        accept_word = false,
        accept_line = false,
        next = "<C-.>",
        prev = "<C-,>",
        dismiss = "<C/>",
        --dismiss = false,
      },
    },
  },
}
