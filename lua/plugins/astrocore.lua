local function better_search(key)
  return function()
    local searched, error =
      pcall(vim.cmd.normal, { args = { (vim.v.count > 0 and vim.v.count or "") .. key }, bang = true })
    if not searched and type(error) == "string" then require("astrocore").notify(error, vim.log.levels.ERROR) end
  end
end

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    autocmds = {
      auto_spell = {
        {
          event = "FileType",
          desc = "Enable wrap and spell for text like documents",
          pattern = { "gitcommit", "markdown", "text", "plaintex" },
          callback = function()
            vim.opt_local.wrap = true
            vim.opt_local.spell = true
          end,
        },
      },
      autohide_tabline = {
        {
          event = "User",
          desc = "Auto hide tabline",
          pattern = "AstroBufsUpdated",
          callback = function()
            local new_showtabline = #vim.t.bufs > 1 and 2 or 1
            if new_showtabline ~= vim.opt.showtabline:get() then vim.opt.showtabline = new_showtabline end
          end,
        },
      },
    },
    mappings = {
      n = {
        -- disable default bindings
        ["<C-q>"] = false,
        ["<C-s>"] = false,
        ["q:"] = ":",
        -- better buffer navigation
        ["]b"] = false,
        ["[b"] = false,
        ["<S-l>"] = {
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        ["<S-h>"] = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },
        -- better search
        n = { better_search "n", desc = "Next search" },
        N = { better_search "N", desc = "Previous search" },
        -- better increment/decrement
        ["-"] = { "<C-x>", desc = "Descrement number" },
        ["+"] = { "<C-a>", desc = "Increment number" },
        ["<Leader>n"] = { "<Cmd>enew<CR>", desc = "New File" },
        ["<Leader>N"] = { "<Cmd>tabnew<CR>", desc = "New Tab" },
        ["<Leader><CR>"] = { '<Esc>/<++><CR>"_c4l', desc = "Next Template" },
        ["<Leader>."] = { "<Cmd>cd %:p:h<CR>", desc = "Set CWD" },
      },
      i = {
        ["<S-Tab>"] = { "<C-V><Tab>", desc = "Tab character" },
      },
      -- terminal mappings
      t = {
        ["<C-BS>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
        ["<Esc><Esc>"] = { "<C-\\><C-n>:q<CR>", desc = "Terminal quit" },
      },
      x = {
        -- better increment/decrement
        ["+"] = { "g<C-a>", desc = "Increment number" },
        ["-"] = { "g<C-x>", desc = "Descrement number" },
      },
      o = {
        -- line text-objects
        ["il"] = { ":normal vil<CR>", desc = "Inside line text object" },
        ["al"] = { ":normal val<CR>", desc = "Around line text object" },
      },
      ia = vim.fn.has "nvim-0.10" == 1 and {
        mktemp = { function() return "<++>" end, desc = "Insert <++>", expr = true },
        ldate = { function() return os.date "%Y/%m/%d %H:%M:%S -" end, desc = "Y/m/d H:M:S -", expr = true },
        ndate = { function() return os.date "%Y-%m-%d" end, desc = "Y-m-d", expr = true },
        xdate = { function() return os.date "%m/%d/%y" end, desc = "m/d/y", expr = true },
        fdate = { function() return os.date "%B %d, %Y" end, desc = "B d, Y", expr = true },
        Xdate = { function() return os.date "%H:%M" end, desc = "H:M", expr = true },
        Fdate = { function() return os.date "%H:%M:%S" end, desc = "H:M:S", expr = true },
      } or nil,
    },
  },
}
