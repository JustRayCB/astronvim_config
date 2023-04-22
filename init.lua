return {
  -- Configure AstroNvim updates
  -- FIX: TELESCOPE DOES NOT WORK WITH PYTHON3.11
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  colorscheme = "tokyonight",
  -- colorscheme = "catppuccin",
  -- colorscheme = "oxocarbon",
  -- colorscheme = "rose-pine",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        "lua_ls", -- Have to disable it because if I save before the workspace is loaded there is a conflict
        "null-ls",
        -- "jdtls", -- Otherwise ther is a conflict with clang_format
        -- "clang_format"
      },
      timeout_ms = 3200, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    config = {
      clangd = {
        capabilities = { offsetEncoding = "utf-8" },
      },
    },
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
    -- vim.api.nvim_create_autocmd("BufEnter *.py", {
    --   desc = "Execute python File while pressing F2",
    --   pattern = "python",
    --   command = "<cmd>w<cr><cmd>exec '!python3' shellescape(@%, 1)<cr>",
    --   command = "<cmd>w<cr><cmd>exec '!python3' %<cr>",
    --   -- keys = "<F2>",
    -- })
    vim.api.nvim_create_autocmd("User AstroFiletype", {
      desc = "Hightlight colorcolumn",
      pattern = "*",
      command = "highlight ColorColumn guibg=Red",
    })
    vim.api.nvim_create_augroup("Templates", {})
    vim.api.nvim_create_autocmd("BufNewFile *.cpp", {
      desc = "Set template for cpp files",
      pattern = "*.cpp",
      group = "Templates",
      command = "0r ~/.vim/templates/skeleton.cpp",
    })

    vim.api.nvim_create_augroup("Execute", {})
    vim.api.nvim_create_autocmd("BufEnter *.py", {
      desc = "Exectue python program",
      pattern = "*.py",
      group = "Execute",
      command = "map <buffer> <F2> :w <CR>: exec '!python3' shellescape(@%, 1) <CR>",
      -- command = function()
      -- vim.api.nvim_buf_set_keymap(0, "n", "<F2>", ":w <CR>: exec '!python3' shellescape(@%, 1) <CR>", { noremap = true, silent = true })
      -- vim.api.nvim_buf_set_keymap(0, "n", "<F2>", ":w <CR>: exec '!python3' % <CR>", { noremap = true, silent = true }
      --   vim.api.nvim_buf_set_keymap(
      --     0,
      --     "n",
      --     "<F2>",
      --     ":w <CR>: exec '!python3' % <CR>",
      --     { noremap = true, silent = true }
      --   )
      -- end,
    })

    vim.api.nvim_create_autocmd("BufEnter *.cpp", {
      desc = "Exectue cpp program",
      pattern = "*.cpp",
      group = "Execute",
      -- command = "map <buffer> <F2> :w <CR>: exec '!python3' shellescape(@%, 1) <CR>",
      command = "map <buffer> <F2> :w <CR> :!g++ -std=c++20 -Wall -Wextra -pedantic % -o %< && ./%<<CR>",
      -- command = function()
      -- vim.api.nvim_buf_set_keymap(0, "n", "<F2>", ":w <CR>: exec '!python3' shellescape(@%, 1) <CR>", { noremap = true, silent = true })
      -- vim.api.nvim_buf_set_keymap(0, "n", "<F2>", ":w <CR>: exec '!python3' % <CR>", { noremap = true, silent = true }
      --   vim.api.nvim_buf_set_keymap(
      --     0,
      --     "n",
      --     "<F2>",
      --     ":w <CR>: exec '!python3' % <CR>",
      --     { noremap = true, silent = true }
      --   )
      -- end,
    })

    vim.api.nvim_create_autocmd("User AstroFile", {
      desc = "no auto comment after pressing o",
      pattern = "*",
      command = "setlocal formatoptions-=o",
    })

    vim.api.nvim_create_autocmd("BufNewFile *java", {
      desc = "Load java linter when new file",
      pattern = "*.java",
      command = "execute 'normal! i' | write | edit | execute 'normal! gg=G'",
    })

    vim.api.nvim_create_autocmd("VimEnter *.tex",{
      desc = "Compile tex file on opening",
      pattern = "*.tex",
      command = "VimtexCompile",
    })
    vim.api.nvim_create_autocmd("VimEnter *.md",{
      -- autocmd VimEnter *.md,*.markdown,*.mdown,*.mkdn,*.mkd,*.mdwn,*.mdtxt,*.mdtext,*.text,*.Rmd :MarkdownPreview
      desc = "Compile tex file on opening",
      pattern = {"*.md", "*.markdown", "*.mdown", "*.mkdn", "*.mkd", "*.mdwn", "*.mdtxt", "*.mdtext", "*.text", "*.Rmd"},
      command = "MarkdownPreview",
    })
    vim.api.nvim_create_autocmd("VimEnter *.uml",{
      desc = "Preview plantuml file on opening",
      pattern = {"*.uml", "*.plantuml", "*.puml"},
      command = "silent! PlantumlOpen",
    })
    
    vim.api.nvim_create_autocmd("VimEnter *.uml",{
      desc = "Preview plantuml file on opening",
      pattern = {"*.uml", "*.plantuml", "*.puml"},
      command = "set ft=plantuml",
    })
  end,
}
