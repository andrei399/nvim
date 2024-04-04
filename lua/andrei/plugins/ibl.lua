return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufRead", "BufNewFile" },
    config = function()
        require("ibl").setup({
            scope = {
                show_start = false,
                show_end = false,
            },
        })
        local hooks = require "ibl.hooks"
        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end
}
