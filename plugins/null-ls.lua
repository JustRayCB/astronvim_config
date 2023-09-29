return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.prettier,
      -- require("null-ls").builtins.diagnostics.sqlfluff.with {
      --   extra_args = { "--dialect", "mysql" }, -- change to your dialect
      --   filetypes = { "sql", "mysql" },
      -- },
      null_ls.builtins.formatting.clang_format.with{
        filetypes = {"java"},
      },
      -- null_ls.builtins.diagnostics.mypy.with {
      --   extra_args = { "--check-untyped-defs", "--ignore-missing-imports", "--install-types"},
      --   -- --non-interactive
      --   filetypes = { "python" },
      --   -- method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      --   -- timeout = 500,
      -- },

      null_ls.builtins.diagnostics.pydocstyle.with {
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        timeout = 750,
      },

      -- require("null-ls").builtins.diagnostics.pylint.with {
      --   method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      -- },
        -- require("null_ls").builtins.diagnostics.pylint.with({
        --   method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        -- }),

      -- require("null-ls").builtins.completion.luasnip.with {
      --   filetypes = { "mysql", "sql", "python" },
      -- },
    }
    return config -- return final config table
  end,
}
