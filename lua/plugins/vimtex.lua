--return {
--  {
--    "lervag/vimtex",
--    ft = { "tex", "bib" },
--    init = function()
--
--vim.g.vimtex_view_method = 'general'
--vim.g.vimtex_view_general_viewer = 'zathura'
--vim.g.vimtex_view_general_options = '@pdf'
--vim.g.vimtex_view_automatic = 1
----      vim.g.vimtex_view_method = "zathura"
--      vim.g.vimtex_quickfix_mode = 0
--      vim.g.vimtex_indent_enabled = 1
--      vim.g.vimtex_syntax_enabled = 1
--      vim.g.vimtex_fold_enabled = 1
--      vim.g.vimtex_complete_enabled = 1
--      vim.g.vimtex_compiler_latexmk_engines = {
--        _ = "-xelatex",
--      }
--      vim.g.vimtex_compiler_latexmk = {
--        options = {
--          "-pdflatex",
--          "-shell-escape",
--          "-interaction=nonstopmode",
--          "-synctex=1",
--        },
--      }
--    end,
--  },
--}
return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "sioyek"   -- ← Change to this
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      out_dir = "build",
      options = { "-pdf", "-interaction=nonstopmode", "-synctex=1" },
    }
    vim.g.vimtex_doc_enabled = 0
    vim.g.vimtex_complete_enabled = 0
    vim.g.vimtex_syntax_enabled = 0
    vim.g.vimtex_imaps_enabled = 0
    vim.g.vimtex_view_forward_search_on_start = 0

    -- Optional: Make forward search more convenient
    -- (already mapped by VimTeX to <localleader>lv by default)
    -- vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "VimTeX: View / forward search" })

    vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<CR>")
  end
}
