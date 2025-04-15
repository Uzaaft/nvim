---@type LazySpec
return {
  "echasnovski/mini.snippets",
  dependencies = "rafamadriz/friendly-snippets",
  opts_extend = { "snippets" },
  opts = function(_, opts)
    local mini_snippets = require "mini.snippets"
    local gen_loader = mini_snippets.gen_loader
    opts.snippets = vim.list_extend(opts.snippets or {}, {
      -- global snippets file
      gen_loader.from_file(vim.fn.stdpath "config" .. "/snippets/global.json"),
      -- load language specific snippets from runtime
      gen_loader.from_lang(),
      -- load global, project local snippets
      gen_loader.from_file ".vscode/project.code-snippets",
      -- load language specific, project local snippets
      function(context)
        local rel_path = ".vscode/" .. context.lang .. ".code-snippets"
        return vim.fn.filereadable(rel_path) == 1 and mini_snippets.read_file(rel_path)
      end,
    })
    opts.mappings = {
      expand = "",
      jump_next = "",
      jump_prev = "",
      stop = "",
    }
  end,
  specs = {
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        local snippet_mode_change
        local stop_all_sessions = function()
          local mini_snippets = require "mini.snippets"
          while mini_snippets.session.get(false) do
            mini_snippets.session.stop()
          end
          snippet_mode_change = nil
        end
        opts.autocmds.mini_snippets_stop = {
          {
            event = "User",
            pattern = "MiniSnippetsSessionStart",
            desc = "Set up snippet stopping when going to normal mode autocmd",
            callback = function()
              if not snippet_mode_change then
                snippet_mode_change = vim.api.nvim_create_autocmd(
                  "ModeChanged",
                  { pattern = "*:n", once = true, callback = stop_all_sessions }
                )
              end
            end,
          },
        }
      end,
    },
    {
      "Saghen/blink.cmp",
      dependencies = "echasnovski/mini.snippets",
      optional = true,
      opts = { snippets = { preset = "mini_snippets" } },
    },
    {
      "danymat/neogen",
      optional = true,
      opts = { snippet_engine = "mini" },
    },
    { "L3MON4D3/LuaSnip", enabled = false },
  },
}
