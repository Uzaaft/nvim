local randomhead = function()
  local ascii_art = {
    "⣿⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⢻⡇",
    "⣿                                                     ⢸⡇",
    "⣿                                                     ⢸⡇",
    "⣿                                                     ⢸⡇",
    "⣿                                                     ⢸⡇",
    "⣿                                                     ⢸⡇",
    "⣿                                                     ⢸⡇",
    "⣿                                                     ⢸⡇",
    "⣿                                                     ⢸⡇",
    "⣿              ⣤⣤⣤⣤⣤⣤⣄             ⣶⣶⡆                ⢸⡇                      ⣀⣀    ⢰⣶⣶",
    "⣿              ⣿⣿⡟⠛⠛⠻⣿⣷⣄   ⢀⣀⡀     ⣿⣿⡇                ⢈⣁⡀   ⢀⣀⡀       ⣀⣀⡀     ⣿⣿    ⢸⣿⣿ ⢀⣀⡀",
    "⣿              ⣿⣿⡇   ⢸⣿⣿ ⣠⣾⣿⣿⣿⣿⣶⡀  ⣿⣿⡇⠈⢿⣿⣧    ⣼⣿⠏ ⢸⣿⣿⣾⣿⣿⣿⣷⣴⣾⣿⣿⣿⣷⡀  ⢰⣾⣿⣿⣿⣿⣿⣆  ⣿⣿⣿⣿⣿⣿⡇⢸⣿⣿⣾⣿⣿⣿⣷⡄",
    "⣿              ⣿⣿⣧⣤⣤⣴⣿⣿⠏⣼⣿⣿⠁ ⠈⠻⣿⣷  ⣿⣿⡇ ⠘⣿⣿⡇  ⣰⣿⣿  ⢸⣿⣿⠏  ⢹⣿⣿⠋  ⢹⣿⣧  ⠘⠋⠁⣀⣀⣈⣻⣿⡆  ⣿⣿⠁   ⢸⣿⣿⠋  ⢹⣿⣿",
    "⣿              ⣿⣿⡟⠛⠛⠛⠋  ⣿⣿⡇    ⣿⣿⡇ ⣿⣿⡇  ⠘⣿⣿⡀⣰⣿⣿⠃  ⢸⣿⣿   ⢸⣿⡇   ⢸⣿⣿  ⣰⣿⣿⠿⠿⠿⢿⣿⡇  ⣿⣿    ⢸⣿⣿   ⢸⣿⣿",
    "⣿              ⣿⣿⡇      ⢿⣿⣿   ⣠⣿⣿  ⣿⣿⡇   ⠸⣿⣷⣿⣿⠇   ⢸⣿⣿   ⢸⣿⡇   ⢸⣿⣿  ⣿⣿⡇  ⢀⣾⣿⡇  ⣿⣿⡄   ⢸⣿⣿   ⢸⣿⣿",
    "⣿              ⣿⣿⡇      ⠈⠛⢿⣷⣶⣾⣿⠿⠃  ⣿⣿⡇    ⢹⣿⣿⠏    ⢸⣿⣿   ⢸⣿⡇   ⢸⣿⣿  ⠙⢿⣿⣶⣶⣿⢿⣿⡇  ⠘⠿⣿⣿⣿⡇⢸⣿⣿   ⢸⣿⣿",
    "⣿                          ⠈⠉⠁          ⣀⣀⣼⣿⡏                        ⠈⠉⠁",
    "⣿                                      ⢸⣿⣿⡿⠏          ⢀⡀",
    "⣿                                                     ⢸⡇",
    "⣿                                                     ⢸⡇",
    "⣿                                                     ⢸⡇",
    "⣿                                                     ⢸⡇",
    "⣿                                                     ⢸⡇",
    "⣿                                                     ⢸⡇",
    "⣿                                                     ⢸⡇",
    "⣿                                                     ⢸⡇",
    "⣿                                                     ⢸⡇",
    "⠿⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠾⠇",
  }
  return table.concat(ascii_art, "\n")
end
return {

  { "alpha-nvim", enabled = false }, -- disable starter
  {
    "echasnovski/mini.starter",
    version = false,
    enabled = true,
    event = "VimEnter",
    opts = function()
      -- local pad = string.rep(" ", 0)
      local function new_section(name, action, section) return { name = name, action = action, section = section } end
      local starter = require "mini.starter"
      local config = {
        evaluate_single = true,
        header = randomhead(),
        items = {
          starter.sections.recent_files(5, true, false),
          new_section("Find Git file", "Telescope git_files", "Telescope"),
          new_section("Old files(Recent)", "Telescope oldfiles", "Telescope"),
          new_section("Word grep", "Telescope live_grep", "Telescope"),
          new_section("Config", "e ~/.config/nvim", "Config"),
          new_section(
            "Directory Session",
            function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
            "Built-in"
          ),
          new_section("Last Session", function() require("resession").load "Last Session" end, "Built-in"),
          new_section("Sessions", function() require("resession").load() end, "Built-in"),
          new_section("Lazy", "Lazy", "Config"),
          new_section("New file", "ene | startinsert", "Built-in"),
          new_section("Quit", "qa", "Built-in"),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet("░ ", true),
          starter.gen_hook.aligning("center", "center"),
        },
      }
      return config
    end,
    config = function(_, config)
      -- close Lazy and re-open when starter is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniStarterOpened",
          callback = function() require("lazy").show() end,
        })
      end

      local starter = require "mini.starter"
      starter.setup(config)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          -- local pad_footer = string.rep(" ", 0)
          starter.config.footer = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(starter.refresh)
        end,
      })
    end,
  },
}
