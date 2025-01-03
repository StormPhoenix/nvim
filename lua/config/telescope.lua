local M = {}

local function with_default(opt)
    return opt
end

function M.find_current_project()
    require("telescope.builtin").find_files(with_default({
        prompt_title = "< Current Project >",
    }))
end

local function general_text_search(typ, title, get_search_dirs)
    local full_title = "< " .. title .. " >"
    if typ == "v" then
        local text = utils.get_selected_text(true)
        text = text:gsub("%(", "\\(")
        text = text:gsub("%)", "\\)")

        require("telescope").extensions.egrepify.egrepify(with_default({
            prompt_title = full_title,
            search_dirs = get_search_dirs(),
            default_text = text,
        }))

        -- require("telescope.builtin").live_grep(with_default({
        --     prompt_title = full_title,
        --     search_dirs = get_search_dirs(),
        --     default_text = text,
        -- }))
    else
        require("telescope").extensions.egrepify.egrepify(with_default({
            prompt_title = full_title,
            search_dirs = get_search_dirs(),
        }))

        -- require("telescope.builtin").live_grep(with_default({
        --     prompt_title = full_title,
        --     search_dirs = get_search_dirs(),
        -- }))
    end
end

function M.search_current_project(typ)
    general_text_search(typ, "Current Project", function()
        return nil
    end)
end

function M.search_current_dir(typ)
    general_text_search(typ, "Current Dir", function()
        return { vim.fn.expand("%:p:h") }
    end)
end

return setmetatable({}, {
    __index = function(_, k)
        if M[k] then
            return M[k]
        else
            return function(opt)
                require("telescope.builtin")[k](with_default(opt))
            end
        end
    end,
})
