
-- ~/.config/nvim/lua/plugins/harpoon.lua

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        -- Setting the Harpoon 2 bindings
        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add() end)
        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<C-h>", function()
            harpoon:list():select(1)
        end)
        vim.keymap.set("n", "<C-t>", function()
            harpoon:list():select(2)
        end)
        vim.keymap.set("n", "<C-3>", function()
            harpoon:list():select(3)
        end)
        vim.keymap.set("n", "<C-4>", function()
            harpoon:list():select(4)
        end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-p>", function()
            harpoon:list():prev()
        end)
        vim.keymap.set("n", "<C-n>", function()
            harpoon:list():next()
        end)
    end,
}
