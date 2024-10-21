-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- 通过系统类型来选择nvim的终端，在linux优先选择zsh，如果没有则使用bash
if vim.fn.has("win32") == 1 then
  LazyVim.terminal.setup("pwsh")
elseif vim.fn.has("linux") then
  if vim.fn.executable("zsh") == 1 then
    LazyVim.terminal.setup("zsh")
  else
    LazyVim.terminal.setup("bash")
  end
end

-- 设置proto文件为proto类型(默认为protobuf，因未知原因不高亮显示)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.api",
  command = "set filetype=proto",
})
