-- db = require("dashboard-nvim")

-- require("dashboard-nvim").require("dashboard").setup({
--     theme = 'hyper',
--     config = {
--         week_header = {
--             enable = true,
--         },
--         shortcut = {
--             { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
--             {
--                 icon = ' ',
--                 icon_hl = '@variable',
--                 desc = 'Files',
--                 group = 'Label',
--                 action = 'Telescope find_files',
--                 key = 'f',
--             },
--             {
--                 desc = ' Apps',
--                 group = 'DiagnosticHint',
--                 action = 'Telescope app',
--                 key = 'a',
--             },
--             {
--                 desc = ' dotfiles',
--                 group = 'Number',
--                 action = 'Telescope dotfiles',
--                 key = 'd',
--             },
--         },
--     },
-- })
--
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "f", "󰱼  > Find file", ":cd $HOME | Telescope find_files<CR>"),
    dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
    dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
}


-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
