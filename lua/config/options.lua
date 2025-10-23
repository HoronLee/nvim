-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- 通过系统类型来选择 nvim 的终端，在linux优先选择 fish ，如果没有则使用 zsh 或者 bash
if vim.fn.has("win32") == 1 then
  LazyVim.terminal.setup("pwsh")
elseif vim.fn.has("unix") == 1 then
  local shell = vim.fn.executable("fish") == 1 and "fish" or vim.fn.executable("zsh") == 1 and "zsh" or "bash"
  LazyVim.terminal.setup(shell)
end

-- 设置自动换行
vim.opt.wrap = true
vim.opt.linebreak = true

-- neovide 设置
if vim.g.neovide then
  -- 字体
  vim.o.guifont = "Maple Mono NF CN:h14"
  -- 背景颜色
  -- Helper function for transparency formatting
  -- local alpha = function()
  --   return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  -- end
  -- g:neovide_opacity should be 0 if you want to unify transparency of content and title bar.
  -- 窗口透明度
  vim.g.neovide_opacity = 0.3
  vim.g.transparency = 0.8
  -- vim.g.neovide_background_color = alpha()
  -- 窗口模糊
  vim.g.neovide_window_blurred = true
  -- 悬浮阴影
  -- vim.g.neovide_floating_shadow = true
  -- vim.g.neovide_floating_z_height = 10
  -- vim.g.neovide_light_angle_degrees = 45
  -- vim.g.neovide_light_radius = 5
  -- 显示边框
  vim.g.neovide_show_border = true
  -- 主题 自动切换
  vim.g.neovide_theme = "auto"
  -- 空闲刷新率
  vim.g.neovide_refresh_rate_idle = 5
  -- 全屏
  -- vim.g.neovide_fullscreen = true
  -- 简单全屏
  -- vim.g.neovide_macos_simple_fullscreen = true
  -- 记住上一个窗口大小
  vim.g.neovide_remember_window_size = true
  -- 分析器表盘
  vim.g.neovide_profiler = false
end
