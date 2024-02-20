---@type LazySpec[]
return {
  -- disable core plugins
  { "max397574/better-escape.nvim", enabled = false },
  { "nvimtools/none-ls.nvim", enabled = false },
  { "jay-babu/mason-null-ls.nvim", enabled = false },
  { "folke/which-key.nvim", enabled = false },
  { "alpha-nvim", enabled = false }, -- disable starter
  -- Very small specs not worth their own files
  { "akinsho/toggleterm.nvim", opts = { terminal_mappings = false } },
  { "L3MON4D3/LuaSnip", enabled = false },
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
    ft = { "markdown", "md" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
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
  { "justinsgithub/wezterm-types" },
  {
    "NTBBloodbath/zig-tools.nvim",
    -- Load zig-tools.nvim only in Zig buffers
    ft = { "zig" },
    opts = {},
    dependencies = {
      {
        "akinsho/toggleterm.nvim",
      },
      {
        "nvim-lua/plenary.nvim",
      },
    },
  },
  {
    "m4xshen/hardtime.nvim",
    event = "User AstroFile",
    enabled = false,
    opts = {
      disabled_keys = {
        ["<Insert>"] = { "", "i" },
        ["<Home>"] = { "", "i" },
        ["<End>"] = { "", "i" },
        ["<PageUp>"] = { "", "i" },
        ["<PageDown>"] = { "", "i" },
      },
    },
    config = function(_, opts)
      require("hardtime").setup(opts)
      require("hardtime").enable()
    end,
  },
}
