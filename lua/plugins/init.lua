return {
  -- disable core plugins
  { "echasnovski/mini.indentscope", enabled = false },
  { "max397574/better-escape.nvim", enabled = false },
  -- Very small specs not worth their own files
  { "akinsho/toggleterm.nvim", opts = { terminal_mappings = false } },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 1000,
      background_colour = "#000000",
      render = "wrapped-compact",
      stages = "slide",
      fps = 144,
      max_width = 70,
    },
  },
  { "wakatime/vim-wakatime", event = "User AstroFile" },
  {
    "saimo/peek.nvim",
    -- Disable this plugin until I figure out how to make it work with my setup.
    enabled = true,
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
    enabled = false,
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
    ft = { "typescript", "typescriptreact" },
    command = "TSC",
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
  {
    "b0o/SchemaStore.nvim",
    -- Loaded by jsonls when needed.
    version = false,
  },
  {
    "chrisgrieser/nvim-puppeteer",
    event = { "User AstroFile" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "javascript", "typescript", "typescriptreact", "javascriptreact", "python" },
  },
  {
    "nat-418/boole.nvim",
    event = { "User AstroFile" },
    opts = { mappings = {
      increment = "+",
      decrement = "-",
    } },
  },
  { "justinsgithub/wezterm-types" },
}
