return {
  "rcarriga/nvim-notify",
  opts = function(_, opts)
    local notify = require "notify"
    local config = {
      -- stages = "fade_in_slide_out",
      stages = "slide",
      timeout = 1000,
      -- background_colour = "#1e222a",
      -- background_colour = "#000000",
      icons = {
        ERROR = " ",
        WARN = " ",
        INFO = " ",
        DEBUG = " ",
        TRACE = " ",
      },
    }
    notify.setup(config)
    return require("astronvim.utils").extend_tbl(opts, {
      config = config,
    })
  end,
}
