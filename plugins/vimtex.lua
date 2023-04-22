return {
  "lervag/vimtex",
  lazy = true,
  ft = { "tex" },
  event = {"VimEnter *.tex"},
  config = function()
    -- vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_view_general_viewer = "/mnt/c/Users/Craya/AppData/Local/SumatraPDF/SumatraPDF.exe"
    vim.g.tex_flavor = "latex"
    vim.g.Tex_DefaultTargetFormat = "pdf"
    vim.g.Tex_ViewRule_pdf='sumatraPDF'
    vim.g.vimtex_quickfix_mode = 0
    -- let g:vimtex_compiler_latexmk = {
    --         \ 'build_dir' : '',
    --         \ 'callback' : 1,
    --         \ 'continuous' : 1,
    --         \ 'executable' : 'latexmk',
    --         \ 'hooks' : [],
    --         \ 'options' : [
    --         \   '-verbose',
    --         \   '-file-line-error',
    --         \   '-synctex=1',
    --         \   '-interaction=nonstopmode',
    --         \   '-shell-escape',
    --         \ ],
    --         \}
    vim.g.vimtex_compiler_latexmk = {
      -- build_dir = "build",
      -- continuous = 1,
      -- callback = 1,
      -- executable = "latexmk",
      -- options = {
      --   "-pdf",
      --   "-interaction=nonstopmode",
      --   "-synctex=1",
      --   "-file-line-error",
      --   "-outdir=build",
      -- },
      build_dir = "",
      callback = 1,
      continuous = 1,
      executable = "latexmk",
      hooks = {},
      options = {
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-shell-escape",
      },
    }
  end,
}
