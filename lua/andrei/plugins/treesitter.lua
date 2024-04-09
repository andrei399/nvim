return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
        "nvim-treesitter/playground",
        "nvim-treesitter/nvim-treesitter-context"
    },
    config = function()
        require("nvim-treesitter.configs").setup {
          ensure_installed = { "vimdoc", "javascript", "typescript", "c", "lua", "rust", "python", "vue", "css", "scss" },
          sync_install = false,
          auto_install = true,
          autotag = { enable = true },
          indent = { enable = true},
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
        }
    end
}
