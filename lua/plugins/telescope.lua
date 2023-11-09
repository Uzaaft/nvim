return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        -- buffer switching
        opts.mappings.n["<Tab>"] = {
          function()
            if #vim.t.bufs > 1 then
              require("telescope.builtin").buffers { sort_mru = true, ignore_current_buffer = true }
            else
              require("astrocore").notify "No other buffers open"
            end
          end,
          desc = "Switch Buffers",
        }
      end,
    },
  },
  opts = {
    defaults = {
      results_title = "",
      selection_caret = "  ",
      layout_config = {
        width = 0.90,
        height = 0.85,
        preview_cutoff = 120,
        horizontal = {
          preview_width = 0.6,
        },
        vertical = {
          width = 0.9,
          height = 0.95,
          preview_height = 0.5,
        },
        flex = {
          horizontal = {
            preview_width = 0.9,
          },
        },
      },
    },
    pickers = {
      find_files = {
        hidden = true,
        find_command = function(cfg)
          local find_command = { "rg", "--files", "--color", "never" }
          if not cfg.no_ignore then vim.list_extend(find_command, { "--glob", "!**/.git/**" }) end
          return find_command
        end,
      },
      buffers = {
        path_display = { "smart" },
        mappings = {
          i = { ["<C-d>"] = function(...) return require("telescope.actions").delete_buffer(...) end },
          n = { ["d"] = function(...) return require("telescope.actions").delete_buffer(...) end },
        },
      },
    },
  },
}
