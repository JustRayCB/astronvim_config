-- TODO: Just testing
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
    "stevearc/overseer.nvim",
    config = function()
      require("overseer").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    event = { "User AstroFile" },
  },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function()
  --     require("copilot").setup {
  --       panel = {
  --         enabled = true,
  --         auto_refresh = false,
  --         keymap = {
  --           jump_prev = "[[",
  --           jump_next = "]]",
  --           accept = "<CR>",
  --           refresh = "gr",
  --           open = "<M-CR>",
  --         },
  --         layout = {
  --           position = "bottom", -- | top | left | right
  --           ratio = 0.4,
  --         },
  --       },
  --       suggestion = {
  --         enabled = true,
  --         auto_trigger = false,
  --         debounce = 75,
  --         keymap = {
  --           accept = "<M-l>",
  --           accept_word = false,
  --           accept_line = false,
  --           next = "<M-]>",
  --           prev = "<M-[>",
  --           dismiss = "<C-]>",
  --         },
  --       },
  --       filetypes = {
  --         yaml = false,
  --         markdown = false,
  --         help = false,
  --         -- gitcommit = false,
  --         -- gitrebase = false,
  --         hgcommit = false,
  --         svn = false,
  --         cvs = false,
  --         ["."] = false,
  --       },
  --       copilot_node_command = "node", -- Node.js version must be > 16.x
  --       server_opts_overrides = {},
  --     }
  --   end,
  -- },
  {
    "puremourning/vimspector",
    event = { "User AstroFile" },
  },
}
