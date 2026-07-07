return {
  -- Plugin: nvim-cmp
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",

  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()

    -- 1. ICONS TABLE
    local kind_icons = {
      Text = "", Method = "󰆧", Function = "󰊕", Constructor = "",
      Field = "󰇽", Variable = "󰂡", Class = "󰠱", Interface = "",
      Module = "", Property = "󰜢", Unit = "", Value = "󰎠",
      Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘",
      File = "󰈙", Reference = "", Folder = "󰉋", EnumMember = "",
      Constant = "󰏿", Struct = "", Event = "", Operator = "󰆕",
      TypeParameter = "󰅲",
    }

    cmp.setup({
      -- 2. SELECTION BEHAVIOR
      completion = {
        completeopt = "menu,menuone,noinsert",
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- 3. WINDOW STYLING
      -- These automatically link to the Pmenu/Blue colors we set in colors.lua
      window = {
        completion = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          border = "rounded",
        }),
      },

      -- 4. FORMATTING
      formatting = {
        format = function(entry, vim_item)
          -- Icon + Kind Name
          vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
          vim_item.menu = ""
          return vim_item
        end
      },

      -- 5. MAPPINGS
      mapping = cmp.mapping.preset.insert({
        ["<M-b>"] = cmp.mapping.scroll_docs(-4),
        ["<M-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<M-e>"] = cmp.mapping.abort(),
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
    })
  end,
}
