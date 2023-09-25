return {
  -- disable core plugins
  { "echasnovski/mini.indentscope", enabled = false },
  { "max397574/better-escape.nvim", enabled = false },

  -- Very small specs not worth their own files
  { "akinsho/toggleterm.nvim", opts = { terminal_mappings = false } },
  { "rcarriga/nvim-notify", opts = { timeout = 0 } },
  { "wakatime/vim-wakatime", event = "User AstroFile" },
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      -- refer to `configuration to change defaults`
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
  },
  {
    "barrett-ruth/import-cost.nvim",
    build = "sh install.sh yarn",
    config = true,
  },
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    event = "BufRead package.json",
  },
  {
    "dmmulroy/tsc.nvim",
    opts = {},
  },
  {
    "smjonas/inc-rename.nvim",
    opts = {},
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      mappings = {
        n = {
          ["<leader>lr"] = {
            ":IncRename ",
            desc = "IncRename",
          },
        },
      },
    },
  },
}
