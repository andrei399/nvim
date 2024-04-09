return {
    "numToStr/Comment.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
        require("Comment").setup()
    end
}
