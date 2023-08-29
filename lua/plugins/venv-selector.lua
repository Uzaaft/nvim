return {
  "linux-cultist/venv-selector.nvim",
  cmd = { "VenvSelect", "VenvSelectCached" },
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>v"] = { "<Cmd>VenvSelect<CR>", desc = "Activate virtual environment" },
          },
        },
      },
    },
    {
      "rebelot/heirline.nvim",
      opts = function(_, opts)
        opts.statusline[10] = require("astroui.status").component.virtual_env {
          on_click = {
            name = "heirline_virtual_env",
            callback = function()
              if require("astrocore").is_available "venv-selector.nvim" then
                vim.defer_fn(function() vim.cmd.VenvSelect() end, 100)
              end
            end,
          },
        }
      end,
    },
  },
  opts = {
    name = { "env", ".env", "venv", ".venv" },
    notify_user_on_activate = false,
    parents = 0,
    anaconda_base_path = vim.env.XDG_DATA_HOME .. "/mambaforge",
    anaconda_envs_path = vim.env.XDG_DATA_HOME .. "/mambaforge/envs",
  },
}
