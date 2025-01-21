return {
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      -- 配置 Everforest 主题
      vim.g.everforest_enable_italic = true
      vim.cmd.colorscheme("everforest") -- 设置 Everforest 作为默认主题
    end,
  },
  {
    "morhetz/gruvbox",
    lazy = true, -- 延迟加载 Grubox，可以根据需要手动加载
    config = function()
      vim.cmd.colorscheme("gruvbox") -- 设置 Gruvbox 作为主题
    end,
  },
}
