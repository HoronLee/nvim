-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- 用 hop 接管 f/F/t/T，并强制使用 INLINE hint，避免 OVERLAY 在当前主题下不明显。
local function hop_char1(direction_name, hint_offset)
  return function()
    local hop = require("hop")
    local hint = require("hop.hint")
    local direction = direction_name == "after" and hint.HintDirection.AFTER_CURSOR or hint.HintDirection.BEFORE_CURSOR

    hop.hint_char1({
      direction = direction,
      hint_offset = hint_offset,
      hint_type = hint.HintType.INLINE,
    })
  end
end

-- f/F 落在目标字符上；t/T 分别停在目标字符前/后一格。
vim.keymap.set({ "n", "x", "o" }, "f", hop_char1("after"), { desc = "Hop after char" })
vim.keymap.set({ "n", "x", "o" }, "F", hop_char1("before"), { desc = "Hop before char" })
vim.keymap.set({ "n", "x", "o" }, "t", hop_char1("after", -1), { desc = "Hop before target char" })
vim.keymap.set({ "n", "x", "o" }, "T", hop_char1("before", 1), { desc = "Hop after target char" })

-- 普通模式下 H 移动到行首，L 移动到行尾
-- vim.keymap.set("n", "H", "0", { noremap = true })
-- vim.keymap.set("n", "L", "$", { noremap = true })
