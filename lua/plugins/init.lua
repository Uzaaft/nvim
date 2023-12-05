return {
  -- disable core plugins
  { "echasnovski/mini.indentscope", enabled = false },
  { "max397574/better-escape.nvim", enabled = false },
  { "nvimtools/none-ls.nvim", enabled = false },
  { "jay-babu/mason-null-ls.nvim", enabled = false },
  { "folke/which-key.nvim", enabled = false },
  { "folke/which-key.nvim", enabled = false },
  -- Very small specs not worth their own files
  { "akinsho/toggleterm.nvim", opts = { terminal_mappings = false } },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 500,
      background_colour = "#000000",
      render = "wrapped-compact",
      stages = "slide",
      fps = 144,
      max_width = 70,
    },
  },
  { "wakatime/vim-wakatime", event = "User AstroFile" },
  {
    "toppair/peek.nvim",
    enabled = true,
    ft = "markdown",
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
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
    ft = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
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
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, "html")
      end
    end,
  },
}
