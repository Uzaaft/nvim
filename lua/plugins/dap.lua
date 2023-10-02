return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    { "theHamsta/nvim-dap-virtual-text", config = true },
    "mxsdev/nvim-dap-vscode-js",
    -- build debugger from source
    {
      "mxsdev/nvim-dap-vscode-js",
      opts = {
        debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      },
    },
    {
      "microsoft/vscode-js-debug",
      version = "1.x",
      build = "npm i && npm run compile vsDebugServerBundle && mv -f dist out",
    },
  },
  config = function()
    -- require("dap-vscode-js").setup {
    --   debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
    --   adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
    -- }
    -- Add configurations from launch.json
    require("dap.ext.vscode").load_launchjs(nil, {
      ["pwa-node"] = { "typescript", "javascript", "typescriptreact" },
    })
  end,
}
