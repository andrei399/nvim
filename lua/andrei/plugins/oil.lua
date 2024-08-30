return {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require('oil').setup({
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = "actions.select_vsplit",
                ["<C-n>"] = "actions.select_split", -- edited
                ["<C-t>"] = "actions.select_tab",
                ["<leader>p"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<C-r>"] = "actions.refresh", -- edited
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
            use_default_keymaps = false,
            view_options = {
                show_hidden = true,
            },
        })
        vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)
        vim.keymap.set("n", "<leader>vpp", "<cmd>Oil ~/.config/nvim/lua/andrei/<CR>")
    end
}
