return {
    'mrjones2014/legendary.nvim',
    priority = 10000,
    lazy = false,
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
    config = function()
        require('legendary').setup({
            extensions = {
                smart_splits = {
                    directions = { 'h', 'j', 'k', 'l' },
                    mods = {
                        move = '<C>',
                        resize = '<M>',
                        -- any of these can also be a table of the following form
                        swap = {
                            -- this will create the mapping like
                            -- <leader><C-h>
                            -- <leader><C-j>
                            -- <leader><C-k>
                            -- <leader><C-l>
                            mod = '<C>',
                            prefix = '<leader>',
                        },
                    },
                },
            },
        })
    end
}
