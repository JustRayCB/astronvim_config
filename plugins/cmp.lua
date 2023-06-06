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
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --   if luasnip.jumpable(1) then
        --     luasnip.jump(1)
        --   elseif cmp.visible() and has_words_before() then
        --     cmp.confirm { select = true }
        --   else
        --     fallback()
        --   end
        -- -- end, { "i", "s" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        -- ["<Tab>"] = function(fallback)
        --   -- if cmp.visible() then
        --   --   cmp.select_next_item()
        --   if luasnip.expand_or_jumpable() then
        --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        --   else
        --     fallback()
        --   end
        -- end,
        -- ["<S-Tab>"] = function(fallback)
        --   -- if cmp.visible() then
        --   --   cmp.select_prev_item()
        --   if luasnip.jumpable(-1) then
        --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
        --   else
        --     fallback()
        --   end
        -- end,
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select }, -- to fix the c-j not working since update 2/05/23
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        -- ["<C-Space>"] = cmp.mapping.complete(),
        -- ["<C-e>"] = cmp.mapping.close(),
        -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
        -- ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
      },
    })
  end,
}
