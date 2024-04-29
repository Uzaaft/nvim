local prefix = "<Leader>T"
---@type LazySpec
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "mrcjkb/neotest-haskell",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-python",
      "stevanmilic/neotest-scala",
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              [prefix] = { desc = "󰗇 Tests" },
              [prefix .. "t"] = { function() require("neotest").run.run() end, desc = "Run test" },
              [prefix .. "d"] = { function() require("neotest").run.run { strategy = "dap" } end, desc = "Debug test" },
              [prefix .. "f"] = {
                function() require("neotest").run.run(vim.fn.expand "%") end,
                desc = "Run all tests in file",
              },
              [prefix .. "p"] = {
                function() require("neotest").run.run(vim.fn.getcwd()) end,
                desc = "Run all tests in project",
              },
              [prefix .. "<CR>"] = { function() require("neotest").summary.toggle() end, desc = "Test Summary" },
              [prefix .. "o"] = { function() require("neotest").output.open() end, desc = "Output hover" },
              [prefix .. "O"] = { function() require("neotest").output_panel.toggle() end, desc = "Output window" },
            },
          },
        },
      },
    },
    opts = function()
      return {
        adapters = {
          require "neotest-go",
          require "neotest-haskell",
          require "neotest-python",
          require "neotest-scala",
        },
      }
    end,
    config = function(_, opts)
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            return diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          end,
        },
      }, vim.api.nvim_create_namespace "neotest")
      require("neotest").setup(opts)
    end,
  },
  {
    "catppuccin",
    optional = true,
    ---@type CatppuccinOptions
    opts = { integrations = { neotest = true } },
  },
}
