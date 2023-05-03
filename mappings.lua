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
    ["<leader>ff"] = {
      function()
        require("telescope.builtin").find_files {
          prompt_title = "Fichiers",
          -- file_ignore_patterns = { "node_modules" },
          attach_mappings = function(_, map)
            map("i", "<CR>", function(prompt_bufnr)
              local picker = vim.fn.bufnr()
              local selection = require("telescope.actions.state").get_selected_entry()
              if selection ~= nil and vim.fn.filereadable(selection.path) == 1 then
                vim.notify "Fichier existant"
                require("telescope.actions").file_edit(picker)
              else
                vim.notify "Fichier non existant"
                vim.notify("Current directory: " .. vim.fn.getcwd())
                vim.cmd "lcd %:p:h"
                local current_picker = require("telescope.actions.state").get_current_picker(picker)
                local prompt = current_picker:_get_prompt()
                require("telescope.actions").close(picker)
                local cwd = vim.fn.getcwd()
                -- vim.notify("nom prompt : " .. prompt)
                local path = cwd .. "/" .. prompt
                local parent_dir = vim.fn.fnamemodify(path, ":h")
                if vim.fn.isdirectory(parent_dir) == 0 then
                  vim.notify("Création du dossier " .. parent_dir)
                  vim.fn.mkdir(parent_dir, "p")
                end
                vim.api.nvim_exec(":edit " .. cwd .. "/" .. prompt, false)
              end
              -- require("telescope.actions").close(picker)
            end)
            return true
          end,
        }
      end,
      desc = "Find files, open it if it exits, and create it if it doesn't (directory included)",
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
    ["<c-c>"] = { "y", desc = "Copy to clipboard" },
    ["a"] = { "<c-y>", desc = "Move the window one line up" },
    ["f"] = { "<c-e>", desc = "Move the window one line to the bottom" },
    ["m"] = { "w", desc = "one word to the left" },
    ["<leader><leader>="] = {
      "<cmd>vsp | Telescope find_files<cr>",
      desc = "Open a split tab and choose file with telescope",
    },
    ["<leader><leader>-"] = {
      "<cmd>sp | Telescope find_files<cr>",
      desc = "Open a split tab and choose file with telescope",
    },
    ["<leader><leader>g"] = { "<cmd>vsp | Telescope git_files<cr>", desc = "Open split pane with telescope git" },
    ["<F5>"] = { ":call vimspector#Launch()<cr>", desc = "debug session" },
    ["<leader><leader>w"] = {
      function()
        -- vim.cmd "cd $(git rev-parse —show-toplevel)"
        local client = vim.lsp.get_active_clients()[1]
        if client ~= nil then
          -- vim.notify("Current directory: " .. client.config.root_dir)
          vim.cmd("cd " .. client.config.root_dir)
        else
          vim.cmd("cd " .. vim.fn.getcwd())
        end
        require("telescope.builtin").find_files {
          prompt_title = "Fichiers",
          attach_mappings = function(_, map)
            map("i", "<CR>", function()
              local picker = vim.fn.bufnr()
              local selection = require("telescope.actions.state").get_selected_entry()
              vim.fn.execute("silent !wslview " .. selection.path)
              require("telescope.actions").close(picker)
            end)
            return true
          end,
        }
      end,
      desc = "Open file with wslview",
    },
    ["<leader>fu"] = { "<cmd>Telescope lsp_document_symbols<cr>", desc = "Telescope for all functions" },
    ["<leader>sa"] = { "<cmd>au! CursorHoldI,CursorHold,BufLeave <buffer> silent w<CR>", desc = "Autosave" },
    ["<F2>"] = { "<cmd>OverseerRun<cr>", desc = "Run a file" },
  },

  -- Terminal mode
  t = {
    -- setting a mapping to false will disable it
    ["<esc>"] = false,
    -- ["i"] = {"<C-\\><C-n>", desc = "Switch to normal mode"},
    -- ["j"] = {"<C-\\><C-n><C-d>", desc = "Scroll up"},
    ["j"] = { "<C-\\><C-n>j", desc = "Scroll up" },
    ["k"] = { "<C-\\><C-n>k", desc = "Scroll down" },
  },

  -- Visual mode
  v = {
    ["<leader>c"] = false,
    ["<leader><leader>c"] = {
      "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
      desc = "Toggle comment line",
    },
    ["y"] = { "ygv<esc>", desc = "Make the cursor not move after yank" },
    ["<c-c>"] = { "y", desc = "Copy to clipboard" },
    ["m"] = { "w", desc = "one word to the left" },
    ["<"] = { "<gv^", desc = "Keep visual mode after Indent left" },
    [">"] = { ">gv^", desc = "Keep visual mode after Indent right" },
  },
  i = {},
}
