return {
  before_init = function(_, config)
    -- check for nvim-lspconfig julia sysimage shim
    local found_shim
    for _, depot in
      ipairs(
        vim.env.JULIA_DEPOT_PATH and vim.split(vim.env.JULIA_DEPOT_PATH, vim.fn.has "win32" == 1 and ";" or ":")
          or { vim.fn.expand "~/.julia" }
      )
    do
      local bin = vim.fs.joinpath(depot, "environments", "nvim-lspconfig", "bin", "julia")
      local file = (vim.uv or vim.loop).fs_stat(bin)
      if file and file.type == "file" then
        found_shim = bin
        break
      end
    end
    if found_shim then
      config.cmd[1] = found_shim
    else
      config.autostart = false -- only auto start if sysimage is available
    end
  end,
  on_attach = function(client)
    local environment = vim.tbl_get(client, "settings", "julia", "environmentPath")
    if environment then client.notify("julia/activateenvironment", { envPath = environment }) end
  end,
  settings = {
    julia = {
      completionmode = "qualify",
      lint = { missingrefs = "none" },
    },
  },
}
