


vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})


return {

  -- Mason: LSP/DAP/formatter installer
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason LSP Bridge (LSP installer wrapper)
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  -- nvim-lspconfig: LSP client configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local map = vim.keymap.set
        local opts = { buffer = bufnr}

        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        map("n", "<leader>e", vim.diagnostic.open_float, opts)
      end

      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        on_attach = on_attach
      })

      vim.lsp.config("clangd", {
        capabilities = capabilities,

        on_attach = function(_, bufnr)
          on_attach(_, bufnr)

          vim.keymap.set("n", "<leader>cf", ":%!clang-format<CR>", { buffer = bufnr, desc = "Clang format file" })
          vim.keymap.set("v", "<leader>cf", ":'<,'>!clang-format<CR>", { buffer = bufnr, desc = "Clang format selection" })
        end
      })

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        on_attach = on_attach
      })

    end,
  },
}
