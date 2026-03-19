-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  opts = function(_, opts)
    local null_ls = require "null-ls"

    opts.debounce = 1000
    if not opts.sources then opts.sources = {} end
    vim.list_extend(opts.sources, {
      null_ls.builtins.formatting.stylua,
      require("none-ls.diagnostics.eslint_d").with {
        extra_args = { "--cache" },
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      },
      require("none-ls.code_actions.eslint_d").with {
        extra_args = { "--cache" },
      },
    })
  end,
}
