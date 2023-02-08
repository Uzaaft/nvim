return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    opts.tabline[2] =
      astronvim.status.heirline.make_buflist(astronvim.status.component.tabline_file_info { close_button = false })

    opts.winbar[3] = {
      astronvim.status.component.file_info { -- add file_info to breadcrumbs
        unique_path = {},
        file_icon = { hl = astronvim.status.hl.file_icon "winbar" },
        file_modified = false,
        file_read_only = false,
        hl = astronvim.status.hl.get_attributes("winbar", true),
        surround = false,
        update = "BufEnter",
      },
      opts.winbar[3],
    }
    return opts
  end,
}
