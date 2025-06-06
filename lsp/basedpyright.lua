return {
  before_init = function(_, c)
    if not c.settings then c.settings = {} end
    if not c.settings.python then c.settings.python = {} end
    c.settings.python.pythonPath = vim.fn.exepath "python"
  end,
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",
        autoImportCompletions = true,
      },
    },
  },
}
