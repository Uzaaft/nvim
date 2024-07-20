---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.zig = {
        install_info = {
          url = "https://github.com/maxxnino/tree-sitter-zig", -- local path or git repo
          files = { "src/parser.c", "src/scanner.cc" },
          branch = "main",
          use_makefile = true, -- this may be necessary on MacOS (try if you see compiler errors)
        },
        maintainers = { "@maxxnino" },
      }
      require("astrocore").list_insert_unique(opts.ensure_installed, { "zig" })
    end,
  },
  {
    "https://codeberg.org/NTBBloodbath/zig-tools.nvim",
    -- Load zig-tools.nvim only in Zig buffers
    ft = { "zig", "zon" },
    opts = {},
    dependencies = {
      "akinsho/toggleterm.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
}
