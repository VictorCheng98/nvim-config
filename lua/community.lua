if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder

  {
    "jay-babu/project.nvim",
    opts = function(_, opts) opts.patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile" } end,
  },
}
