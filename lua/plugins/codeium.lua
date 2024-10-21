return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  config = function()
    -- 自定义codeium快捷键，不使用tab接受建议而是用Ctrl+g
    vim.g.codeium_no_map_tab = 1
    vim.keymap.set("i", "<C-g>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, silent = true })
  end,
}
