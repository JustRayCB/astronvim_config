return function ()
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
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

    vim.api.nvim_create_autocmd({ "BufNewFile *java", "BufNewFile *py" }, {
      desc = "Load java linter when new file",
      pattern = { "*.java", "*.py" },
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
end
