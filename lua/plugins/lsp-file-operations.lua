---@type LazySpec
return {
  "antosha417/nvim-lsp-file-operations",
  main = "lsp-file-operations",
  init = function(plugin) require("astrocore").on_load("neo-tree.nvim", plugin.name) end,
  opts = {},
  specs = {
    {
      "AstroNvim/astrolsp",
      opts = function(_, opts)
        local operations = vim.tbl_get(require("astrocore").plugin_opts "nvim-lsp-file-operations", "operations") or {}
        local fileOperations = {}
        for _, operation in ipairs { "willRename", "didRename", "willCreate", "didCreate", "willDelete", "didDelete" } do
          local enabled = vim.tbl_get(operations, operation .. "Files")
          if enabled == nil then enabled = true end
          fileOperations[operation] = enabled
        end
        opts.capabilities =
          vim.tbl_deep_extend("force", opts.capabilities or {}, { workspace = { fileOperations = fileOperations } })
      end,
    },
  },
}
