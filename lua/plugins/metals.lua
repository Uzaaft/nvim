---@type LazySpec
return {
  "scalameta/nvim-metals",
  dependencies = { "AstroNvim/astrolsp", opts = { handlers = { metals = false } } },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "scala", "sbt" },
      group = vim.api.nvim_create_augroup("nvim-metals", { clear = true }),
      desc = "Initialize and attache nvim-metals",
      callback = function()
        if vim.fn.executable "cs" ~= 1 and vim.fn.executable "coursier" ~= 1 then return end

        local metals = require "metals"
        local user_config = require("astrolsp").lsp_opts "metals"
        local old_on_attach = user_config.on_attach
        user_config.on_attach = function(...)
          old_on_attach(...)
          metals.setup_dap()
        end
        metals.initialize_or_attach(require("astrocore").extend_tbl(metals.bare_config(), user_config))

        local dap_avail, dap = pcall(require, "dap")
        if dap_avail then
          dap.configurations.scala = {
            {
              type = "scala",
              request = "launch",
              name = "RunOrTest",
              metals = { runType = "runOrTestFile" },
            },
            {
              type = "scala",
              request = "launch",
              name = "Test Target",
              metals = { runType = "testTarget" },
            },
          }
        end
      end,
    })
  end,
}
