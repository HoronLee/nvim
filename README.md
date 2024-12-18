# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## 目前自定义内容

1. catppuccin主题自定义，不使用默认TokyoNight主题`plugins/colorscheme.lua`
2. 添加关于终端自动选择的逻辑`config/options.lua`
3. 添加codium插件，并自定义快捷键`plugins/codeium.lua`
4. 添加自定义仓库源功能，解决无梯拉不到插件的问题(暂时放弃，不稳定)`config/lazy.lua`
5. 添加 goctl 支持插件（.api），但是目前无法使用，待解决`plugins/goctl.lua`
6. 添加行内显示优化插件`plugins/tiDiagnostic.lua`
   1. 为配合此插件，需要在 LSP 配置完成之前关闭自带的行内显示`config/autocmds.lua`
7. 解决ArchLinux WSL环境下无法和windows互通剪切板的问题`config/autocmds.lua`
