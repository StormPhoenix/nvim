-- 对下列的 language servers 禁用格式化功能
local ignored_format_servers = {
	"tsserver", -- 使用 prettier
	"lua_ls", -- 使用 stylua
	"clangd", -- 使用 clang-format
}

local function init_lsp()
	require("lazyvim.util").lsp.on_attach(function(client, _)
		if vim.fn.index(ignored_format_servers, client.name) >= 0 then
			client.server_capabilities.documentFormattingProvider = false
		end
	end)

	local lsp_format = function()
		require("lazyvim.util").format({ force = true })
	end

	local lsp_source_action = function()
		vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
	end


      -- { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
      -- { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
      -- { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
      -- { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
      -- { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
      -- { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      -- { "K", function() return vim.lsp.buf.hover() end, desc = "Hover" },
      -- { "gK", function() return vim.lsp.buf.signature_help() end, desc = "Signature Help", has = "signatureHelp" },
      -- { "<c-k>", function() return vim.lsp.buf.signature_help() end, mode = "i", desc = "Signature Help", has = "signatureHelp" },
      -- { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
      -- { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
      -- { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
      -- { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
      -- { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
      -- { "<leader>cA", LazyVim.lsp.action.source, desc = "Source Action", has = "codeAction" },
      -- { "]]", function() Snacks.words.jump(vim.v.count1) end, has = "documentHighlight",
      --   desc = "Next Reference", cond = function() return Snacks.words.is_enabled() end },
      -- { "[[", function() Snacks.words.jump(-vim.v.count1) end, has = "documentHighlight",
      --   desc = "Prev Reference", cond = function() return Snacks.words.is_enabled() end },
      -- { "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, has = "documentHighlight",
      --   desc = "Next Reference", cond = function() return Snacks.words.is_enabled() end },
      -- { "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, has = "documentHighlight",
      --   desc = "Prev Reference", cond = function() return Snacks.words.is_enabled() end },

    -- stylua: ignore
    local mappings = {
        { "<leader>ld", [[<cmd>lua require("config.telescope").diagnostics({bufnr=0})<cr>]], desc = "Buffer [D]iagnostics" },
        { "<leader>lD", [[<cmd>lua require("config.telescope").diagnostics()<cr>]], desc = "Workspace [D]iagnostics" },
        { "<leader>lf", lsp_format, desc = "[F]ormat Document", has = "documentFormatting" },
        { "<leader>lf", lsp_format, desc = "[F]ormat Range", mode = "v", has = "documentRangeFormatting" },
        { "<leader>la", vim.lsp.buf.code_action, desc = "Code [A]ction", mode = { "n", "v" }, has = "codeAction" },
        { "<leader>ll", vim.lsp.codelens.run, desc = "Run Code[L]ens", mode = { "n", "v" }, has = "codeLens" },
        { "<leader>lL", vim.lsp.codelens.refresh, desc = "Refresh Code[L]ens", mode = { "n", "v" }, has = "codeLens" },
        { "<leader>lA", lsp_source_action, desc = "Source [A]ction", has = "codeAction" },
        { "<leader>fm", [[<cmd>lua Snacks.rename.rename_file()<cr>]], desc = "Rena[m]e", has = "rename" },
        { "<leader>lm", vim.lsp.buf.rename, desc = "Rena[m]e", has = "rename" },
        { "<leader>si", [[<cmd>lua require("config.telescope").lsp_document_symbols({ symbols = LazyVim.config.get_kind_filter(), })<cr>]], desc = "[S]earch Symbol [I]n Buffer", has = "documentSymbol" },
        { "<leader>so", [[<cmd>lua require("config.telescope").lsp_dynamic_workspace_symbols({ symbols = LazyVim.config.get_kind_filter(), })<cr>]], desc = "[S]earch Symbol In W[o]rkspace", has = "documentSymbol" },
        { "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp [I]nfo" },

        -- 默认的配置
        -- { "gd", [[<cmd>lua require("config.telescope").lsp_definitions()<cr>]], desc = "[G]oto [D]efinition", has = "definition" },
        -- { "gr", [[<cmd>lua require("config.telescope").lsp_references()<cr>]], desc = "[G]oto [R]eferences" },
        -- { "gD", vim.lsp.buf.declaration, desc = "[G]oto [D]eclaration" },
        -- { "gI", [[<cmd>lua require("config.telescope").lsp_implementations()<cr>]], desc = "[G]oto [I]mplementation" },
        -- { "gy", [[<cmd>lua require("config.telescope").lsp_type_definitions()<cr>]], desc = "[G]oto T[y]pe Definition" },
        -- { "K", vim.lsp.buf.hover, desc = "Hover" },
        -- { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
        -- { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },

        { "<leader>cl", false }, -- original lsp info
        { "<leader>ca", false }, -- original code action
        { "<leader>cA", false }, -- original code action
        { "<leader>cr", false }, -- original rename
    }

	local keys = require("lazyvim.plugins.lsp.keymaps").get()
	for _, m in ipairs(mappings) do
		keys[#keys + 1] = m
	end
end

return {
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
		init = init_lsp,

		opts = {
			servers = {
				bashls = {},
				clangd = {
					keys = {
                        -- stylua: ignore
                        { "<localleader>o", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
					},
					capabilities = {
						offsetEncoding = "utf-16",
					},
				},
				rust_analyzer = {
					keys = {
						{ "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
						{
							"<localleader>c",
							[[<cmd>lua require("rust-tools").open_cargo_toml.open_cargo_toml()<CR>]],
							desc = "Rust Open Cargo.toml",
						},
						{
							"<localleader>x",
							[[<cmd>lua require("rust-tools").runnables.runnables()<CR>]],
							desc = "Rust Runnables",
						},
						{ "<localleader>a", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
						{ "<localleader>d", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
					},
				},
				tsserver = {
					keys = {
						{ "<localleader>i", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
						{ "<localleader>m", "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
					},
				},
			},
			setup = {
				tsserver = function(_, opts)
					require("typescript").setup({ server = opts })
					return true
				end,
			},
		},
	},

	-- Format & Lint
	{
		"nvimtools/none-ls.nvim",
		optional = true,
		opts = function(_, opts)
			local nls = require("null-ls")
			local formatting = nls.builtins.formatting
			-- local diagnostics = nls.builtins.diagnostics
			-- local code_actions = nls.builtins.code_actions
			opts.sources = opts.sources or {}
			local srcs = {
				formatting.clang_format,
				-- formatting.stylua,
				-- formatting.shfmt,
				-- formatting.prettier,
				-- diagnostics.shellcheck,
				-- code_actions.shellcheck,
				-- code_actions.eslint,
				-- diagnostics.tsc,
				-- formatting.black.with({ extra_args = { "--fast" } }),
				-- require("typescript.extensions.null-ls.code-actions"),
			}

			for _, src in ipairs(srcs) do
				table.insert(opts.sources, src)
			end
		end,
	},
	-- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
				"shellcheck",
				"black",
				"prettier",
				"stylua",
				"clang-format",
				"js-debug-adapter",
			},
		},
	},
}
