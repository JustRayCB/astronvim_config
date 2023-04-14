return {
  "nvim-telescope/telescope.nvim",
  -- opts = function(_, opts)
  --   local telescope = require "telescope"
  --   telescope.load_extension "file_browser"
  --   return opts
  -- end,
  opts = function(_, opts)
    local telescope = require "telescope"
    local actions = require "telescope.actions"
    local fb_actions = require("telescope").extensions.file_browser.actions
    return require("astronvim.utils").extend_tbl(opts, {
      extensions = {
        file_browser = {
          mappings = {
            i = {},
            n = {},
          },
        },
      },
    })
  end,
  config = function(...)
    require "plugins.configs.telescope"(...)
    local telescope = require "telescope"
    telescope.load_extension "file_browser"
  end,
}
