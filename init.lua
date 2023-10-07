require("matteodv99")
-- require("figlet").Config({font="standard"})
vim.g.python3_host_prog = "/usr/bin/python3.8"


vim.api.nvim_create_autocmd({"BufWritePre"}, {
    pattern = {"*"},
    command = [[%s/\s\+$//e]],
})
