local ok, colorizer = pcall(require, "colorizer")
if not ok then
  print("Failed to load nvim-colorizer.lua")
  return
end

colorizer.setup(nil, { css = true })