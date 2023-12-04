return {
  -- "stevearc/oil.nvim",
  -- use fork until issue is closed: https://github.com/stevearc/oil.nvim/issues/245
  "mehalter/oil.nvim",
  branch = "sessionloadpost_perf",
  cmd = "Oil",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
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
        local old_disable = opts.opts.disable_winbar_cb
        opts.opts.disable_winbar_cb = function(args)
          if vim.bo[args.buf].filetype ~= "oil" and old_disable then return old_disable(args) end
        end

        if opts.winbar then
          table.insert(opts.winbar, 1, {
            condition = function(args) return vim.bo[args.bufnr].filetype == "oil" end,
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
    keymaps = {
      ["<Tab>"] = "actions.close",
    },
  },
}
