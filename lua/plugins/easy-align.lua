---@type LazySpec
return {
  "junegunn/vim-easy-align",
  keys = { "<Plug>(EasyAlign)" },
  specs = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = { ga = { "<Plug>(EasyAlign)", desc = "Easy Align" } },
          x = { ga = { "<Plug>(EasyAlign)", desc = "Easy Align" } },
        },
      },
    },
  },
}
