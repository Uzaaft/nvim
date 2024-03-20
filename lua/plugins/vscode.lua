if not vim.g.vscode then return {} end

local enabled = {}
vim.tbl_map(function(plugin) enabled[plugin] = true end, {
  -- core plugins
  "lazy.nvim",
  "AstroNvim",
  "astrocore",
  "astroui",
  "Comment.nvim",
  "nvim-autopairs",
  "nvim-treesitter",
  "nvim-ts-autotag",
  "nvim-treesitter-textobjects",
  "nvim-ts-context-commentstring",
  -- more known working
  "flash.nvim",
  "flit.nvim",
  "leap.nvim",
  "mini.ai",
  "mini.comment",
  "mini.surround",
  "vim-easy-align",
  "vim-repeat",
  "vim-sandwich",
})

local Config = require "lazy.core.config"
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin) return enabled[plugin.name] end

---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>ff"] = "<Cmd>Find<CR>",
          ["<Leader>fw"] = "<Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>",
          ["<Leader>ls"] = "<Cmd>call VSCodeNotify('workbench.action.gotoSymbol')<CR>",
        },
      },
    },
  },
  { "AstroNvim/astroui", opts = { colorscheme = false } },
  { "nvim-treesitter/nvim-treesitter", opts = { highlight = { enable = false } } },
}
