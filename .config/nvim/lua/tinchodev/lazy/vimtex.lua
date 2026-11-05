return {
    {
        "lervag/vimtex",
        config = function()
            -- Set PDF viewer to Skim (as per your config)
            vim.g.vimtex_view_general_viewer = '/opt/homebrew/bin/zathura'
            vim.g.vimtex_view_method = 'general'
            -- Set compiler to latexmk
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_view_automatic = 1
            -- Suppress warning messages in the compiler output
            vim.g.vimtex_quickfix_ignore_filters = {
                "Underfull",
                "Overfull",
                "Warning",     -- Broadly suppress all warnings
                ".*warning.*", -- Regex to catch any warning-related messages
            }
            -- Optional: Disable quickfix window from auto-opening on warnings
            vim.g.vimtex_quickfix_open_on_warning = 0
        end,
    },
}
