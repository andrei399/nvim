return {
    "steelsojka/pears.nvim",
    event = {"BufRead", "BufNewFile"},
    config = function()
        require("pears").setup()
    end
}
