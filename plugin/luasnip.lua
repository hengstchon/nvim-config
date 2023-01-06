local ok, luasnip = pcall(require, "luasnip")
if not ok then
  print("Failed to load LuaSnip")
  return
end

luasnip.config.set_config({
  updateevents = 'TextChanged,TextChangedI',
  region_check_events = 'InsertEnter',
  delete_check_events = 'InsertLeave'
})

require('luasnip.loaders.from_vscode').lazy_load()
-- require('luasnip.loaders.from_vscode').lazy_load({
--   paths = { './snippets' },
-- })
