local ok, autopairs = pcall(require, 'nvim-autopairs')
if not ok then
    print("Failed to load nvim-autopairs")
    return
end

autopairs.setup()
