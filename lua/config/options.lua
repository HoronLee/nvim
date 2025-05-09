-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- 通过系统类型来选择nvim的终端，在linux优先选择zsh，如果没有则使用bash
if vim.fn.has("win32") == 1 then
  LazyVim.terminal.setup("pwsh")
elseif vim.fn.has("unix") == 1 then
  local shell = vim.fn.executable("fish") == 1 and "fish" or vim.fn.executable("zsh") == 1 and "zsh" or "bash"
  LazyVim.terminal.setup(shell)
end
