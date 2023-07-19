local utils = require "user.utils"
local astro_utils = require "astronvim.utils"
local mappings = {
  n = {
    -- disable default bindings
    ["<C-Down>"] = false,
    ["<C-Left>"] = false,
    ["<C-Right>"] = false,
    ["<C-Up>"] = false,
    ["<C-q>"] = false,
    ["<C-s>"] = false,
    ["q:"] = ":",
    -- better buffer navigation
    ["]b"] = false,
    ["[b"] = false,
    ["<S-l>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<S-h>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    -- better search
    n = { utils.better_search "n", desc = "Next search" },
    N = { utils.better_search "N", desc = "Previous search" },
    -- better increment/decrement
    ["-"] = { "<c-x>", desc = "Descrement number" },
    ["+"] = { "<c-a>", desc = "Increment number" },
    -- resize with arrows
    ["<Up>"] = { function() require("smart-splits").resize_up(2) end, desc = "Resize split up" },
    ["<Down>"] = { function() require("smart-splits").resize_down(2) end, desc = "Resize split down" },
    ["<Left>"] = { function() require("smart-splits").resize_left(2) end, desc = "Resize split left" },
    ["<Right>"] = { function() require("smart-splits").resize_right(2) end, desc = "Resize split right" },
    -- Easy-Align
    ga = { "<Plug>(EasyAlign)", desc = "Easy Align" },
    -- buffer switching
    ["<Tab>"] = {
      function()
        if #vim.t.bufs > 1 then
          require("telescope.builtin").buffers { sort_mru = true, ignore_current_buffer = true }
        else
          astro_utils.notify "No other buffers open"
        end
      end,
      desc = "Switch Buffers",
    },
    ["<leader>n"] = { "<cmd>enew<cr>", desc = "New File" },
    ["<leader>N"] = { "<cmd>tabnew<cr>", desc = "New Tab" },
    ["<leader><cr>"] = { '<esc>/<++><cr>"_c4l', desc = "Next Template" },
    ["<leader>."] = { "<cmd>cd %:p:h<cr>", desc = "Set CWD" },
    -- neogen
    ["<leader>a"] = { desc = "󰏫 Annotate" },
    ["<leader>a<cr>"] = { function() require("neogen").generate() end, desc = "Current" },
    ["<leader>ac"] = { function() require("neogen").generate { type = "class" } end, desc = "Class" },
    ["<leader>af"] = { function() require("neogen").generate { type = "func" } end, desc = "Function" },
    ["<leader>at"] = { function() require("neogen").generate { type = "type" } end, desc = "Type" },
    ["<leader>aF"] = { function() require("neogen").generate { type = "file" } end, desc = "File" },
    -- telescope plugin mappings
    ["<leader>fx"] = {
      function() require("telescope").extensions.live_grep_args.live_grep_args() end,
      desc = "Find words (args)",
    },
    ["<leader>fB"] = { "<cmd>Telescope bibtex<cr>", desc = "Find BibTeX" },
    ["<leader>fe"] = { "<cmd>Telescope file_browser<cr>", desc = "File explorer" },
    ["<leader>fp"] = { function() require("telescope").extensions.projects.projects {} end, desc = "Find projects" },
    ["<leader>fT"] = { "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
    -- neogit
    ["<leader>gG"] = { function() require("neogit").open() end, desc = "Neogit" },
    -- compiler
    ["<leader>m"] = { desc = "󱁤 Compiler" },
    ["<leader>mk"] = {
      function()
        vim.cmd "silent! write"
        local filename = vim.fn.expand "%:t"
        utils.async_run({ "compiler", vim.fn.expand "%:p" }, function() astro_utils.notify("Compiled " .. filename) end)
      end,
      desc = "Compile",
    },
    ["<leader>ma"] = {
      function()
        vim.notify "Autocompile Started"
        utils.async_run({ "autocomp", vim.fn.expand "%:p" }, function() astro_utils.notify "Autocompile stopped" end)
      end,
      desc = "Auto Compile",
    },
    ["<leader>mv"] = {
      function() vim.fn.jobstart { "opout", vim.fn.expand "%:p" } end,
      desc = "View Output",
    },
    ["<leader>mb"] = {
      function()
        local filename = vim.fn.expand "%:t"
        utils.async_run({
          "pandoc",
          vim.fn.expand "%",
          "--pdf-engine=xelatex",
          "--variable",
          "urlcolor=blue",
          "-t",
          "beamer",
          "-o",
          vim.fn.expand "%:r" .. ".pdf",
        }, function() astro_utils.notify("Compiled " .. filename) end)
      end,
      desc = "Compile Beamer",
    },
    ["<leader>mp"] = {
      function()
        local pdf_path = vim.fn.expand "%:r" .. ".pdf"
        if vim.fn.filereadable(pdf_path) == 1 then vim.fn.jobstart { "pdfpc", pdf_path } end
      end,
      desc = "Present Output",
    },
    ["<leader>ml"] = { function() utils.toggle_qf() end, desc = "Logs" },
    ["<leader>mt"] = { "<cmd>TexlabBuild<cr>", desc = "LaTeX" },
    ["<leader>mf"] = { "<cmd>TexlabForward<cr>", desc = "Forward Search" },
    ["<leader>r"] = { desc = " REPL" },
    ["<leader>rr"] = { "<Plug>Send", desc = "Send to REPL" },
    ["<leader>rl"] = { "<Plug>SendLine", desc = "Send line to REPL" },
    ["<leader>r<cr>"] = { "<cmd>SendHere<cr>", desc = "Set REPL" },
    ["<leader>z"] = { "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    ["<leader>s"] = { desc = "󰛔 Search/Replace" },
    ["<leader>ss"] = { function() require("spectre").toggle() end, desc = "Toggle Spectre" },
    ["<leader>sf"] = { function() require("spectre").open_file_search() end, desc = "Spectre (current file)" },
    ["<leader>sw"] = {
      function() require("spectre").open_visual { select_word = true } end,
      desc = "Spectre (current word)",
    },
    ["<leader>x"] = { desc = "󰒡 Trouble" },
    ["<leader>xx"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
    ["<leader>xX"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    ["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
    ["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    ["<leader>xT"] = { "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" },
  },
  v = {
    ["<leader>r"] = { "<Plug>Send", desc = "Send to REPL" },
    ["<leader>s"] = { function() require("spectre").open_visual() end, desc = "Spectre" },
  },
  i = {
    -- signature help, fails silently so attach always
    ["<C-l>"] = { function() vim.lsp.buf.signature_help() end, desc = "Signature help" },
    ["<S-Tab>"] = { "<C-V><Tab>", desc = "Tab character" },
  },
  -- terminal mappings
  t = {
    ["<C-BS>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" },
    ["<esc><esc>"] = { "<C-\\><C-n>:q<cr>", desc = "Terminal quit" },
  },
  x = {
    -- better increment/decrement
    ["+"] = { "g<C-a>", desc = "Increment number" },
    ["-"] = { "g<C-x>", desc = "Descrement number" },
    -- Easy-Align
    ga = { "<Plug>(EasyAlign)", desc = "Easy Align" },
  },
  o = {
    -- line text-objects
    ["il"] = { ":normal vil<cr>", desc = "Inside line text object" },
    ["al"] = { ":normal val<cr>", desc = "Around line text object" },
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
}

return mappings
