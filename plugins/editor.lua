return {
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 1,
        width = function() return math.min(120, vim.o.columns * 0.75) end,
        height = 0.9,
        options = {
          number = false,
          relativenumber = false,
          foldcolumn = "0",
          list = false,
          showbreak = "NONE",
          signcolumn = "no",
        },
      },
      plugins = {
        options = {
          cmdheight = 1,
          laststatus = 0,
        },
      },
      on_open = function() -- disable diagnostics, indent blankline, and winbar
        vim.g.diagnostics_mode_old = vim.g.diagnostics_mode
        vim.g.indent_blankline_enabled_old = vim.g.indent_blankline_enabled
        vim.g.winbar_old = vim.wo.winbar
        vim.g.diagnostics_mode = 0
        vim.g.indent_blankline_enabled = false
        vim.wo.winbar = nil
        vim.diagnostic.config(require("astronvim.utils.lsp").diagnostics[vim.g.diagnostics_mode])
      end,
      on_close = function() -- restore diagnostics, indent blankline, and winbar
        vim.g.diagnostics_mode = vim.g.diagnostics_mode_old
        vim.g.indent_blankline_enabled = vim.g.indent_blankline_enabled_old
        vim.wo.winbar = vim.g.winbar_old
        vim.diagnostic.config(require("astronvim.utils.lsp").diagnostics[vim.g.diagnostics_mode])
      end,
    },
  },
  {
    "echasnovski/mini.move",
    keys = {
      { "<M-l>", mode = { "n", "v" } },
      { "<M-k>", mode = { "n", "v" } },
      { "<M-j>", mode = { "n", "v" } },
      { "<M-h>", mode = { "n", "v" } },
    },
    opts = {},
  },
  {
    "arsham/indent-tools.nvim",
    dependencies = { "arsham/arshlib.nvim" },
    event = "User AstroFile",
    config = function() require("indent-tools").config {} end,
  },
  {
    "danymat/neogen",
    cmd = "Neogen",
    opts = {
      snippet_engine = "luasnip",
      languages = {
        lua = { template = { annotation_convention = "emmylua" } },
        typescript = { template = { annotation_convention = "tsdoc" } },
        typescriptreact = { template = { annotation_convention = "tsdoc" } },
      },
    },
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = "markdown",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    event = "User AstroFile",
    cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
    opts = {},
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      use_diagnostic_signs = true,
      action_keys = {
        close = { "q", "<esc>" },
        cancel = "<c-e>",
      },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = function()
      local prefix = "<leader>s"
      return {
        open_cmd = "new",
        mapping = {
          send_to_qf = { map = prefix .. "q" },
          replace_cmd = { map = prefix .. "c" },
          show_option_menu = { map = prefix .. "o" },
          run_current_replace = { map = prefix .. "C" },
          run_replace = { map = prefix .. "R" },
          change_view_mode = { map = prefix .. "v" },
          resume_last_search = { map = prefix .. "l" },
        },
      }
    end,
  },
  { "junegunn/vim-easy-align", event = "User AstroFile" },
  {
    "echasnovski/mini.surround",
    keys = {
      { "sa", desc = "Add surrounding", mode = { "n", "v" } },
      { "sd", desc = "Delete surrounding" },
      { "sf", desc = "Find right surrounding" },
      { "sF", desc = "Find left surrounding" },
      { "sh", desc = "Highlight surrounding" },
      { "sr", desc = "Replace surrounding" },
      { "sn", desc = "Update `MiniSurround.config.n_lines`" },
    },
    opts = { n_lines = 200 },
  },
  { "wakatime/vim-wakatime", event = "User AstroFile" },
}
