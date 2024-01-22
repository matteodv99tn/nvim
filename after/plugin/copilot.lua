-- vim.g.copilot_no_tab_map = true
-- vim.g.copilot_assumed_mapped = true
vim.cmd([[
    let g:copilot_no_tab_map = v:true
    let g:copilot_assumed_mapped = v:true
]])
-- vim.keymap.set("i", "<A-,>", "<Plug>(copilot-next)", {noremap = false})
-- vim.keymap.set("i", "<A-.>", "<Plug>(copilot-previous)", {noremap = false})
vim.keymap.set("i", "<A-CR>", "copilot#Accept('<CR>')", {silent = true, expr = true, replace_keycodes = false})
vim.keymap.set("i", "<A-y>", "copilot#Accept('<CR>')", {silent = true, expr = true, replace_keycodes = false})
vim.keymap.set("i", "<A-l>", "copilot#Accept('<CR>')", {silent = true, expr = true, replace_keycodes = false})
vim.keymap.set("i", "<A-j>", "copilot#Next()", {silent = true, expr = true, replace_keycodes = false})
vim.keymap.set("i", "<A-k>", "copilot#Previous()", {silent = true, expr = true, replace_keycodes = false})

