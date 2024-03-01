local function yaml_ft(path, bufnr)
  local buf_text = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
  if
    -- check if file is in roles, tasks, or handlers folder
    vim.regex("(tasks\\|roles\\|handlers)/"):match_str(path)
    -- check for known ansible playbook text and if found, return yaml.ansible
    or vim.regex("hosts:\\|tasks:"):match_str(buf_text)
  then
    return "yaml.ansible"
  elseif vim.regex("AWSTemplateFormatVersion:"):match_str(buf_text) then
    return "yaml.cfn"
  else -- return yaml if nothing else
    return "yaml"
  end
end

---@type AstroCoreOpts
local opts = {
  rooter = {
    ignore = { servers = { "julials" } },
    autochdir = true,
  },
  options = {
    opt = {
      conceallevel = 1, -- enable conceal
      list = true, -- show whitespace characters
      listchars = { tab = "│→", extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" },
      showbreak = "↪ ",
      showtabline = (vim.t.bufs and #vim.t.bufs > 1) and 2 or 1,
      spellfile = vim.fn.expand "~/.config/nvim/spell/en.utf-8.add",
      splitkeep = "screen",
      swapfile = false,
      thesaurus = vim.fn.expand "~/.config/nvim/spell/mthesaur.txt",
      wrap = true, -- soft wrap lines
    },
  },
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
  filetypes = {
    extension = {
      mdx = "markdown.mdx",
      qmd = "markdown",
      yml = yaml_ft,
      yaml = yaml_ft,
    },
    pattern = {
      ["/tmp/neomutt.*"] = "markdown",
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
      ["L"] = {
        function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
        desc = "Next buffer",
      },
      ["H"] = {
        function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
        desc = "Previous buffer",
      },
      -- better search
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
      -- line text-objects
      ["iL"] = { ":<C-u>normal! $v^<CR>", desc = "Inside line text object" },
      ["aL"] = { ":<C-u>normal! $v0<CR>", desc = "Around line text object" },
    },
    o = {
      -- line text-objects
      ["iL"] = { ":<C-u>normal! $v^<CR>", desc = "Inside line text object" },
      ["aL"] = { ":<C-u>normal! $v0<CR>", desc = "Around line text object" },
    },
    ia = vim.fn.has "nvim-0.10" == 1 and {
      mktmpl = { function() return "<++>" end, desc = "Insert <++>", expr = true },
      ldate = { function() return os.date "%Y/%m/%d %H:%M:%S -" end, desc = "Y/m/d H:M:S -", expr = true },
      ndate = { function() return os.date "%Y-%m-%d" end, desc = "Y-m-d", expr = true },
      xdate = { function() return os.date "%m/%d/%y" end, desc = "m/d/y", expr = true },
      fdate = { function() return os.date "%B %d, %Y" end, desc = "B d, Y", expr = true },
      Xdate = { function() return os.date "%H:%M" end, desc = "H:M", expr = true },
      Fdate = { function() return os.date "%H:%M:%S" end, desc = "H:M:S", expr = true },
    } or nil,
  },
}

local function better_search(key)
  return function()
    local searched, error =
      pcall(vim.cmd.normal, { args = { (vim.v.count > 0 and vim.v.count or "") .. key }, bang = true })
    if not searched and type(error) == "string" then require("astrocore").notify(error, vim.log.levels.ERROR) end
  end
end
opts.mappings.n.n = { better_search "n", desc = "Next search" }
opts.mappings.n.N = { better_search "N", desc = "Previous search" }

-- add line text object
for lhs, rhs in pairs {
  il = { ":<C-u>normal! $v^<CR>", desc = "inside line" },
  al = { ":<C-u>normal! V<CR>", desc = "around line" },
} do
  opts.mappings.o[lhs] = rhs
  opts.mappings.x[lhs] = rhs
end

-- add missing in between and arround two character pairs
for _, char in ipairs { "_", "-", ".", ":", ",", ";", "|", "/", "\\", "*", "+", "%", "`", "?" } do
  for lhs, rhs in pairs {
    ["i" .. char] = { (":<C-u>silent! normal! f%sF%slvt%s<CR>"):format(char, char, char), desc = "inside " .. char },
    ["a" .. char] = { (":<C-u>silent! normal! f%sF%svf%s<CR>"):format(char, char, char), desc = "around " .. char },
  } do
    opts.mappings.o[lhs] = rhs
    opts.mappings.x[lhs] = rhs
  end
end

---@type LazySpec
return { "AstroNvim/astrocore", opts = opts }
