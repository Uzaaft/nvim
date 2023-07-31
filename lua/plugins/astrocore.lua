return {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
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
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        ["<S-h>"] = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },
        -- better search
        n = { function() require("config.utils").better_search "n" end, desc = "Next search" },
        N = { function() require("config.utils").better_search "N" end, desc = "Previous search" },
        -- better increment/decrement
        ["-"] = { "<C-x>", desc = "Descrement number" },
        ["+"] = { "<C-a>", desc = "Increment number" },
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
              require("astrocore").notify "No other buffers open"
            end
          end,
          desc = "Switch Buffers",
        },
        ["<Leader>n"] = { "<Cmd>enew<CR>", desc = "New File" },
        ["<Leader>N"] = { "<Cmd>tabnew<CR>", desc = "New Tab" },
        ["<Leader><CR>"] = { '<Esc>/<++><CR>"_c4l', desc = "Next Template" },
        ["<Leader>."] = { "<Cmd>cd %:p:h<CR>", desc = "Set CWD" },
        -- neogen
        ["<Leader>a"] = { desc = "󰏫 Annotate" },
        ["<Leader>a<CR>"] = { function() require("neogen").generate() end, desc = "Current" },
        ["<Leader>ac"] = { function() require("neogen").generate { type = "class" } end, desc = "Class" },
        ["<Leader>af"] = { function() require("neogen").generate { type = "func" } end, desc = "Function" },
        ["<Leader>at"] = { function() require("neogen").generate { type = "type" } end, desc = "Type" },
        ["<Leader>aF"] = { function() require("neogen").generate { type = "file" } end, desc = "File" },
        -- telescope plugin mappings
        ["<Leader>fB"] = { "<Cmd>Telescope bibtex<CR>", desc = "Find BibTeX" },
        ["<Leader>fe"] = { "<Cmd>Telescope file_browser<CR>", desc = "File explorer" },
        ["<Leader>fp"] = { function() require("telescope").extensions.projects.projects {} end, desc = "Find projects" },
        ["<Leader>fT"] = { "<Cmd>TodoTelescope<CR>", desc = "Find TODOs" },
        ["<Leader>fx"] = {
          function() require("telescope").extensions.live_grep_args.live_grep_args() end,
          desc = "Find words (args)",
        },
        -- neogit
        ["<Leader>gG"] = { function() require("neogit").open() end, desc = "Neogit" },
        -- compiler
        ["<Leader>m"] = { desc = "󱁤 Compiler" },
        ["<Leader>mk"] = {
          function()
            vim.cmd "silent! write"
            local filename = vim.fn.expand "%:t"
            require("config.utils").async_run(
              { "compiler", vim.fn.expand "%:p" },
              function() require("astrocore").notify("Compiled " .. filename) end
            )
          end,
          desc = "Compile",
        },
        ["<Leader>ma"] = {
          function()
            vim.notify "Autocompile Started"
            require("config.utils").async_run(
              { "autocomp", vim.fn.expand "%:p" },
              function() require("astrocore").notify "Autocompile stopped" end
            )
          end,
          desc = "Auto Compile",
        },
        ["<Leader>mb"] = {
          function()
            local filename = vim.fn.expand "%:t"
            require("config.utils").async_run({
              "pandoc",
              vim.fn.expand "%",
              "--pdf-engine=xelatex",
              "--variable",
              "urlcolor=blue",
              "-t",
              "beamer",
              "-o",
              vim.fn.expand "%:r" .. ".pdf",
            }, function() require("astrocore").notify("Compiled " .. filename) end)
          end,
          desc = "Compile Beamer",
        },
        ["<Leader>mp"] = {
          function()
            local pdf_path = vim.fn.expand "%:r" .. ".pdf"
            if vim.fn.filereadable(pdf_path) == 1 then vim.fn.jobstart { "pdfpc", pdf_path } end
          end,
          desc = "Present Output",
        },
        ["<Leader>ml"] = { function() require("config.utils").toggle_qf() end, desc = "Logs" },
        ["<Leader>mv"] = { function() vim.fn.jobstart { "opout", vim.fn.expand "%:p" } end, desc = "View Output" },
        ["<Leader>mt"] = { "<Cmd>TexlabBuild<CR>", desc = "LaTeX" },
        ["<Leader>mf"] = { "<Cmd>TexlabForward<CR>", desc = "Forward Search" },
        ["<Leader>r"] = { desc = " REPL" },
        ["<Leader>rr"] = { "<Plug>Send", desc = "Send to REPL" },
        ["<Leader>rl"] = { "<Plug>SendLine", desc = "Send line to REPL" },
        ["<Leader>r<CR>"] = { "<Cmd>SendHere<CR>", desc = "Set REPL" },
        ["<Leader>z"] = { "<Cmd>ZenMode<CR>", desc = "Zen Mode" },
        ["<Leader>s"] = { desc = "󰛔 Search/Replace" },
        ["<Leader>ss"] = { function() require("spectre").toggle() end, desc = "Toggle Spectre" },
        ["<Leader>sf"] = { function() require("spectre").open_file_search() end, desc = "Spectre (current file)" },
        ["<Leader>sw"] = {
          function() require("spectre").open_visual { select_word = true } end,
          desc = "Spectre (current word)",
        },
        ["<Leader>x"] = { desc = "󰒡 Trouble" },
        ["<Leader>xx"] = { "<Cmd>TroubleToggle document_diagnostics<CR>", desc = "Document Diagnostics (Trouble)" },
        ["<Leader>xX"] = { "<Cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace Diagnostics (Trouble)" },
        ["<Leader>xl"] = { "<Cmd>TroubleToggle loclist<CR>", desc = "Location List (Trouble)" },
        ["<Leader>xq"] = { "<Cmd>TroubleToggle quickfix<CR>", desc = "Quickfix List (Trouble)" },
        ["<Leader>xT"] = { "<Cmd>TodoTrouble<CR>", desc = "TODOs (Trouble)" },
      },
      v = {
        ["<Leader>r"] = { "<Plug>Send", desc = "Send to REPL" },
        ["<Leader>s"] = { function() require("spectre").open_visual() end, desc = "Spectre" },
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
        -- Easy-Align
        ga = { "<Plug>(EasyAlign)", desc = "Easy Align" },
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
