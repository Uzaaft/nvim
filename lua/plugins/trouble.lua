return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>x"] = { desc = "󰒡 Trouble" },
          ["<Leader>xx"] = { "<Cmd>TroubleToggle document_diagnostics<CR>", desc = "Document Diagnostics (Trouble)" },
          ["<Leader>xX"] = { "<Cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace Diagnostics (Trouble)" },
          ["<Leader>xl"] = { "<Cmd>TroubleToggle loclist<CR>", desc = "Location List (Trouble)" },
          ["<Leader>xq"] = { "<Cmd>TroubleToggle quickfix<CR>", desc = "Quickfix List (Trouble)" },
        },
      },
    },
  },
  opts = {
    use_diagnostic_signs = true,
    action_keys = {
      close = { "q", "<Esc>" },
      cancel = "<C-e>",
    },
  },
}
