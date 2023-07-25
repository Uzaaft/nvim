local function yaml_ft(path, bufnr)
  -- get content of buffer as string
  local content = vim.filetype.getlines(bufnr)
  if type(content) == "table" then content = table.concat(content, "\n") end

  -- check if file is in roles, tasks, or handlers folder
  local path_regex = vim.regex "(tasks\\|roles\\|handlers)/"
  if path_regex and path_regex:match_str(path) then return "yaml.ansible" end
  -- check for known ansible playbook text and if found, return yaml.ansible
  local regex = vim.regex "hosts:\\|tasks:"
  if regex and regex:match_str(content) then return "yaml.ansible" end

  -- return yaml if nothing else
  return "yaml"
end

vim.filetype.add {
  extension = {
    qmd = "markdown",
    yml = yaml_ft,
    yaml = yaml_ft,
  },
  pattern = {
    ["/tmp/neomutt.*"] = "markdown",
  },
}

-- Auto Commands
if vim.fn.executable "autocomp" == 1 then
  vim.api.nvim_create_autocmd("VimLeave", {
    desc = "Stop running auto compiler on leave",
    group = vim.api.nvim_create_augroup("quit_autocomp", { clear = true }),
    pattern = "*",
    callback = function() vim.fn.jobstart { "autocomp", vim.fn.expand "%:p", "stop" } end,
  })
end

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable wrap and spell for text like documents",
  group = vim.api.nvim_create_augroup("auto_spell", { clear = true }),
  pattern = { "gitcommit", "markdown", "text", "plaintex" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  desc = "Auto hide tabline",
  group = vim.api.nvim_create_augroup("autohide_tabline", { clear = true }),
  pattern = "AstroBufsUpdated",
  callback = function()
    local new_showtabline = #vim.t.bufs > 1 and 2 or 1
    if new_showtabline ~= vim.opt.showtabline:get() then vim.opt.showtabline = new_showtabline end
  end,
})

if vim.env.KITTY_LISTEN_ON then
  local cmd = require("astrocore.utils").cmd

  for _, color in ipairs(vim.fn.split(cmd { "kitty", "@", "get-colors" } or "", "\n")) do
    local orig_bg = color:match "^background%s+(#[0-9a-fA-F]+)$"
    if orig_bg then
      local function set_bg(new_color) cmd { "kitty", "@", "set-colors", ("background=%s"):format(new_color) } end

      local augroup = vim.api.nvim_create_augroup("kitty_background", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        desc = "set kitty background to colorscheme's background",
        pattern = "AstroColorScheme",
        group = augroup,
        callback = function()
          local bg_color = require("astrocore.utils").get_hlgroup("Normal").bg
          if not bg_color or bg_color == "NONE" then
            bg_color = orig_bg
          elseif type(bg_color) == "number" then
            bg_color = string.format("#%06x", bg_color)
          end

          set_bg(bg_color)
        end,
      })

      vim.api.nvim_create_autocmd("VimLeave", {
        desc = "set kitty background back to original background",
        group = augroup, -- add autocmd to augroup
        callback = function() set_bg(orig_bg) end,
      })
      break
    end
  end
end
