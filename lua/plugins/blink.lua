local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

---@type function|nil|false
local mini_icons_get
---@type function|nil|false
local highlight_colors_format
---@type table?
local kinds

local function get_icon(ctx)
  ctx.kind_hl_group = "BlinkCmpKind" .. ctx.kind
  if mini_icons_get == nil then
    local mini_icons_avail, mini_icons = pcall(require, "mini.icons")
    mini_icons_get = mini_icons_avail and mini_icons.get or false
  end
  if mini_icons_get then
    if ctx.item.source_name == "LSP" then
      local icon, hl = mini_icons_get("lsp", ctx.kind or "")
      if icon then
        ctx.kind_icon = icon
        ctx.kind_hl_group = hl
      end
    elseif ctx.item.source_name == "Path" then
      ctx.kind_icon, ctx.kind_hl_group = mini_icons_get(ctx.kind == "Folder" and "directory" or "file", ctx.label)
    end
  end
  if highlight_colors_format == nil then
    local highlight_colors_avail, highlight_colors = pcall(require, "nvim-highlight-colors")
    highlight_colors_format = highlight_colors_avail and highlight_colors.format or false
  end
  if highlight_colors_format then
    if not kinds then kinds = require("blink.cmp.types").CompletionItemKind end
    if ctx.item.kind == kinds.Color then
      local doc = vim.tbl_get(ctx, "item", "documentation")
      if doc then
        local color_item = highlight_colors_format(doc, { kind = kinds[kinds.Color] })
        if color_item and color_item.abbr_hl_group then
          if color_item.abbr then ctx.kind_icon = color_item.abbr end
          ctx.kind_hl_group = color_item.abbr_hl_group
        end
      end
    end
  end
  return ctx
end

return {
  "Saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  version = "0.*",
  opts_extend = { "sources.default", "sources.cmdline" },
  opts = {
    sources = {
      default = { "lsp", "snippets", "path", "buffer" },
      providers = {
        path = { opts = { trailing_slash = false } },
      },
    },
    snippets = { preset = "luasnip" },
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
      list = { selection = { preselect = false, auto_insert = true } },
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
        auto_show_delay_ms = 0,
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
    { "onsails/lspkind.nvim", enabled = false },
  },
}
