require("matteodv99.settings")      -- Import the settings
require("matteodv99.remap")         -- Import the keybindings

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = {"*"},
    pattern = {"^(?!.*(tex|latex))"},
    command = [[%s/\s\+$//e]],
})

-- Enable automatic start of markdown previewer
vim.g.mkdp_auto_start = 1
