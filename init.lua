return {
  -- Configure AstroNvim updates
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
  colorscheme = "tokyonight-moon",
  -- colorscheme = "astrotheme",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
    update_in_insert = false,
  },
  lsp = {
    -- customize lsp formatting options
    diagnostics = { -- configure formatting diagnostics
      virtual_text = false, -- show virtual diagnostics
      underline = true, -- show underline diagnostics
    },
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
          -- "java",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
          "sql",
          "mysql",
          -- "java",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        "lua_ls", -- Have to disable it because if I save before the workspace is loaded there is a conflict
        "null-ls",
        "jdtls", -- Otherwise ther is a conflict with clang_format
        -- "clang_format",
        "sqlfluff",
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
        cmd = {
          "clangd",
          "--background-index",
          "--suggest-missing-includes",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--fallback-style=Chromium",
        },
        init_options = {
          clangdFileStatus = true,
          usePlaceholders = true,
          completeUnimported = true,
        },
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
    vim.filetype.add {
      -- extension = {
      --   foo = "fooscript",
      -- },
      -- filename = {
      --   ["Foofile"] = "fooscript",
      -- },
      -- pattern = {
      --   ["~/%.config/foo/.*"] = "fooscript",
      -- },
      sql = "mysql"
    }
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

    vim.api.nvim_create_autocmd("VimEnter *.tex", {
      desc = "Compile tex file on opening",
      pattern = "*.tex",
      command = "VimtexCompile",
    })
    -- vim.api.nvim_create_autocmd("BufEnter *.md", {
    --   desc = "Preview markdown file on opening",
    --   pattern = {
    --     "*.md",
    --     "*.markdown",
    --     "*.mdown",
    --     "*.mkdn",
    --     "*.mkd",
    --     "*.mdwn",
    --     "*.mdtxt",
    --     "*.mdtext",
    --     "*.text",
    --     "*.Rmd",
    --   },
    --   command = "MarkdownPreview",
    -- })
    -- vim.api.nvim_create_autocmd("BufEnter *.uml", {
    --   desc = "Preview plantuml file on opening",
    --   pattern = { "*.uml", "*.plantuml", "*.puml" },
    --   command = "silent! PlantumlOpen",
    -- })

    vim.api.nvim_create_autocmd("BufEnter *.uml", {
      desc = "Set filetype to plantuml",
      pattern = { "*.uml", "*.plantuml", "*.puml" },
      command = "set ft=plantuml",
    })

    -- vim.api.nvim_create_autocmd({ "BufEnter *.mysql", "BufNewFile *.mysql" }, {
    --   desc = "Set filetype to plantuml",
    --   pattern = { "*.mysql" },
    --   command = "set ft=sql",
    -- })

    vim.api.nvim_create_autocmd({ "BufNewFile *", "BufNew *" }, {
      desc = "Set filetype to sql",
      pattern = { "*" },
      -- command = "if &filetype == 'mysql' | echo 'salut' | endif",
      command = "if &filetype == 'mysql' | set ft=sql |endif",
    })

    vim.api.nvim_create_autocmd({ "BufLeave *.tex", "VimLeave *.tex" }, {
      desc = "Move .pdf to main folder",
      pattern = "*.tex",
      command = "silent !mv build/*.pdf .",
    })

    -- vim.api.nvim_create_autocmd({ "BufWritePost *.java", "BufWritePost *. cpp" }, {
    --   desc = "Format java/cpp file on save",
    --   pattern = { "*.java", "*.cpp" },
    --   command = "silent! !clang-format -i %",
    -- })
    
    vim.api.nvim_create_autocmd({ "BufWritePost *.java" }, {
      desc = "Format java file on save",
      pattern = "*.java",
      command = "silent! !clang-format -i %",
    })
    
    vim.api.nvim_create_autocmd({ "BufWritePost *.py" }, {
      desc = "Format python file on save",
      pattern = "*.py",
      command = "silent! !black --include pyproject.toml %",
    })
  end,
}
