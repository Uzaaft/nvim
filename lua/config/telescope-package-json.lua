local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local actions = require "telescope.actions"

local M = {}

M.run_command_in_buffer = function(command)
  -- Open a new vertical split
  vim.api.nvim_command "vsp"

  -- Run the command in Neovim's terminal in the new split
  vim.api.nvim_command("term " .. command)
end

M.open_floating_term = function(command)
  local buf = vim.api.nvim_create_buf(false, true) -- Create a new buffer, not listed and not scratch by default
  local width = math.ceil(vim.o.columns * 0.8)
  local height = math.ceil(vim.o.lines * 0.8)
  local row = math.ceil((vim.o.lines - height) / 2)
  local col = math.ceil((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
  })

  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.fn.termopen(command)

  return buf, win
end

M.get_npm_scripts = function()
  local package_path = vim.fn.getcwd() .. "/package.json"

  if vim.fn.filereadable(package_path) == 0 then
    print "No package.json found!"
    return {}
  end

  local content = vim.fn.readfile(package_path)
  local package_data = vim.fn.json_decode(content)

  if package_data.scripts then
    local scripts = {}
    for script_name, script_cmd in pairs(package_data.scripts) do
      table.insert(scripts, script_name .. ": " .. script_cmd)
    end
    return scripts
  else
    print "No scripts in package.json!"
    return {}
  end
end

M.script_picker = function()
  local scripts = M.get_npm_scripts()

  pickers
    .new({}, {
      prompt_title = "NPM Scripts",
      finder = finders.new_table {
        results = scripts,
      },
      sorter = sorters.get_fzy_sorter(),
      attach_mappings = function(prompt_bufnr, map)
        map("i", "<CR>", function()
          local selection = require("telescope.actions.state").get_selected_entry()
          require("telescope.actions").close(prompt_bufnr)

          local cmd = "npm run " .. string.match(selection.value, "^([^:]+):")
          M.run_command_in_buffer(cmd)
        end)
        return true
      end,
    })
    :find()
end

return M
