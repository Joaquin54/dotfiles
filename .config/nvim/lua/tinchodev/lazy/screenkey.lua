return {
    "NStefan002/screenkey.nvim",
    config = function()
        require('screenkey').setup({
            win_opts = {
                row = vim.o.lines - vim.o.cmdheight - 30, -- Adjust the row to change vertical position
                col = 160, -- Adjust the col to change horizontal positione
                --relative = "editor", -- Position relative to the editor
                --anchor = "NE", -- Anchor the window to the top-left corner
                width = 20,  -- Set your desired width
                height = 1, -- Set your desired height
                border = "single",
                title = "Screenkey",
                title_pos = "center",
                style = "minimal",
                focusable = false,
                noautocmd = true,
            }
        })

    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            require('screenkey').toggle()
        end
    })
    end
}
