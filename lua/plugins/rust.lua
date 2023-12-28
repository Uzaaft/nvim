return {
  {
    "vxpm/ferris.nvim",
    lazy = true,
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lazy_ferris", { clear = true }),
        desc = "Lazy load Ferris",
        once = true,
        callback = function(args)
          if vim.lsp.get_client_by_id(args.data.client_id).name == "rust_analyzer" then
            if require("ferris.private.config").opts.create_commands then
              require("ferris").create_commands(args.buf)
            end
          end
        end,
      })
    end,
    opts = {
      url_handler = function(str) require("astrocore").system_open(str) end,
    },
  },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    init = function()
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
        pattern = "Cargo.toml",
        callback = function()
          require("cmp").setup.buffer { sources = { { name = "crates" } } }
          require "crates"
        end,
      })
    end,
    opts = {},
  },
}
