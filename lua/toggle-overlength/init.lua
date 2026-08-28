local M = {}

local defaults = {
    column_length = 120,
    ctermbg = "darkgrey",
    guibg = "#592929",
}

local config = {}

--- Merge user options with defaults, create the user command, and optionally set a keymap.
--- @param opts table|nil
function M.setup(opts)
    config = vim.tbl_deep_extend("force", defaults, opts or {})

    vim.api.nvim_create_user_command("ToggleHiOverLength", M.toggle, { nargs = 0 })

    if config.keymap then
        vim.keymap.set("n", config.keymap, M.toggle, { noremap = true, silent = true })
    end
end

--- Toggle the overlength highlighting for the current window/buffer.
function M.toggle()
    local match_id = vim.b.overlength_match_id

    if match_id then
        -- Turn off: remove match, clear highlight, reset colorcolumn
        pcall(vim.fn.matchdelete, match_id)
        vim.cmd("highlight clear OverLength")
        vim.wo.colorcolumn = "0"
        vim.b.overlength_match_id = nil
    else
        -- Turn on: define highlight, set colorcolumn, add match
        vim.cmd(string.format("highlight OverLength ctermbg=%s guibg=%s", config.ctermbg, config.guibg))
        vim.wo.colorcolumn = tostring(config.column_length)
        local id = vim.fn.matchadd("OverLength", string.format("\\%%%dv.\\+", config.column_length + 1))
        vim.b.overlength_match_id = id
    end
end

return M
