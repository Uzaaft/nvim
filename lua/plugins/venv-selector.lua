---@type LazySpec
return {
  "linux-cultist/venv-selector.nvim",
  cmd = { "VenvSelect", "VenvSelectCached" },
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>v"] = { "<Cmd>VenvSelect<CR>", desc = "Activate virtual environment" },
          },
        },
      },
    },
  },
  opts = function()
    local opts = {
      name = { "env", ".env", "venv", ".venv" },
      notify_user_on_activate = false,
      parents = 0,
    }
    if vim.env.MAMBA_HOME then
      opts.anaconda_base_path = vim.env.MAMBA_HOME
      opts.anaconda_envs_path = vim.env.MAMBA_HOME .. "/envs"
    end
    return opts
  end,
}
