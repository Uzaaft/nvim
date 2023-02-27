vim.api.nvim_create_autocmd("VimLeave", {
  desc = "Stop running auto compiler",
  group = vim.api.nvim_create_augroup("autocomp", { clear = true }),
  pattern = "*",
  callback = function() vim.fn.jobstart { "autocomp", vim.fn.expand "%:p", "stop" } end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "spectre_panel",
  },
  group = vim.api.nvim_create_augroup("misc_q_close", { clear = true }),
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, nowait = true })
  end,
})

-- text like documents enable wrap and spell
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text", "plaintex" },
  group = vim.api.nvim_create_augroup("auto_spell", { clear = true }),
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- remember folds
local view_grp = vim.api.nvim_create_augroup("auto_view", { clear = true })
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = view_grp,
  callback = function(event)
    if vim.b[event.buf].view_activated then vim.cmd.mkview() end
  end,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = view_grp,
  callback = function(event)
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = event.buf })
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = event.buf })
    local ignore_filetypes = { "gitcommit", "gitrebase" }
    if buftype == "" and filetype and filetype ~= "" and not vim.tbl_contains(ignore_filetypes, filetype) then
      vim.b[event.buf].view_activated = true
      vim.cmd.loadview()
    end
  end,
})
