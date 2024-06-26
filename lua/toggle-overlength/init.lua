-- Define the M table to hold all plugin functionality
local M = {}

-- Default configuration settings for the plugin
M.config = {
    column_length = 120,  -- Default column length
    ctermbg = "darkgrey", -- Default background color for terminal
    guibg = "#592929",    -- Default background color for GUI
}

-- Setup function to allow users to override default settings
function M.setup(opts)
    opts = opts or {}
    M.config.column_length = opts.column_length or M.config.column_length
    M.config.ctermbg = opts.ctermbg or M.config.ctermbg
    M.config.guibg = opts.guibg or M.config.guibg
end

-- Function to toggle the highlighting of text exceeding the column length
function M.toggle_hi_overlength()
    if vim.b.overlengthhi == 1 then
        -- If the highlight is already active, clear it and reset the color column
        vim.cmd("highlight clear OverLength")
        vim.opt.colorcolumn = "0"
        vim.b.overlengthhi = 0
    else
        -- If the highlight is not active, set the highlight group and color column
        vim.cmd(string.format("highlight OverLength ctermbg=%s guibg=%s", M.config.ctermbg, M.config.guibg))
        vim.opt.colorcolumn = tostring(M.config.column_length)
        vim.fn.matchadd("OverLength", string.format("\\%%%dv.\\+", M.config.column_length + 1))
        vim.b.overlengthhi = 1
    end
end

-- Create a Vim command :ToggleHiOverLength to toggle the highlighting
vim.api.nvim_create_user_command("ToggleHiOverLength", function()
    M.toggle_hi_overlength()
end, { nargs = 0 })

-- Set a key mapping to call the toggle function using <leader>th
vim.api.nvim_set_keymap("n", "<leader>th", ":ToggleHiOverLength<CR>", { noremap = true, silent = true })

-- Return the M table to make the setup function accessible
return M
