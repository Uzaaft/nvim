---@type LazySpec
return {
  -- TODO: revert after merge: https://github.com/linux-cultist/venv-selector.nvim/pull/188
  -- "linux-cultist/venv-selector.nvim",
  -- branch = "regexp",
  "stefanboca/venv-selector.nvim",
  branch = "sb/push-rlpxsqmllxtz",
  cmd = "VenvSelect",
  opts = function()
    local opts = {
      name = { "env", ".env", "venv", ".venv" },
      notify_user_on_activate = false,
      parents = 0,
      picker = "native",
    }
    if vim.env.MAMBA_HOME then
      opts.anaconda_base_path = vim.env.MAMBA_HOME
      opts.anaconda_envs_path = vim.env.MAMBA_HOME .. "/envs"
    end
    return opts
  end,
  specs = {
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
}
