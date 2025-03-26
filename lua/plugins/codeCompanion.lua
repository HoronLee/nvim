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
        chat = { adapter = "deepseek" },
        inline = { adapter = "deepseek" },
        agent = { adapter = "deepseek" },
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
      },
      opts = {
        language = "Chinese",
        log_level = "debug",
      },
    },
  },
}
