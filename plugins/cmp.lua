return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
    "jc-doyle/cmp-pandoc-references",
    "kdheepak/cmp-latex-symbols",
  },
  opts = function(_, opts)
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    local function has_words_before()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end
    local function check_backspace()
      local col = vim.fn.col "." - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match "%s" ~= nil
    end
    luasnip.config.set_config({ -- To fix the issue of tab jumping around "randomly"
      region_check_events = 'InsertEnter',
      delete_check_events = 'InsertLeave',
      -- update_events = {"TextChanged", "TextChangedI"}
      
    })
    return require("astronvim.utils").extend_tbl(opts, {
      window = {
        completion = {
          border = "rounded",
          col_offset = -1,
          side_padding = 0,
        },
      },
      sources = cmp.config.sources {
        { name = "luasnip", priority = 1750 },
        { name = "nvim_lsp", priority = 1000 },
        { name = "vim-dadbod-completion", priority = 800 },
        { name = "pandoc_references", priority = 725 },
        { name = "latex_symbols", priority = 700 },
        { name = "emoji", priority = 700 },
        { name = "calc", priority = 650 },
        { name = "path", priority = 500 },
        { name = "buffer", priority = 250 },
      },
      mapping = {
        ["<CR>"] = cmp.mapping.confirm { select = true },
        -- Mapping both "confirm" and "jump" to <Tab> while keeping default behavior as fallback
        ["<Tab>"] = cmp.mapping(function(fallback)
            -- if cmp.visible() then
            --     cmp.confirm { select = true }
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            -- elseif check_backspace() then
            --     fallback()
            else
                fallback()
            end
        end, {
                "i",
                "s",
            }),
        ["<C-p>"] = cmp.mapping(function()
          if luasnip.jumpable(-1) then luasnip.jump(-1) end
        end, { "i", "s" }),
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }, -- to fix the c-j not working since update 2/05/23
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
      },
    })
  end,
}
