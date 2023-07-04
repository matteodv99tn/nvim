vim.g.copilot_assumed_mapped = true
vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<A-,>", "<Plug>(copilot-next)", {noremap = false})
vim.keymap.set("i", "<A-.>", "<Plug>(copilot-previous)", {noremap = false})
vim.keymap.set("i", "<A-j>", "copilot#Accept('<CR>')", {silent = true, expr = true, replace_keycodes = false})

