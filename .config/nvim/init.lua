-- ==========================================================================
--                                 NEOVIM INIT.LUA
-- ==========================================================================

-- --- System Options ---
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Relative line numbers for easy jumping
vim.opt.mouse = 'a'            -- Enable mouse support
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.termguicolors = true   -- True color support (needed for pink theme)

-- --- Tabs & Indentation ---
vim.opt.tabstop = 4            -- Number of spaces tabs count for
vim.opt.shiftwidth = 4         -- Size of an indent
vim.opt.expandtab = true       -- Convert tabs to spaces
vim.opt.smartindent = true     -- Insert indents automatically

-- --- Search Options ---
vim.opt.ignorecase = true      -- Ignore case when searching...
vim.opt.smartcase = true       -- ...unless capital letters are used
vim.opt.hlsearch = false       -- Clear highlight after search is done

-- ==========================================================================
-- --- Catppuccin Mocha Pink ---
-- ==========================================================================
local pink      = "#d81b60"
local mauve     = "#cba6f7"
local base      = "#1e1e2e"
local surface0  = "#313244"
local text      = "#cdd6f4"
local subtext0  = "#a6adc8"
local overlay0  = "#6c7086"
local blue      = "#89b4fa"
local green     = "#a6e3a1"
local red       = "#f38ba8"
local yellow    = "#f9e2af"
local rosewater = "#d81b60"
local teal      = "#ffb3d1"
local sap       = "#ffb3d1"

-- Apply UI colors directly without needing heavy plugins
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", fg = text })
vim.api.nvim_set_hl(0, "LineNr", { fg = sap })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = teal, bold = true })
vim.api.nvim_set_hl(0, "Visual", { bg = rosewater })
vim.api.nvim_set_hl(0, "Search", { bg = teal, fg = base })

-- Syntax Highlights
vim.api.nvim_set_hl(0, "Comment", { fg = sap, italic = true })
vim.api.nvim_set_hl(0, "Keyword", { fg = teal, bold = true })
vim.api.nvim_set_hl(0, "Function", { fg = blue })
vim.api.nvim_set_hl(0, "String", { fg = green })

-- --- Keymaps (Quality of Life) ---
vim.g.mapleader = " " -- Set Spacebar as your leader key

-- Fast saving and exiting
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Clear search highlights easily with Esc
vim.keymap.set("n", "<Esc>", ":noh<CR>", { silent = true })

-- ==========================================================================
-- --- Plugin Manager (lazy.nvim) ---
-- ==========================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
