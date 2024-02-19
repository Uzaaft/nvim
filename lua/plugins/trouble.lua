---@type LazySpec
return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  dependencies = {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps, prefix = opts.mappings, "<Leader>x"
      maps.n[prefix] = { desc = "󰒡 Trouble" }
      maps.n[prefix .. "x"] = { "<Cmd>TroubleToggle document_diagnostics<CR>", desc = "Document Diagnostics (Trouble)" }
      maps.n[prefix .. "X"] =
        { "<Cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace Diagnostics (Trouble)" }
      maps.n[prefix .. "l"] = { "<Cmd>TroubleToggle loclist<CR>", desc = "Location List (Trouble)" }
      maps.n[prefix .. "q"] = { "<Cmd>TroubleToggle quickfix<CR>", desc = "Quickfix List (Trouble)" }

      if require("astrocore").is_available "todo-comments.nvim" then
        maps.n[prefix .. "T"] = { "<Cmd>TodoTrouble<CR>", desc = "TODOs (Trouble)" }
      end
    end,
  },
  opts = {
    use_diagnostic_signs = true,
    action_keys = {
      close = { "q", "<Esc>" },
      cancel = "<C-e>",
    },
  },
}
