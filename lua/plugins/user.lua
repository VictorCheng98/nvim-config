-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        cwd_target = "current",
        follow_current_file = { enabled = false },
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
      },
      window = {
        width = 40,
        mappings = {
          ["<cr>"] = "open_with_window_picker",
        },
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function(_) vim.opt_local.statusline = "%#Normal#" end,
        },
      },
    },
  },

  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup {
        hint = "floating-big-letter",
      }
    end,
  },

  -- customize alpha options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          -- Customize the dashboard header
          header = table.concat({
            "",
            "",
            "",
            "",
            "",
            "  ⟋|､",
            " (°､ ｡ 7",
            " |､  ~ヽ",
            " じしf_,)〳",
          }, "\n"),

          -- Define buttons using the `keys` format
          keys = {
            {
              key = "S F",
              action = function()
                require("persistence").load() -- Example: Load a session
              end,
              desc = "  Load a session",
            },
            {
              key = "f f",
              action = function() require("snacks.picker").files() end,
              desc = "  Find File",
            },
            {
              key = "c",
              action = function() vim.cmd "e $MYVIMRC" end,
              desc = "  Config",
            },
            {
              key = "q",
              action = function() vim.cmd "qa" end,
              desc = "󰅙  Quit",
            },
          },
        },
      },
    },
  },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
}
