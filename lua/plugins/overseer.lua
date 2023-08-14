return {
  "stevearc/overseer.nvim",
  cmd = {
    "OverseerOpen",
    "OverseerClose",
    "OverseerToggle",
    "OverseerSaveBundle",
    "OverseerLoadBundle",
    "OverseerDeleteBundle",
    "OverseerRunCmd",
    "OverseerRun",
    "OverseerInfo",
    "OverseerBuild",
    "OverseerQuickAction",
    "OverseerTaskAction ",
    "OverseerClearCache",
  },
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      commands = {
        AutoCompile = {
          function()
            require("overseer").run_template({ name = "compile with compiler" }, function(task)
              if task then
                task:add_component { "restart_on_save", paths = { vim.fn.expand "%:p" } }
              else
                vim.notify("Error setting up auto compilation", vim.log.levels.ERROR)
              end
            end)
          end,
          desc = "Automatically compile the current file with `compiler` on save",
        },
        Compile = {
          function() require("overseer").run_template { name = "compile with compiler" } end,
          desc = "Compile the current file with `compiler`",
        },
        OpOut = {
          function() require("overseer").run_template { name = "view file output" } end,
          desc = "View the current file ouptut with `opout`",
        },
        Present = {
          function()
            require("overseer").run_template({ name = "present with pdfpc" }, function(task)
              if not task then vim.notify("Unable to start presentation", vim.log.levels.ERROR) end
            end)
          end,
          desc = "Present the current file with `pdfpc`",
        },
      },
      mappings = {
        n = {
          ["<Leader>m"] = { desc = "󱁤 Compiler" },
          ["<Leader>mr"] = { "<Cmd>OverseerRun<CR>", desc = "Overseer Run" },
          ["<Leader>mk"] = { "<Cmd>Compile<CR>", desc = "Compile" },
          ["<Leader>ma"] = { "<Cmd>AutoCompile<CR>", desc = "Auto Compile" },
          ["<Leader>mp"] = { "<Cmd>Present<CR>", desc = "Present file output" },
          ["<Leader>mt"] = { "<Cmd>OverseerToggle<CR>", desc = "Overseer Toggle" },
          ["<Leader>mv"] = { "<Cmd>OpOut<CR>", desc = "View Output" },
        },
      },
    },
  },
  opts = {
    setup = {
      task_list = {
        direction = "right",
        bindings = {
          ["<C-l>"] = false,
          ["<C-h>"] = false,
          ["<C-k>"] = false,
          ["<C-j>"] = false,
          q = "<Cmd>close<CR>",
          K = "IncreaseDetail",
          J = "DecreaseDetail",
          ["<C-p>"] = "ScrollOutputUp",
          ["<C-n>"] = "ScrollOutputDown",
        },
      },
    },
    templates = {
      {
        name = "compile with compiler",
        builder = function() return { cmd = { "compiler" }, args = { vim.fn.expand "%:p" } } end,
      },
      {
        name = "view file output",
        builder = function() return { cmd = { "opout" }, args = { vim.fn.expand "%:p" } } end,
      },
      {
        name = "present with pdfpc",
        builder = function() return { cmd = { "pdfpc" }, args = { vim.fn.expand "%:r" .. ".pdf" } } end,
        condition = { callback = function() return vim.fn.filereadable(vim.fn.expand "%:r" .. ".pdf") == 1 end },
      },
    },
  },
  config = function(_, opts)
    require("overseer").setup(opts.setup)
    vim.tbl_map(require("overseer").register_template, opts.templates)
  end,
}
