return {
	-- 禁用 luasnip 的按键
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			local luasnip = require("luasnip")
			opts.mapping = vim.tbl_extend("force", opts.mapping, {
				-- 用 Tab 展开 snippet，选择 cmplete 依然使用 ctrl-n/p 和 enter
				["<Tab>"] = require("cmp").mapping(function(fallback)
					if luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
			})
		end,
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"nvim-neotest/neotest",
		keys = function()
			return {}
		end,
	},
}
