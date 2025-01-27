return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			-- 文件管理器
			{
				"nvim-telescope/telescope-file-browser.nvim",
				event = "VeryLazy",
				config = function()
					require("telescope").load_extension("file_browser")
					require("telescope").load_extension("fzf")
				end,
			},
			-- 增加便利的搜索过滤功能
			{
				"fdschmidt93/telescope-egrepify.nvim",
			},
			-- 自动切换 project root
			{
				"ahmedkhalf/project.nvim",
				opts = {
					-- 优先使用 pattern 来检查工程 root 目录
					detection_methods = { "pattern", "lsp" },
					-- 标记 root 目录的文件和目录
					patterns = {
						".git",
						".svn",
						"Makefile",
						"compile_commands.json",
						"go.mod",
						"package.json",
						"*.uproject",
						".project",
					},
				},
				config = function(_, opts)
					require("project_nvim").setup(opts)
					require("telescope").load_extension("projects")
				end,
			},
		},

		opts = {
			defaults = {
				path_display = { "truncate" },
				initial_mode = "insert",
				-- layout_strategy = "horizontal",
				-- sorting_strategy = "ascending",
				-- winblend = 0,
				-- layout_config = { prompt_position = "top" },
				file_ignore_patterns = {
					".git/",
					".svn/",
					".cache/",
					"node_modules/",
					"%.class",
					"%.obj",
					"%.dll",
					"%.bin",
					"%.exe",
					"%.o",
					"%.so",
				},
			},
			extensions = {
				file_browser = {
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,
				},
			},
		},
		keys = function()
			return {}
		end,
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	},

	-- add more treesitter parsers
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"c",
				"cpp",
				"bash",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			},
			sync_install = false,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		},
	},

	-- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
	-- would overwrite `ensure_installed` with the new value.
	-- If you'd rather extend the default config, use the code below instead:
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			-- add tsx and treesitter
			vim.list_extend(opts.ensure_installed, {
				"tsx",
				"typescript",
			})
		end,
	},

	-- use mini.starter instead of alpha
	{ import = "lazyvim.plugins.extras.ui.mini-starter" },
}
