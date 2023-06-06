return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
    -- opts = {},
    event = { "User AstroFile" },
    cmd = { "TodoQuickFix" },
    keys = {
      { "<leader>T", "<cmd>TodoTelescope<cr>", desc = "Open TODOs with Telescope" },
    },
  },
  {
    "puremourning/vimspector",
    ft = { "python", "py", "cpp", "c", "java" },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest featuress
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Confijuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "f-person/git-blame.nvim",
    event = "User AstroGitFile",
    init = function() vim.g.gitblame_enabled = false end,
  },
  {
    "alec-gibson/nvim-tetris",
    cmd = { "Tetris" },
  },
}
