return {
    -- customize lsp formatting options
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
}
