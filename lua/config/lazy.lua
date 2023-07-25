local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local USE_STABLE = false -- use stable releases of AstroNvim

local spec = {
  { "AstroNvim/AstroNvim", branch = "v4", version = USE_STABLE and "*" or nil, import = "astronvim.plugins" },
}
if USE_STABLE then table.insert(spec, { import = "astronvim.lazy_snapshot" }) end

require("lazy").setup {
  spec = vim.list_extend(spec, {
    -- import any community modules here
    -- { "AstroNvim/astrocommunity" },
    -- { import = "astrocommunity.pack.lua" },
    -- import/override with your plugins
    { import = "plugins" },
  }),
  defaults = {
    -- By default, only AstroNvim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = true,
  },
  diff = { cmd = "terminal_git" },
  install = { colorscheme = { "catppuccin", "astrodark", "habamax" } },
  checker = { enabled = true },
  lockfile = vim.fn.stdpath "data" .. "/lazy-lock.json",
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
}
