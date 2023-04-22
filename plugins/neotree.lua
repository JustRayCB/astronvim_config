return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.source_selector = {
      winbar = true, -- toggle to show selector on winbar
      statusline = false,
      sources = {
        { source = "filesystem" },
        { source = "buffers" },
        { source = "git_status" },
      },
    }
    return opts
  end,
}
