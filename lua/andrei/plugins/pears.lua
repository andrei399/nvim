return {
    "steelsojka/pears.nvim",
    event = "VeryLazy",
    config = function()
        require("pears").setup()
    end
}
