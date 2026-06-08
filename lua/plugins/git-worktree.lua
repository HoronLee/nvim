-- polarmutex/git-worktree.nvim 集成：在 LazyVim 中提供 git worktree 的创建/切换/删除
-- 拆成两个 spec 是因为 telescope 扩展和插件本体职责不同：本体负责 API+hook，telescope spec 负责 UI 入口
return {
  {
    "polarmutex/git-worktree.nvim",
    version = "^2", -- 锁定 v2 主版本，README 推荐写法，避免上游做大改时被动升级
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- 切换 worktree 后让当前 buffer 自动跟随到新路径下的同名文件
      -- 该插件默认不注册任何 hook，需手动启用此内置实现
      local Hooks = require("git-worktree.hooks")
      Hooks.register(Hooks.type.SWITCH, Hooks.builtins.update_current_buffer_on_switch)
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "polarmutex/git-worktree.nvim" },
    keys = {
      -- <leader>we: Worktree Explore —— 列出已有 worktree
      -- 默认回车切换；picker 内置 <M-c> 创建、<M-d> 删除、<C-f> 切换强制删除模式
      {
        "<leader>we",
        function()
          require("telescope").extensions.git_worktree.git_worktree()
        end,
        desc = "Worktree Explore",
      },
      -- <leader>wc: Worktree Create —— 选分支并新建 worktree
      -- 没用插件自带的 create_git_worktree picker，因为它会先调 switch_worktree(nil)，
      -- 在普通仓库下会把 cwd 改到 .git 目录，导致后续 telescope.git_branches 报
      -- "is not a git directory"。这里直接调 telescope 的 git_branches，再用底层 API 建 worktree。
      {
        "<leader>wc",
        function()
          require("telescope.builtin").git_branches({
            attach_mappings = function(prompt_bufnr)
              local actions = require("telescope.actions")
              local action_state = require("telescope.actions.state")
              actions.select_default:replace(function()
                local entry = action_state.get_selected_entry()
                local current_line = action_state.get_current_line()
                -- 优先用选中项；没选中时取输入框内容，便于直接打字创建新分支
                local branch = entry and entry.value or current_line
                actions.close(prompt_bufnr)
                if not branch or branch == "" then
                  vim.notify("No branch selected", vim.log.levels.WARN)
                  return
                end
                -- 远程分支形如 "remotes/origin/feat/x"：去掉 remote 前缀作为本地分支名，
                -- 同时把 / 替换成 _ 以便用作目录名
                local short = branch:gsub("^remotes/[^/]+/", ""):gsub("/", "_")
                local repo = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                local default_path = "../" .. repo .. "-" .. short
                vim.ui.input({ prompt = "Worktree path: ", default = default_path, completion = "file" }, function(path)
                  if not path or path == "" then return end
                  -- 如果选的是远程分支，提取 remote 名作为 upstream，让 git-worktree 自动 --track
                  local upstream = branch:match("^remotes/([^/]+)/") or nil
                  require("git-worktree").create_worktree(path, short, upstream)
                end)
              end)
              return true
            end,
          })
        end,
        desc = "Worktree Create",
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      -- pcall 防御：扩展未安装时不报错（例如首次启动尚未拉到插件）
      pcall(require("telescope").load_extension, "git_worktree")
    end,
  },
}
