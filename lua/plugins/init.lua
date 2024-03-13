---@type LazySpec[]
return {
  -- disable core plugins
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
}
