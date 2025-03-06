-- This file can be loaded by calling `lua require("plugins")` from your init.vim
-- To install do
-- :so
-- :PackerSync


function WaitForPackerSync()
    local timeout = 5000  -- Maximum timeout in milliseconds
    local start_time = vim.loop.hrtime()

    -- Keep checking the status of Packer until it's done or timeout occurs
    while vim.fn.exists(":PackerStatus") == 2 do
        -- Check if timeout has occurred
        if (vim.loop.hrtime() - start_time) / 1000000 > timeout then
            print("PackerSync timed out")
            return
        end
        vim.cmd("sleep 100ms")
    end
    print("PackerSync completed")
end

-- Installs packer if it is not already installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()


return require("packer").startup(function(use)

    use ({"wbthomason/packer.nvim"})

    --  __  __           _     _   _
    -- |  \/  |_   _ ___| |_  | | | | __ ___   _____  ___
    -- | |\/| | | | / __| __| | |_| |/ _` \ \ / / _ \/ __|
    -- | |  | | |_| \__ \ |_  |  _  | (_| |\ V /  __/\__ \
    -- |_|  |_|\__,_|___/\__| |_| |_|\__,_| \_/ \___||___/
    --
    -- Telescope
    use ({
        "nvim-telescope/telescope.nvim", tag = "0.1.x",
        requires = { {"nvim-lua/plenary.nvim"} }
    })

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    })

    -- LSP
    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        requires = {
            -- LSP Support
            {"neovim/nvim-lspconfig"},             -- Required
            {"williamboman/mason.nvim"},           -- Optional
            {"williamboman/mason-lspconfig.nvim"}, -- Optional

            -- Autocompletion
            {"hrsh7th/nvim-cmp"},         -- Required
            {"hrsh7th/cmp-nvim-lsp"},     -- Required
            {"hrsh7th/cmp-buffer"},       -- Optional
            {"hrsh7th/cmp-path"},         -- Optional
            {"saadparwaiz1/cmp_luasnip"}, -- Optional
            {"hrsh7th/cmp-nvim-lua"},     -- Optional

            -- Snippets
            {"L3MON4D3/LuaSnip"},             -- Required
        }
    })

    use({"github/copilot.vim"})
    use({"robitx/gp.nvim"})
    use({"folke/which-key.nvim"})
    use({"mbbill/undotree"})
    use({"theprimeagen/harpoon"})
    use({"tpope/vim-fugitive"})
    -- use({"lukas-reineke/lsp-format.nvim"})
    use({"ray-x/lsp_signature.nvim"})
    use({"sbdchd/neoformat"})


    --  _____ _                    _
    -- |_   _| |__   ___ _ __ ___ (_)_ __   __ _
    --   | | | '_ \ / _ \ '_ ` _ \| | '_ \ / _` |
    --   | | | | | |  __/ | | | | | | | | | (_| |
    --   |_| |_| |_|\___|_| |_| |_|_|_| |_|\__, |
    --                                     |___/
    -- Color themes
    use({ "catppuccin/nvim", as = "catppuccin" })
    use({
        "rose-pine/neovim",
        as = "rose-pine",
    })

    use({"nvim-tree/nvim-web-devicons"})

    -- Top bar
    use({
        "romgrk/barbar.nvim",
        requires = "nvim-web-devicons"
    })

    -- Status bar
    use({
        "vim-airline/vim-airline",
        requires = {"catppuccin/vim"},
    })

    -- Pretty fonts and comments (requires figlet to be installed)
    use({
        "pavanbhat1999/figlet.nvim",
        requires = "numToStr/Comment.nvim"
    })

    -- Startup dashboard
    use({
        "goolord/alpha-nvim",
        requires = { "nvim-tree/nvim-web-devicons" },
        config = function ()
            require"alpha".setup(require"alpha.themes.dashboard".config)
        end
    })


    --  _
    -- | |    __ _ _ __   __ _ _   _  __ _  __ _  ___
    -- | |   / _` | '_ \ / _` | | | |/ _` |/ _` |/ _ \
    -- | |__| (_| | | | | (_| | |_| | (_| | (_| |  __/
    -- |_____\__,_|_| |_|\__, |\__,_|\__,_|\__, |\___|
    --                   |___/             |___/
    --  ____                  _  __ _        ____  _             _
    -- / ___| _ __   ___  ___(_)/ _(_) ___  |  _ \| |_   _  __ _(_)_ __   __ _ ___
    -- \___ \| '_ \ / _ \/ __| | |_| |/ __| | |_) | | | | |/ _` | | '_ \ / _` / __|
    --  ___) | |_) |  __/ (__| |  _| | (__  |  __/| | |_| | (_| | | | | | (_| \__ \
    -- |____/| .__/ \___|\___|_|_| |_|\___| |_|   |_|\__,_|\__, |_|_| |_|\__, |___/
    --       |_|                                           |___/         |___/

    -- Documentation generation
    use({
        "kkoomen/vim-doge",
        run = ":call doge#install()"
    })

    -- Latex
    use({"lervag/vimtex"})

    -- Markdown
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    })

    -- Cmake
    use({"ilyachur/cmake4vim"})

    use({"jamestthompson3/nvim-remote-containers"})


    --  __  __ _
    -- |  \/  (_)___  ___
    -- | |\/| | / __|/ __|
    -- | |  | | \__ \ (__
    -- |_|  |_|_|___/\___|
    --
    use({"nvim-treesitter/playground"})

end)


