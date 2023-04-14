return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    local telescope = require "telescope"
    telescope.load_extension "file_browser"
    return opts
  end,
}
