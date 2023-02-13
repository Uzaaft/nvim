return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "core.utils.status"
    opts.tabline[2] = status.heirline.make_buflist(status.component.tabline_file_info { close_button = false })

    opts.winbar[3] = {
      status.component.file_info { -- add file_info to breadcrumbs
        unique_path = {},
        file_icon = { hl = status.hl.filetype_color },
        file_modified = false,
        file_read_only = false,
        hl = status.hl.get_attributes("winbar", true),
        surround = false,
        update = "BufEnter",
      },
      status.component.breadcrumbs {
        hl = status.hl.get_attributes("winbar", true),
        prefix = true,
        padding = { left = 0 },
      },
    }
    return opts
  end,
}
