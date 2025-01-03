return {

  -- Colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = false,
          comments = false,
          operators = false,
          folds = false,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,
        -- can be "hard", "soft" or empty string
        contrast = "",
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        -- transparent_mode = true,
        transparent_mode = false,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
      defaults = {
        -- 启用默认的 autocmds
        autocmds = true, -- lazyvim.config.autocmds
        -- 禁用默认的 keymaps
        keymaps = false, -- lazyvim.config.keymaps
      },
    },
  },

    -- 顶部栏
    {
        "utilyre/barbecue.nvim",
        event = "VeryLazy",
        dependencies = { "SmiteshP/nvim-navic" },
        opts = {
            symbols = {
                modified = "•",
                -- modified = "●",
                ellipsis = "…",
                -- separator = "",
                separator = "‣",
                -- separator = "⁍",
                -- separator = "▸",
                -- separator = "▹",
                -- separator = "▶",
                -- separator = "▷",
            },
            kinds = false,
        },
    },

    {
        "folke/snacks.nvim",
        opts = {
            dashboard = {
                preset = {
                    header = [[]],
                    -- stylua: ignore
                    ---@type snacks.dashboard.Item[]
                    keys = {
                      { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                      { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                      { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                      { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                      { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                      { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                      { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
                      { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                      { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
                sections = {
                    { section = "keys", gap = 1, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Recent Files",
                        section = "recent_files",
                        indent = 2,
                        padding = 1,
                    },
                    { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Git Status",
                        section = "terminal",
                        enabled = function()
                            return Snacks.git.get_root() ~= nil
                        end,
                        cmd = "git status --short --branch --renames",
                        height = 5,
                        padding = 1,
                        ttl = 5 * 60,
                        indent = 3,
                    },
                    { section = "startup" },
                },
            },
        },
    },
}
