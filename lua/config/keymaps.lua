local keymap = vim.keymap

-- ------- insert mode ---------
keymap.set("i", "jk", "<ESC>")

-- ------- visual mode ---------
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ------- normal mode ---------
-- window
keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")

-- cancel highlight

-- ------- plugins ---------
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- switch buffer
-- keymap.set("n", "<C-L>", ":bnext<CR>")
-- keymap.set("n", "<C-H>", ":bprevious<CR>")

-- telescope
keymap.set(
	"n",
	"<leader>sp",
	[[<cmd>lua require("config.telescope").search_current_project()<cr>]],
	{ desc = "Search Project" }
)
keymap.set(
	"v",
	"<leader>sp",
	[[<cmd>lua require("config.telescope").search_current_project("v")<cr>]],
	{ desc = "Search Project" }
)
keymap.set(
	"n",
	"<leader>ss",
	[[<cmd>lua require("config.telescope").current_buffer_fuzzy_find()<cr>]],
	{ desc = "[S]earch [S]tring in Buffer" }
)
keymap.set(
	"n",
	"<leader>sd",
	[[<cmd>lua require("config.telescope").search_current_dir()<cr>]],
	{ desc = "[S]earch in [D]irectory" }
)
keymap.set(
	"v",
	"<leader>sd",
	[[<cmd>lua require("config.telescope").search_current_dir("v")<cr>]],
	{ desc = "[S]earch in [D]irectry" }
)
keymap.set(
	"n",
	"<leader>.",
	[[<cmd>lua require("config.telescope").find_current_project()<cr>]],
	{ desc = "Find Project Files" }
)
