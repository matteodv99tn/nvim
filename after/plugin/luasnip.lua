-- Keybinds
-- imap <silent><expr> <C-j> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<C-j>'
-- smap <silent><expr> <C-j> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<C-j>'
-- imap <silent><expr> <C-k> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-k>'
-- smap <silent><expr> <C-k> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-k>'
-- imap <silent><expr> <C-Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<C-Tab>'
-- smap <silent><expr> <C-Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<C-Tab>'
-- imap <silent><expr> <C-S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-S-Tab>'
-- smap <silent><expr> <C-S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-S-Tab>'
vim.cmd[[
imap <silent><expr> <C-Space> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-Space>'
imap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
]]

-- Configuration
require("luasnip").config.set_config({
    enable_autosnippets = true,
    -- store_selection_keys = "<Tab>",
    update_events = 'TextChanged,TextChangedI',
})

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })
