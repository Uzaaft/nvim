-- bootstrap lazy.nvim, AstroNvim, and user plugins
require "config.lazy"

local function yaml_ft(path, bufnr)
  if
    -- check if file is in roles, tasks, or handlers folder
    vim.regex("(tasks\\|roles\\|handlers)/"):match_str(path)
    -- check for known ansible playbook text and if found, return yaml.ansible
    or vim.regex("hosts:\\|tasks:"):match_str(table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n"))
  then
    return "yaml.ansible"
  else -- return yaml if nothing else
    return "yaml"
  end
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
