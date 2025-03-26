-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- styling
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.recipes.cache-colorscheme" },
  { import = "astrocommunity.utility.noice-nvim" },

  -- cmp
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.completion.copilot-vim-cmp" },

  -- motion
  { import = "astrocommunity.motion.mini-move" },
  { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.motion.harpoon" },

  -- language packs
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },

  -- misc
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  { import = "astrocommunity.recipes.vscode" },
  { import = "astrocommunity.git.git-blame-nvim" },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = function()
      return {
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.25, -- percentage of the shade to apply to the inactive window
        },
      }
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = function(_, opts)
      local utils = require "astrocore"
      return utils.extend_tbl(opts, {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          signature = {
            enabled = false,
          },
          hover = {
            enabled = false,
          },
        },
      })
    end,
  },
}
