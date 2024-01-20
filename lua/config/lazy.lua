local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or vim.loop.fs_stat(lazypath)) then
  vim.g.astronvim_first_install = true
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

local lazy_loaded, lazy = pcall(require, "lazy") -- validate that lazy is available
if not lazy_loaded then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

---@type LazyConfig
lazy.setup({
  {
    "AstroNvim/AstroNvim",
    ---@type AstroNvimOpts
    opts = {
      -- pin_plugins = true
    },
    branch = "v4",
    -- version = "^4",
    import = "astronvim.plugins",
  },
  -- { "AstroNvim/astrocommunity" },
  -- { import = "astrocommunity.pack.lua" },
  { import = "plugins" },
} --[[@as LazySpec]], {
  dev = {
    -- TODO: remove check when PR merged: https://github.com/folke/lazy.nvim/pull/1157
    ---@param plugin LazyPlugin
    path = vim.env.LAZY and function(plugin)
      local dir = plugin.url:match "^https://(.*)%.git$"
      return dir and vim.env.GIT_PATH and vim.env.GIT_PATH .. "/" .. dir or "~/projects/" .. plugin.name
    end,
    patterns = {
      -- "AstroNvim", -- local AstroNvim
    },
  },
  defaults = { lazy = true },
  diff = { cmd = "terminal_git" },
  install = { colorscheme = { "catppuccin", "astrodark", "habamax" } },
  lockfile = vim.fn.stdpath "data" .. "/lazy-lock.json",
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
} --[[@as LazyConfig]])
