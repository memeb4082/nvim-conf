return {
  {
    "lervag/vimtex",
    ft = { "tex", "bib" },
    init = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_indent_enabled = 1
      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_fold_enabled = 1
      vim.g.vimtex_complete_enabled = 1
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-pdf",
          "-shell-escape",
          "-interaction=nonstopmode",
          "-synctex=1",
        },
      }
    end,
  },
}
