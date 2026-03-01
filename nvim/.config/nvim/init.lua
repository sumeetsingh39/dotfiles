-- =============================================================================
-- Minimal Neovim Config - Catppuccin Mocha Lavender
-- ~/.config/nvim/init.lua
-- =============================================================================

-- ==================== Options ====================

local o = vim.opt

o.number = true           -- line numbers
o.relativenumber = true   -- relative line numbers (great for vim motions)
o.cursorline = true       -- highlight current line
o.scrolloff = 8           -- keep 8 lines above/below cursor when scrolling
o.sidescrolloff = 8

o.tabstop = 4             -- tab = 4 spaces
o.shiftwidth = 4          -- indent = 4 spaces
o.expandtab = true        -- use spaces instead of tabs
o.smartindent = true      -- auto indent on new lines

o.wrap = false            -- don't wrap long lines
o.linebreak = true        -- if wrap is on, break at word boundary

o.ignorecase = true       -- case-insensitive search
o.smartcase = true        -- unless you type uppercase
o.hlsearch = true         -- highlight search results
o.incsearch = true        -- highlight as you type

o.termguicolors = true    -- true color support (required for catppuccin)
o.signcolumn = "yes"      -- always show sign column (no layout shifts)
o.colorcolumn = "80"      -- subtle line at 80 chars

o.splitbelow = true       -- horizontal splits go below
o.splitright = true       -- vertical splits go right

o.clipboard = "unnamedplus"  -- use system clipboard (Wayland wl-copy)
o.mouse = "a"                -- enable mouse support

o.undofile = true         -- persistent undo across sessions
o.swapfile = false        -- no swap files
o.backup = false

o.updatetime = 250        -- faster CursorHold events
o.timeoutlen = 300        -- faster key sequence timeout

o.list = true             -- show invisible characters
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- ==================== Keymaps ====================

vim.g.mapleader = " "           -- space as leader key
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Clear search highlight with Esc
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Save with Ctrl+S
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR><Esc>")

-- Quit
map("n", "<leader>q", "<cmd>q<CR>",  { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa<CR>", { desc = "Quit all" })

-- Better window navigation (Ctrl + hjkl)
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows with arrow keys
map("n", "<C-Up>",    "<cmd>resize +2<CR>")
map("n", "<C-Down>",  "<cmd>resize -2<CR>")
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep cursor centered when jumping
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n",     "nzzzv")
map("n", "N",     "Nzzzv")

-- Paste without losing register (paste over selection)
map("v", "p", '"_dP')

-- Better indenting — stay in visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Split windows
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>sh", "<cmd>split<CR>",  { desc = "Horizontal split" })
map("n", "<leader>sc", "<cmd>close<CR>",  { desc = "Close split" })

-- Buffer navigation
map("n", "<S-l>", "<cmd>bnext<CR>",     { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- ==================== Colorscheme (Catppuccin) ====================

-- Auto-install catppuccin if not present using native pack system
local catppuccin_path = vim.fn.stdpath("data") .. "/site/pack/catppuccin/start/catppuccin"

if vim.fn.isdirectory(catppuccin_path) == 0 then
    vim.notify("Installing Catppuccin theme...", vim.log.levels.INFO)
    vim.fn.system({
        "git", "clone", "--depth=1",
        "https://github.com/catppuccin/nvim",
        catppuccin_path
    })
    vim.cmd("packloadall")
end

-- Configure and apply theme
require("catppuccin").setup({
    flavour = "mocha",
    integrations = {
        treesitter = true,
    },
    highlight_overrides = {
        mocha = function(colors)
            return {
                -- Use lavender as the accent color
                CursorLineNr = { fg = colors.lavender, bold = true },
                Visual        = { bg = colors.surface1 },
                Search        = { bg = colors.lavender, fg = colors.base },
                IncSearch     = { bg = colors.mauve,    fg = colors.base },
            }
        end,
    },
})

vim.cmd("colorscheme catppuccin-mocha")

-- ==================== Syntax Highlighting ====================

-- Enable treesitter if available (ships with nvim 0.9+, no install needed)
local ok, ts = pcall(require, "nvim-treesitter.configs")
if ok then
    ts.setup({ highlight = { enable = true } })
else
    -- Fallback: enable built-in syntax highlighting
    vim.cmd("syntax on")
    vim.cmd("filetype plugin indent on")
end
