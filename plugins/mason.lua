-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "lua_ls",
        "jedi_language_server",
        -- "pyright",
        "jdtls",
        "clangd",
        "sqlls",
      },
      automatic_installation = true,
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "stylua",
        -- "pylint",
        -- "pydocstyle",
        -- "black",
        -- "clang-format",
        -- "prettier",
        "latexindent",
        "markdown-toc",
        "markdownlint",
        "sqlfmt",
      },
      automatic_installation = true,
      automatic_setup = true,
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = {
        "python",
        "javadbg",
        "cpptools",
        "codelldb",
        "debugpy",
        "java-debug-adapter",
        "java-test",
      },
      automatic_setup = true,
      automatic_installation = true,
    },
  },
}
