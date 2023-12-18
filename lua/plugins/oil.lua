return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  init = function() -- start oil on startup lazily if necessary
    if vim.fn.argc() == 1 then
      local arg = vim.fn.argv(0)
      ---@cast arg string
      local stat = vim.loop.fs_stat(arg)
      local adapter = string.match(arg, "^([%l-]*)://")
      if (stat and stat.type == "directory") or adapter == "oil-ssh" then require "oil" end
    end
  end,
  dependencies = {
    { "nvim-neo-tree/neo-tree.nvim", opts = { filesystem = { hijack_netrw_behavior = "disabled" } } },
    {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          neotree_start = false,
          oil_start = {
            {
              event = "BufNew",
              desc = "start oil when editing a directory",
              callback = function()
                if package.loaded["oil"] then
                  vim.api.nvim_del_augroup_by_name "oil_start"
                elseif vim.fn.isdirectory(vim.fn.expand "<afile>") == 1 then
                  require "oil"
                  vim.api.nvim_del_augroup_by_name "oil_start"
                end
              end,
            },
          },
          oil_settings = {
            {
              event = "FileType",
              desc = "Disable view saving for oil buffers",
              pattern = "oil",
              callback = function(args) vim.b[args.buf].view_activated = false end,
            },
          },
        },
        mappings = {
          n = {
            ["<Tab>"] = { "<Cmd>Oil<CR>", desc = "Oil Filebrowser" },
          },
        },
      },
    },
    {
      "rebelot/heirline.nvim",
      opts = function(_, opts)
        local status = require "astroui.status"
        local old_disable = opts.opts.disable_winbar_cb
        opts.opts.disable_winbar_cb = function(args)
          if status.condition.buffer_matches({ filetype = "^oil$" }, args.buf) then return false end
          return old_disable(args)
        end

        if opts.winbar then
          table.insert(opts.winbar, 1, {
            condition = function(args) return status.condition.buffer_matches({ filetype = "oil" }, args.bufnr) end,
            require("astroui.status").component.separated_path {
              padding = { left = 2 },
              max_depth = false,
              suffix = false,
              path_func = function() return require("oil").get_current_dir() end,
            },
          })
        end
      end,
    },
  },
  opts = {
    skip_confirm_for_simple_edits = true,
    keymaps = {
      ["<Tab>"] = "actions.close",
    },
  },
}
