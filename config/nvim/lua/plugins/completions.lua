-- plugins/cmp.lua
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",       -- load only when you start typing :contentReference[oaicite:0]{index=0}
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",        -- snippet engine :contentReference[oaicite:1]{index=1}
    "saadparwaiz1/cmp_luasnip", -- make LuaSnip a cmp source :contentReference[oaicite:2]{index=2}
    "rafamadriz/friendly-snippets", -- large community snippet set
  },

  config = function()
    local cmp     = require("cmp")
    local luasnip = require("luasnip")

    -- lazy‑load VS‑Code style snippets (optional)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip"  }, -- snippets appear in completion menu
        { name = "path"     },
        { name = "buffer"   },
      }),
    })
  end,
}
