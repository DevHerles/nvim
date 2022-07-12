vim.g.mapleader = " "

local wk = require("which-key")

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<ESC>", ":nohl<cr>", opts)

-- Act like D and C ------------------------------------------------------------
keymap("n", "Y", "y$", opts)
keymap("n", "<C-y>", "yaw", opts)

keymap("n", "0", "^", opts)
keymap("n", ",", "<PageDown>", opts)
keymap("n", ";", "<PageUp>", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)

-- Resize with arrows ----------------------------------------------------------
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers ------------------------------------------------------------
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down -------------------------------------------------------
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter ------------------------------------------------------
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode ---------------------------------------------------------
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down -------------------------------------------------------
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down -------------------------------------------------------
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

wk.register({
	["<leader>f"] = { name = "+file" },
	["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
	["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
	["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
	["<leader>fb"] = { "<cmd>Telescope buffers<cr>", "Find buffers" },
	["<leader>fg"] = { "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", "Find grep" },
	["<leader>e"] = { "<cmd>Ranger<cr>", "Explorer" },
	["<leader>-"] = { "<cmd>split<cr>", "Vertical split" },
	["<leader>|"] = { "<cmd>vsplit<cr>", "Horizontal split" },
	["<leader>i"] = { "<cmd>PackerSync<cr>", "Install plugins" },
	["<leader>w"] = { "<cmd>w<cr>", "Write" },
	["<leader>Q"] = { "<cmd>qa!<cr>", "Force Quit" },
	["<leader>q"] = { "<cmd>Bdelete<cr>", "Delete buffer" },
	["<leader>qo"] = { "<cmd>Bonly<cr>", "Delete other buffers" },
	["<leader>hw"] = { "<cmd>HopWord<cr>", "HopWord" },
	["<leader>hp"] = { "<cmd>HopPattern<cr>", "HopPattern" },
	["<leader>r"] = { "<cmd>e!<cr>", "Reload file" },
})
