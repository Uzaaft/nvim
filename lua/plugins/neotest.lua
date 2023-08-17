local prefix = "<Leader>T"
return {
  "nvim-neotest/neotest",
  dependencies = {
    "mrcjkb/neotest-haskell",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-python",
    "stevanmilic/neotest-scala",
  },
  ft = {
    "go",
    "haskell",
    "python",
    "scala",
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
  config = function(plugin, opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = plugin.ft,
      desc = "Set up Neotest bindings for valid buffers",
      callback = function(args)
        require("astrocore").set_mappings({
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
            ["]T"] = { function() require("neotest").jump.next() end, desc = "Next test" },
            ["[T"] = { function() require("neotest").jump.prev() end, desc = "previous test" },
          },
        }, { buffer = args.buf })
      end,
    })
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          return diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
        end,
      },
    }, vim.api.nvim_create_namespace "neotest")
    require("neotest").setup(opts)
  end,
}
