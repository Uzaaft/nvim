local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.g.astronvim_first_install = true
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- Quick Toggles
local USE_STABLE = false -- use stable releases of AstroNvim

local spec =
  { { "AstroNvim/AstroNvim", branch = "v4", version = USE_STABLE and "*" or nil, import = "astronvim.plugins" } }
if USE_STABLE then table.insert(spec, { import = "astronvim.lazy_snapshot" }) end

-- Customize plugins
spec = vim.list_extend(spec, {
  -- { "AstroNvim/astrocommunity" },
  -- { import = "astrocommunity.pack.lua" },
  { import = "plugins" },
})

require("lazy").setup(spec, {
  defaults = { lazy = true },
  diff = { cmd = "terminal_git" },
  install = { colorscheme = { "catppuccin", "astrodark", "habamax" } },
  checker = { enabled = true },
  lockfile = vim.fn.stdpath "data" .. "/lazy-lock.json",
  performance = {
    rtp = {
      -- disable some rtp plugins, add more to your liking
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded",
  },
})
