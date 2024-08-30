local augroup = vim.api.nvim_create_augroup
local AndreiGroup = augroup('Andrei', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- autocmd({"BufWritePre"},9 {
--     group = AndreiGroup,
--     pattern = "*",
--     command = [[%s/ThePrimeagenGroup\s\+$//e]],
-- })

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--     pattern = { "*.py" },
--     desc = "Auto-format Python files after saving",
--     callback = function()
--         local fileName = vim.api.nvim_buf_get_name(0)
--         vim.cmd(":silent !" .. vim.g.python3_host_prog .. " -m black -l " .. tonumber(vim.opt.colorcolumn:get()[1]) - 1 .. " --preview -q " .. fileName)
--         vim.cmd(":silent !" .. vim.g.python3_host_prog .. " -m isort --profile black --float-to-top -q " .. fileName)
--         vim.cmd(":silent !" .. vim.g.python3_host_prog .. " -m docformatter --in-place --black " .. fileName)
--     end,
--     group = format_group,
-- })
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--     pattern = { "*.vue" },
--     desc = "Auto-format Vue files after saving",
--     callback = function()
--         local fileName = vim.api.nvim_buf_get_name(0)
--         -- use volar formatter
--         vim.cmd(":silent !volar format " .. fileName)
--     end,
--     group = format_group,
-- })

