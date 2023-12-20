-- ========================================================================
-- MOST CODE TAKEN FROM OIL.NVIM AND THE AMAZING WORK OF STEVEARC
-- https://github.com/stevearc/oil.nvim/blob/master/lua/oil/lsp_helpers.lua
-- ========================================================================
local is_windows = (vim.uv or vim.loop).os_uname().version:match "Windows"

local function is_absolute(dir)
  if is_windows then
    return dir:match "^%a:\\"
  else
    return vim.startswith(dir, "/")
  end
end

local function abspath(path) return is_absolute(path) and path or vim.fn.fnamemodify(path, ":p") end

local function is_subpath(root, candidate)
  if candidate == "" then return false end
  root = vim.fs.normalize(abspath(root))
  -- Trim trailing "/" from the root
  if root:find("/", -1) then root = root:sub(1, -2) end
  candidate = vim.fs.normalize(abspath(candidate))
  if is_windows then
    root = root:lower()
    candidate = candidate:lower()
  end
  if root == candidate then return true end
  local prefix = candidate:sub(1, root:len())
  if prefix ~= root then return false end

  local candidate_starts_with_sep = candidate:find("/", root:len() + 1, true) == root:len() + 1
  local root_ends_with_sep = root:find("/", root:len(), true) == root:len()

  return candidate_starts_with_sep or root_ends_with_sep
end

local function file_matches(filepath, pattern)
  local is_dir = vim.fn.isdirectory(filepath) == 1
  if pattern.matches and ((pattern.matches == "file" and is_dir) or (pattern.matches == "folder" and not is_dir)) then
    return false
  end

  if vim.lsp._watchfiles then
    local glob = pattern.glob
    local path = filepath
    if vim.tbl_get(pattern, "options", "ignoreCase") then
      glob, path = glob:lower(), path:lower()
    end
    return vim.lsp._watchfiles._match(glob, path)
  end

  local pat = vim.fn.glob2regpat(pattern.glob)
  if vim.tbl_get(pattern, "options", "ignoreCase") then pat = "\\c" .. pat end

  local ignorecase = vim.o.ignorecase
  vim.o.ignorecase = false
  local match = vim.fn.match(filepath, pat) >= 0
  vim.o.ignorecase = ignorecase
  return match
end

local function any_match(filepath, filters)
  for _, filter in ipairs(filters) do
    local scheme_match = not filter.scheme or filter.scheme == "file"
    if scheme_match and file_matches(filepath, filter.pattern) then return true end
  end
  return false
end

local function is_matching_path(client, path_pair)
  local ret
  local filters = vim.tbl_get(client.server_capabilities, "workspace", "fileOperations", "willRename", "filters")
  if filters and is_subpath(client.config.root_dir, path_pair.source) then
    local relative_file = path_pair.source:sub(client.config.root_dir:len() + 2)
    if any_match(path_pair.source, filters) or any_match(relative_file, filters) then ret = path_pair end
  end
  return ret
end

local lsp_rename = function(args)
  local clients = (vim.lsp.get_clients or vim.lsp.get_active_clients)()
  for _, client in ipairs(clients) do
    if is_matching_path(client, args) then
      client.request("workspace/willRenameFiles", {
        files = {
          {
            oldUri = vim.uri_from_fname(args.source),
            newUri = vim.uri_from_fname(args.destination),
          },
        },
      }, function(_, result)
        if result then vim.lsp.util.apply_workspace_edit(result, client.offset_encoding) end
      end)
    end
  end
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    local events = require "neo-tree.events"

    if not opts.event_handlers then opts.event_handlers = {} end
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_RENAMED, handler = lsp_rename },
      { event = events.FILE_MOVED, handler = lsp_rename },
    })
  end,
}
