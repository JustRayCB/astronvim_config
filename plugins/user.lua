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
    init = function ()
      vim.g.vimspector_enable_mappings = 'HUMAN'
      vim.g.vimspector_sidebar_width = 35
      vim.g.vimspector_code_minwidth = 70
      vim.g.vimspector_breakpoint_symbols_enabled = 0
      -- Disable noice before launching 
      -- vim.api.nvim_set_keymap("n", "<leader>lla", "<cmd>call vimspector#Launch() | NoiceDisable<CR>", { noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<leader>lla", ":call vimspector#Launch()<CR>", { noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<leader>dx", ":call vimspector#Reset()<CR>", { noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<leader><leader>so", ":call vimspector#StepOut()<CR>", { noremap = true , silent = true})
      vim.api.nvim_set_keymap("n", "<leader>si", ":call vimspector#StepInto()<CR>", { noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<leader>so", ":call vimspector#StepOver()<CR>", { noremap = true , silent = true})
      vim.api.nvim_set_keymap("n", "<leader>d_", ":call vimspector#Restart()<CR>", { noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<leader>co", ":call vimspector#Continue()<CR>", { noremap = true , silent = true})
      vim.api.nvim_set_keymap("n", "<leader>drc", ":call vimspector#RunToCursor()<CR>", { noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<leader>bp", ":call vimspector#ToggleBreakpoint()<CR>", { noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<leader>df", ":call vimspector#ToggleConditionalBreakpoint()<CR>", { noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<leader>nb", ":call vimspector#JumpToNextBreakpoint()<CR>", { noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<leader>de", ":VimspectorEval", { noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<leader>dw", ":VimspectorWatch", { noremap = true , silent = true})
      vim.api.nvim_set_keymap("n", "<leader>>do", ":VimspectorShowOutput", { noremap = true , silent = true})
      vim.api.nvim_set_keymap("n", "<leader>di", "<Plug>VimspectorBalloonEval", { noremap = true , silent = true})
      vim.api.nvim_set_keymap("x", "<leader>di", "<Plug>VimspectorBalloonEval", { noremap = true , silent = true})
    end
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
  {
    "mg979/vim-visual-multi",
    lazy = false,
    init = function ()
      vim.g.VM_mouse_mappings = true
    end
  }
}
