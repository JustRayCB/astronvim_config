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
        -- ["<C-J>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }, -- to fix the c-j not working since update 2/05/23
        -- ["<c-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
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
