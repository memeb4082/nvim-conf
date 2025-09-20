return {
  {
    "neovim/nvim-lspconfig",
    lazy = false, -- Load immediately for reliable LSP startup
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.texlab.setup({
        cmd = { "texlab" }, -- Provided by Nix in extraPackages
        filetypes = { "tex", "plaintex", "bib" },
        settings = {
          texlab = {
            build = {
              executable = "tectonic",
              args = { "%f" },
              onSave = true, -- Auto-build on save
            },
            diagnostics = {
              ignoredPatterns = { "^Overfull", "^Underfull" }, -- Ignore common LaTeX warnings
            },
            forwardSearch = {
              executable = "zathura", -- Optional: for forward search (PDF viewer)
              args = { "--synctex-forward", "%l:1:%f", "%p" },
            },
          },
        },
      })
    end,
  },
}
