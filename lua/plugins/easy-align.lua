---@type LazySpec
return {
  "junegunn/vim-easy-align",
  event = "User AstroFile",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = { ga = { "<Plug>(EasyAlign)", desc = "Easy Align" } },
        x = { ga = { "<Plug>(EasyAlign)", desc = "Easy Align" } },
      },
    },
  },
}
