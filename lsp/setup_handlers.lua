local function lsp_plugin_setup(plugin, server, opts)
  local lsp_plugin_avail, _ = pcall(require, plugin)
  if not lsp_plugin_avail then require("lspconfig")[server].setup(opts) end
end

return {
  tsserver = function(...) lsp_plugin_setup("typescript", ...) end,
  clangd = function(...) lsp_plugin_setup("clangd_extensions", ...) end,
}
