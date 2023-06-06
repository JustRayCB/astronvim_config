return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",

  -- Themes
  -- Lazy loading should be disabled to make the themes selectible, `SPC f t`
  {
    "AstroNvim/astrotheme", -- default AstroNvim theme
    lazy = false,
  },
  { import = "astrocommunity.colorscheme.everforest" },
  {
    "sainnhe/everforest",
    lazy = false,
  },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        module_default = false,
        modules = {
          aerial = true,
          cmp = true,
          ["dap-ui"] = true,
          dashboard = true,
          diagnostic = true,
          gitsigns = true,
          native_lsp = true,
          neotree = true,
          notify = true,
          symbol_outline = true,
          telescope = true,
          treesitter = true,
          whichkey = true,
        },
      },
      groups = { all = { NormalFloat = { link = "Normal" } } },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
  },
  { import = "astrocommunity.colorscheme.github-nvim-theme" }, -- no background support
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
  },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
  },
  { import = "astrocommunity.colorscheme.catppuccin" },
  {
    "catppuccin/nvim",
    lazy = false,
  },
  { import = "astrocommunity.colorscheme.oxocarbon-nvim" },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
  },
  { import = "astrocommunity.colorscheme.rose-pine" },
  {
    "rose-pine/neovim",
    lazy = false,
  },

  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    -- Set colorscheme:
    -- github_dark github_dark_dimmed github_dark_high_contrast github_dark_colorblind github_dark_tritanopia
    -- github_light github_light_default github_light_colorblind github_light_tritanopia
    -- colorscheme = "github_dark_tritanopia",
    -- colorscheme = "github_light_tritanopia",
  },
}
