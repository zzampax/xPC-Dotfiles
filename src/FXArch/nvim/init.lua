-- ##################
-- # PLUGIN MANAGER #
-- ##################
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
-- 
-- ########################
-- # PLUGINS INSTALLATION #
-- ########################
--
require("lazy").setup({ "catppuccin/nvim", "github/copilot.vim", "meatballs/notebook.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" })
--
-- ##################
-- # OBSIDIAN SETUP #
-- ##################
--
-- #################
-- # JUPYTER SETUP #
-- #################
--
require("notebook").setup()
-- 
-- ###############
-- # THEME SETUP #
-- ###############
-- 
require("catppuccin").setup({
    flavour = "mocha", 
    background = {
        light = "latte",
        dark = "mocha",
    },
    transparent_background = true,
    show_end_of_buffer = true,
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false,
    no_bold = false,
    no_underline = false,
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
    },
})
-- 
-- #############
-- # VIM SETUP #
-- #############
--
vim.api.nvim_create_user_command("Cfr", function()
  vim.cmd("%!clang-format")
end, {})
vim.opt.conceallevel = 1
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.softtabstop = 4
vim.cmd.colorscheme "catppuccin"
vim.wo.number = true
