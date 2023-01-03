local ok, surround = pcall(require, 'nvim-surround')
if not ok then
  print("Failed to load nvim-surround.lua")
  return
end

surround.setup()
