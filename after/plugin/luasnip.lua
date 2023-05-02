-- Keybinds
vim.cmd[[ 
imap <silent><expr> <C-Space> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-Space>'
imap <silent><expr> <C-j> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<C-j>'
smap <silent><expr> <C-j> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<C-j>'
imap <silent><expr> <C-k> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-k>' 
smap <silent><expr> <C-k> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-k>'
]]

-- Configuration
require("luasnip").config.set_config({
    enable_autosnippets = true,
    store_selection_keys = "<Tab>",
    update_events = 'TextChanged,TextChangedI',
})

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })
