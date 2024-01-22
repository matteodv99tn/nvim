-- local lsp_format = require("lsp-format")
local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")
local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()



--  __  __
-- |  \/  | __ _ ___  ___  _ __
-- | |\/| |/ _` / __|/ _ \| '_ \
-- | |  | | (_| \__ \ (_) | | | |
-- |_|  |_|\__,_|___/\___/|_| |_|
--
-- Launch mason and ensure that specific launguage servers are installed
require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        "cmake",
        "pyright",
        "yamlls",
        "lemminx",
        "taplo",
        "rust_analyzer"
    },
    handlers = {
        lsp_zero.default_setup,
    }
})

lsp_zero.on_attach(
    function(client, bufnr)
        -- lsp_zero.default_keymaps({buffer = bufnr})
        local opts = {buffer = bufnr, remap = false}
        vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "<leader>gi", function() vim.lsp.buf.implementation() end, opts)
        vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.type_definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "J", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "<leader>sr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<F3>", function() vim.lsp.buf.format() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>dn", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "<leader>dp", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>ds", function() vim.diagnostic.open_float() end, opts)
    end
)


--     _         _                                  _      _   _
--    / \  _   _| |_ ___   ___ ___  _ __ ___  _ __ | | ___| |_(_) ___  _ __
--   / _ \| | | | __/ _ \ / __/ _ \| '_ ` _ \| '_ \| |/ _ \ __| |/ _ \| '_ \
--  / ___ \ |_| | || (_) | (_| (_) | | | | | | |_) | |  __/ |_| | (_) | | | |
-- /_/   \_\__,_|\__\___/ \___\___/|_| |_| |_| .__/|_|\___|\__|_|\___/|_| |_|
--                                           |_|
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = {
    -- Autocompletion menu
    ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-l>"] = cmp.mapping.confirm({select = true}),
    ["<C-y>"] = cmp.mapping.confirm({select = true}),
    ["<C-space>"] = cmp.mapping.complete(),

    -- Documentation scrolling
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),

    -- LuaSnips
    ["<C-Tab>"] = cmp_action.luasnip_jump_forward(),
    ["<C-S-Tab>"] = cmp_action.luasnip_jump_backward(),

    -- Unmap tab and CR
    ["<Tab>"] = nil,
    ["<S-Tab>"] = nil,
    ["<CR>"] = nil,
}

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp_mappings,
})


require("lsp_signature").setup({
    bind = true,
    floating_window = false,
    floating_window_above_cur_lune = false,
    handler_opts = {
        border = "rounded"
    },
    hint_prefix = " ",
})

--  _
-- | |    __ _ _ __   __ _ _   _  __ _  __ _  ___
-- | |   / _` | '_ \ / _` | | | |/ _` |/ _` |/ _ \
-- | |__| (_| | | | | (_| | |_| | (_| | (_| |  __/
-- |_____\__,_|_| |_|\__, |\__,_|\__,_|\__, |\___|
--                   |___/             |___/
--  ____                  _  __ _        ____       _
-- / ___| _ __   ___  ___(_)/ _(_) ___  / ___|  ___| |_ _   _ _ __
-- \___ \| '_ \ / _ \/ __| | |_| |/ __| \___ \ / _ \ __| | | | '_ \
--  ___) | |_) |  __/ (__| |  _| | (__   ___) |  __/ |_| |_| | |_) |
-- |____/| .__/ \___|\___|_|_| |_|\___| |____/ \___|\__|\__,_| .__/
--       |_|                                                 |_|

-- Setup lsp formatter
-- lsp_format.setup({
-- })

require('lspconfig').lemminx.setup({
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
})

local yapf = {
    formatCommand = "yapf ${INPUT}",
    formatStdin = true,
}

-- Setup for clang - C++
local cmp_nvim_lsp = require("cmp_nvim_lsp")
require("lspconfig").clangd.setup({
    -- on_attach = lsp_format.on_attach,
    capabilities = cmp_nvim_lsp.default_capabilities(),
    cmd = {
        "clangd",
        "--offset-encoding=utf-16",
    },
})

-- Setup for Python
require("lspconfig").pyright.setup({
    -- on_attach = lsp_format.on_attach,
    init_options = {documentFormatting = True},
    capabilities = cmp_nvim_lsp.default_capabilities(),
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
            },
        },
        languages = {
            python = yapf,
        }
    },
})
