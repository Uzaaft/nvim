local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

---@type function?
local icon_provider

local function get_icon(ctx)
  ctx.kind_hl_group = "BlinkCmpKind" .. ctx.kind
  if not icon_provider and _G.MiniIcons then icon_provider = _G.MiniIcons.get end
  if ctx.item.source_name == "LSP" then
    local item_doc, color_item = ctx.item.documentation, nil
    if item_doc then
      local highlight_colors_avail, highlight_colors = pcall(require, "nvim-highlight-colors")
      color_item = highlight_colors_avail and highlight_colors.format(item_doc, { kind = ctx.kind })
    end
    if icon_provider then
      local icon, hl = icon_provider("lsp", ctx.kind or "")
      if icon then
        ctx.kind_icon = icon
        ctx.kind_hl_group = hl
      end
    end
    if color_item and color_item.abbr and color_item.abbr_hl_group then
      ctx.kind_icon, ctx.kind_hl_group = color_item.abbr, color_item.abbr_hl_group
    end
  elseif ctx.item.source_name == "Path" then
    if icon_provider then
      ctx.kind_icon, ctx.kind_hl_group = icon_provider(ctx.kind == "Folder" and "directory" or "file", ctx.label)
    end
  end
  return ctx
end

return {
  "Saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  version = "0.*",
  dependencies = { "rafamadriz/friendly-snippets" },
  opts_extend = { "sources.default", "sources.cmdline" },
  opts = {
    sources = {
      default = { "lsp", "snippets", "path", "buffer" },
    },
    keymap = {
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-N>"] = { "select_next", "show" },
      ["<C-P>"] = { "select_prev", "show" },
      ["<C-J>"] = { "select_next", "fallback" },
      ["<C-K>"] = { "select_prev", "fallback" },
      ["<C-U>"] = { "scroll_documentation_up", "fallback" },
      ["<C-D>"] = { "scroll_documentation_down", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = {
        "select_next",
        "snippet_forward",
        function(cmp)
          if has_words_before() or vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
        end,
        "fallback",
      },
      ["<S-Tab>"] = {
        "select_prev",
        "snippet_backward",
        function(cmp)
          if vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
        end,
        "fallback",
      },
    },
    completion = {
      list = { selection = "auto_insert" },
      menu = {
        auto_show = function(ctx) return ctx.mode ~= "cmdline" end,
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        draw = {
          treesitter = { "lsp" },
          components = {
            kind_icon = {
              text = function(ctx)
                get_icon(ctx)
                return ctx.kind_icon .. ctx.icon_gap
              end,
              highlight = function(ctx) return get_icon(ctx).kind_hl_group end,
            },
          },
        },
      },
      accept = {
        auto_brackets = { enabled = true },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        },
      },
    },
    signature = {
      enabled = true,
      window = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
      },
    },
  },
  specs = {
    {
      "AstroNvim/astrolsp",
      optional = true,
      opts = function(_, opts) opts.capabilities = require("blink.cmp").get_lsp_capabilities(opts.capabilities) end,
    },
    {
      "folke/lazydev.nvim",
      optional = true,
      specs = {
        {
          "Saghen/blink.cmp",
          opts_extend = { "sources.default" },
          opts = {
            sources = {
              -- add lazydev to your completion providers
              default = { "lazydev" },
              providers = {
                lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
              },
            },
          },
        },
      },
    },
    {
      "moyiz/blink-emoji.nvim",
      lazy = true,
      specs = {
        {
          "Saghen/blink.cmp",
          opts_extend = { "sources.default" },
          opts = {
            sources = {
              default = { "emoji" },
              providers = {
                emoji = { name = "Emoji", module = "blink-emoji", min_keyword_length = 1, score_offset = -1 },
              },
            },
          },
        },
      },
    },
    {
      "Saghen/blink.compat",
      version = "*",
      lazy = true,
      opts = {},
      specs = {
        {
          "Saghen/blink.cmp",
          opts_extend = { "sources.default" },
          dependencies = { "jc-doyle/cmp-pandoc-references" },
          opts = {
            sources = {
              default = { "pandoc" },
              providers = {
                pandoc = { name = "pandoc_references", module = "blink.compat.source", score_offset = 10 },
              },
            },
          },
        },
        {
          "Saghen/blink.cmp",
          opts_extend = { "sources.default" },
          dependencies = { "kdheepak/cmp-latex-symbols" },
          opts = {
            sources = {
              default = { "latex" },
              providers = {
                latex = { name = "latex_symbols", module = "blink.compat.source", score_offset = -1 },
              },
            },
          },
        },
      },
    },
    { "catppuccin", optional = true, opts = { integrations = { blink_cmp = true } } },
    -- disable built in completion plugins
    { "hrsh7th/nvim-cmp", enabled = false },
    { "rcarriga/cmp-dap", enabled = false },
    { "L3MON4D3/LuaSnip", enabled = false },
    { "onsails/lspkind.nvim", enabled = false },
  },
}
