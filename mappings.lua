-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  -- Normal mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    ["<leader>a"] = { "<cmd>echo 'Hello World !'<cr>", desc = "Say Hello World" },
    ["<leader><leader><leader>"] = { "ciw", desc = "Delete the word under the cursor" },
    ["<leader><leader>s"] = { "<cmd>1<cr>", desc = "Go to the first line of the file" },
    ["<leader><leader>e"] = { "<cmd>%<cr>", desc = "Go to the last line of the file" },
    ["<leader><leader>a"] = { "A", desc = "Go to the end of the line" },
    ["<leader><leader>i"] = { "I", desc = "Go to the beginning of the line" },

    -- Redefinition of astronvim command from the ../astronvim/mappings.lua
    ["<leader>c"] = false,
    ["<leader>cc"] = { function() require("astronvim.utils.buffer").close() end, desc = "Close buffer" },
    ["<leader>CC"] = { function() require("astronvim.utils.buffer").close(0, true) end, desc = "Force close buffer" },
    ["<leader><tab>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<leader><tab><tab>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    ["<leader>b-"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
          vim.cmd.split()
          vim.api.nvim_win_set_buf(0, bufnr)
        end)
      end,
      desc = "Horizontal split buffer from tabline",
    },
    ["<leader>b="] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
          vim.cmd.vsplit()
          vim.api.nvim_win_set_buf(0, bufnr)
        end)
      end,
      desc = "Vertical split buffer from tabline",
    },
    ["<leader><leader>c"] = {
      function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Comment line",
    },
    ["<leader><leader>t"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  },
  -- Terminal mode
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
    [":q"] = { "exit()" },
  },
  -- Visual mode
  v = {
    ["<leader>c"] = false,
    ["<leader><leader>c"] = {
      "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
      desc = "Toggle comment line",
    },
  },
  i = {},
}
