return {
  { "AstroNvim/astrolsp", opts = { formatting = { disabled = true } } },
  {
    "stevearc/conform.nvim",
    event = "User AstroFile",
    cmd = "ConformInfo",
    dependencies = {
      "williamboman/mason.nvim",
      {
        "AstroNvim/astrocore",
        opts = {
          commands = {
            Format = {
              function(args)
                local range = nil
                if args.count ~= -1 then
                  local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                  range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line:len() },
                  }
                end
                require("conform").format { async = true, lsp_fallback = true, range = range }
              end,
              desc = "Format buffer",
              range = true,
            },
          },
          mappings = {
            n = {
              ["<Leader>lf"] = { function() vim.cmd.Format() end, desc = "Format buffer" },
              ["<Leader>lI"] = { function() vim.cmd.ConformInfo() end, desc = "Conform information" },
              ["<Leader>uf"] = {
                function()
                  if vim.b.autoformat == nil then
                    if vim.g.autoformat == nil then vim.g.autoformat = true end
                    vim.b.autoformat = vim.g.autoformat
                  end
                  vim.b.autoformat = not vim.b.autoformat
                  require("astrocore").notify(
                    string.format("Buffer autoformatting %s", vim.b.autoformat and "on" or "off")
                  )
                end,
                desc = "Toggle autoformatting (buffer)",
              },
              ["<Leader>uF"] = {
                function()
                  if vim.g.autoformat == nil then vim.g.autoformat = true end
                  vim.g.autoformat = not vim.g.autoformat
                  vim.b.autoformat = nil
                  require("astrocore").notify(
                    string.format("Global autoformatting %s", vim.g.autoformat and "on" or "off")
                  )
                end,
                desc = "Toggle autoformatting (global)",
              },
            },
          },
        },
      },
    },
    opts = function(_, opts)
      opts.format_on_save = function(bufnr)
        if vim.g.autoformat == nil then vim.g.autoformat = true end
        local autoformat = vim.b[bufnr].autoformat
        if autoformat == nil then autoformat = vim.g.autoformat end
        if autoformat then return { timeout_ms = 500, lsp_fallback = true } end
      end
      -- Check to see if pretties config is in root
      local prettier_config_files = {
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.yml",
        ".prettierrc.yaml",
        ".prettierrc.json5",
        ".prettierrc.js",
        ".prettierrc.cjs",
        "prettier.config.js",
        ".prettierrc.mjs",
        "prettier.config.mjs",
        "prettier.config.cjs",
        ".prettierrc.toml",
      }
      local prettier_config = nil
      for _, file in ipairs(prettier_config_files) do
        if vim.fn.filereadable(file) == 1 then
          prettier_config = file
          break
        end
      end
      -- Check to see if biome.json is in root
      local biome_config = nil
      if vim.fn.filereadable "biome.json" == 1 then biome_config = "biome.json" end
      -- If biome, use biome, else use prettier
      local formatter = biome_config ~= nil and "biome" or "prettierd"

      opts.formatters_by_ft = {
        ["*"] = { "injected" },
        lua = { "stylua" },
        sql = { "sqlfluff" },
        typescriptreact = { formatter },
        typescript = { formatter },
        javascriptreact = { formatter },
        javascript = { formatter },
        python = function(bufnr)
          return require("conform").get_formatter_info("ruff_format", bufnr).available and { "ruff_format" }
            or { "isort", "black" }
        end,
        sh = { "shfmt" },
        ["_"] = function(bufnr)
          return require("astrocore.buffer").is_valid(bufnr)
              and { "trim_whitespace", "trim_newlines", "squeeze_blanks" }
            or {}
        end,
      }
    end,
    init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
  },
}
