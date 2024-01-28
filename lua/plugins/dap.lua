local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
}

---@type LazySpec
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "jbyuki/one-small-step-for-vimkind" },
    "rcarriga/nvim-dap-ui",
    { "theHamsta/nvim-dap-virtual-text", config = true },
    "mxsdev/nvim-dap-vscode-js",
    -- build debugger from source
    {
      "microsoft/vscode-js-debug",
      -- After install, build it and rename the dist directory to out
      build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
      version = "1.*",
    },
    {
      "mxsdev/nvim-dap-vscode-js",
      opts = {
        debugger_path = vim.fn.resolve(vim.fn.stdpath "data" .. "/lazy/vscode-js-debug"),
        adapters = {
          "chrome",
          "pwa-node",
          "pwa-chrome",
          "pwa-msedge",
          "pwa-extensionHost",
          "node-terminal",
        },
      },
    },
  },
  config = function()
    local dap = require "dap"
    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        -- Debug single nodejs files
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        },
        -- Debug nodejs processes (make sure to add --inspect when you run the process)
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        },
        -- Debug web applications (client side)
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch & Debug Chrome",
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({
                prompt = "Enter URL: ",
                default = "http://localhost:3000",
              }, function(url)
                if url == nil or url == "" then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = vim.fn.getcwd(),
          protocol = "inspector",
          sourceMaps = true,
          userDataDir = false,
        },
        -- Divider for the launch.json derived configs
        {
          name = "----- ↓ launch.json configs ↓ -----",
          type = "",
          request = "launch",
        },
      }
    end

    -- Use overseer for running preLaunchTask and postDebugTask.
    require("overseer").patch_dap(true)
    require("dap.ext.vscode").json_decode = require("overseer.json").decode

    -- Lua configurations.
    dap.adapters.nlua = function(callback, config)
      callback { type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 }
    end
    dap.configurations["lua"] = {
      {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance",
      },
    }

    -- C configurations.
    dap.adapters.codelldb = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
      },
    }

    -- Add configurations from launch.json
    require("dap.ext.vscode").load_launchjs(nil, {
      ["codelldb"] = { "c" },
      ["pwa-node"] = { "typescript", "javascript" },
    })
  end,
  keys = {
    {
      "<leader>da",
      function()
        if vim.fn.filereadable ".vscode/launch.json" then
          local dap_vscode = require "dap.ext.vscode"
          dap_vscode.load_launchjs(nil, {
            ["pwa-node"] = js_based_languages,
            ["chrome"] = js_based_languages,
            ["pwa-chrome"] = js_based_languages,
          })
        end
        require("dap").continue()
      end,
      desc = "Run with Args",
    },
  },
}
