return {
  "echasnovski/mini.icons",
  opts = {},
  init = function()
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
  specs = {
    { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
  },
}
