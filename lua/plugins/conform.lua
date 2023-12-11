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
      opts.log_level = vim.log.levels.DEBUG
      opts.format_on_save = function(bufnr)
        if vim.g.autoformat == nil then vim.g.autoformat = true end
        local autoformat = vim.b[bufnr].autoformat
        if autoformat == nil then autoformat = vim.g.autoformat end
        if autoformat then return { timeout_ms = 500, lsp_fallback = true } end
      end

      opts.formatters_by_ft = {
        ["*"] = { "injected" },
        lua = { "stylua" },
        puppet = { "puppet-lint" },
        python = function(bufnr)
          return require("conform").get_formatter_info("ruff_format", bufnr).available and { "ruff_format" }
            or { "isort", "black" }
        end,
        sh = { "shfmt" },
        ["_"] = { "trim_whitespace", "trim_newlines", "squeeze_blanks" },
      }

      -- prettier filetypes
      vim.tbl_map(function(ft) opts.formatters_by_ft[ft] = { "prettier" } end, {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "jsonc",
        "yaml",
        "yaml.ansible",
        "yaml.cfn",
        "markdown",
        "markdown.mdx",
        "graphql",
        "handlebars",
      })

      opts.formatters = {
        prettier = {
          options = {
            ft_parsers = {
              markdown = "markdown",
            },
          },
        },
      }
    end,
    init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
  },
}
