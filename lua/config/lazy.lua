local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.g.astronvim_first_install = true
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- Quick Toggles
local USE_STABLE = false -- use stable releases of AstroNvim
local LOCAL_ASTRO = false -- use local development of AstroNvim

-- Customize dev patterns
local dev_patterns = {}

if LOCAL_ASTRO then table.insert(dev_patterns, "AstroNvim") end
if vim.env.LAZY then table.insert(dev_patterns, "lazy.nvim") end

require("lazy").setup({
  { "AstroNvim/AstroNvim", branch = "v4", version = USE_STABLE and "^4" or nil, import = "astronvim.plugins" },
  { import = "astronvim.lazy_snapshot", cond = USE_STABLE },
  -- { "AstroNvim/astrocommunity" },
  -- { import = "astrocommunity.pack.lua" },
  { import = "plugins" },
}, {
  dev = { patterns = dev_patterns },
  defaults = { lazy = true },
  diff = { cmd = "terminal_git" },
  install = { colorscheme = { "catppuccin", "astrodark", "habamax" } },
  checker = { enabled = true },
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
})
