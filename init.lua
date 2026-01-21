vim.api.nvim_set_option("clipboard", "unnamedplus")

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")
vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)
vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help)
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.colorcolumn = "80"
vim.g.vimtex_compiler_latexmk = {
  options = {
    "-pdf",
    "-shell-escape",
  }
}
-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- configure typescript
-- install with `sudo npm install -g typescript-language-server typescript`
vim.lsp.config("typescript", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact" },
  root_markers = { "package.json" },
  settings = {},
})

-- set autocomplete behavior.
--   fuzzy = fuzzy search in results
--   menuone = show menu, even if there is only 1 item
--   popup = show extra info in popup
--   noselect = don"t insert the text until an item is selected
vim.cmd("set completeopt=fuzzy,menuone,popup,noselect")

-- set up stuff when the LSP client attaches
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", {}),
  callback = function(args)
    local clientID = args.data.client_id

    -- enable autocomplete
    vim.lsp.completion.enable(true, clientID, 0, { autotrigger = true })
  end,
})

-- open autocomplete menu when pressing <C-n>
vim.keymap.set("i", "<C-n>", function()
  vim.lsp.completion.get()
end)
vim.lsp.enable({ "typescript", "ltex_plus", "lua_ls", "clangd", "pyright"})
vim.lsp.config("ltex_plus", {
  cmd = { "ltex-ls-plus" },
  filetypes = { "markdown", "text", "latex" },
  root_markers = { ".ltex" },
  settings = {
    ltex = {
      language = "en-US",
      dictionary = {},
      additionalRules = {
        enablePickyRules = true,
        motherTongue = "en-US",
      },
    },
  },
})
vim.lsp.enable("neocmake")
vim.lsp.config("clangd", {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { ".clangd", "compile_commands.json" },
  settings = {
    clangd = {
      semanticHighlighting = true,
      usePlaceholders = true,
      completion = {
        includeInsertText = true,
      },
    },
  },
})
-- Python lsp config
vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python", "py", "pyi", "cython" },
  root_markers = { "pyproject.toml", "setup.py", ".git" },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})
vim.lsp.buf.hover = function()
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, 'textDocument/hover', params, function(err, result, ctx)
    if err then
      vim.notify('Error fetching hover information: ' .. err.message, vim.log.levels.ERROR)
      return
    end
    if not (result and result.contents) then
      vim.notify('No hover information available', vim.log.levels.WARN)
      return
    end
    vim.lsp.util.open_floating_preview(result.contents.value or result.contents, 'markdown')
  end)
end
-- virtual lines
vim.diagnostic.config({
  virtual_lines = {
    only_current_line = true,
    severity_limit = "Warning",
  },
  virtual_text = {
    severity_limit = "Warning",
    source = "if_many",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
})
-- packages
require("lazy").setup({
  spec = {
    -- import plugins from lua/plugins
    { import = "plugins" },
    { "nvim-lua/plenary.nvim"},
    { "jakemason/ouroboros.nvim"},
  },
})

