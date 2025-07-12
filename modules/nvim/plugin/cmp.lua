local cmp = require('cmp')
local luasnip = require('luasnip')

require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'render-markdown' }
    },
    window = {
        documentation = {
            border = 'rounded',
            max_height = 15,
            max_width = 60,
            col_offset = 0,
            side_padding = 1,
            winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None',
            zindex = 1001
        },
    },
    formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = require('lspkind').cmp_format({
            mode = 'symbol',                   -- show only symbol annotations
            maxwidth = 50,                     -- prevent the popup from showing more than provided characters
            ellipsis_char = '...',             -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
        })
    },
}
