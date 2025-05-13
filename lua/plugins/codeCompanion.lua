return {
  {
    "olimorris/codecompanion.nvim",
    config = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      strategies = {
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
        agent = { adapter = "copilot" },
      },
      adapters = {
        deepseek = function()
          return require("codecompanion.adapters").extend("deepseek", {
            name = "deepseek",
            env = {
              api_key = function()
                return os.getenv("DEEPSEEK_API_KEY")
              end,
            },
            schema = {
              model = {
                default = "deepseek-chat",
              },
            },
          })
        end,

        siliconflow_r1 = function()
          return require("codecompanion.adapters").extend("deepseek", {
            name = "siliconflow_r1",
            url = "https://api.siliconflow.cn/v1/chat/completions",
            env = {
              api_key = function()
                return os.getenv("DEEPSEEK_API_KEY_S")
              end,
            },
            schema = {
              model = {
                default = "deepseek-ai/DeepSeek-R1",
                choices = {
                  ["deepseek-ai/DeepSeek-R1"] = { opts = { can_reason = true } },
                  "deepseek-ai/DeepSeek-V3",
                },
              },
            },
          })
        end,

        siliconflow_v3 = function()
          return require("codecompanion.adapters").extend("deepseek", {
            name = "siliconflow_v3",
            url = "https://api.siliconflow.cn/v1/chat/completions",
            env = {
              api_key = function()
                return os.getenv("DEEPSEEK_API_KEY_S")
              end,
            },
            schema = {
              model = {
                default = "deepseek-ai/DeepSeek-V3",
                choices = {
                  "deepseek-ai/DeepSeek-V3",
                  ["deepseek-ai/DeepSeek-R1"] = { opts = { can_reason = true } },
                },
              },
            },
          })
        end,
      },
      opts = {
        language = "Chinese",
        log_level = "debug",
      },
    },
  },
}
