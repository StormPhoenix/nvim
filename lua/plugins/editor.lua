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

	-- add tsserver and setup with typescript.nvim instead of lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jose-elias-alvarez/typescript.nvim",
			init = function()
				require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
					vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
				end)
			end,
		},
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				-- tsserver will be automatically installed with mason and loaded with lspconfig
				tsserver = {},
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
			setup = {
				-- example to setup with typescript.nvim
				tsserver = function(_, opts)
					require("typescript").setup({ server = opts })
					return true
				end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
	},

	-- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
	-- treesitter, mason and typescript.nvim. So instead of the above, you can use:
	{ import = "lazyvim.plugins.extras.lang.typescript" },

	-- add more treesitter parsers
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
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

	-- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"shellcheck",
				"shfmt",
				"flake8",
			},
		},
	},
}
