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
        follow_current_file = false, -- Don't change the tree when switching buffers
      },
      window = {
        width = 40, -- Set the desired width here
      },
    },
  },

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      local dashboard = require "alpha.themes.dashboard"

      -- customize the dashboard header
      opts.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("p", "Projects", ":Telescope projects<CR>"), -- Telescope icon for Projects
        dashboard.button("r", "Recent", ":Telescope oldfiles<CR>"), -- Clock icon for Recent files
        dashboard.button("s", "Settings", ":e $MYVIMRC | :cd %:p:h | pwd<CR>"), -- Tools icon for Settings
        dashboard.button("q", "Quit", ":qa<CR>"), -- Door icon for Quit
      }

      return opts
    end,
  },

  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        manual_mode = false, -- Automatically detect project based on root patterns
        detection_methods = { "lsp", "pattern" }, -- Detect via LSP or root patterns
        patterns = { ".git", "Makefile", "package.json" }, -- Root patterns to look for
        show_hidden = true, -- Show hidden files in Telescope
        silent_chdir = false, -- Notify when changing directory automatically
        datapath = vim.fn.stdpath "data", -- Path to store project history

        -- Additional settings from AstroNvim/astrocore
        ignore_lsp = { "efm", "null-ls" }, -- Ignore specific LSP servers for root detection
        ignore_dirs = { "~/.cargo/*", "~/projects/backup/*" }, -- Ignore specific directories from root detection
        update_cwd = true, -- Automatically update the working directory
        scope_chdir = "global", -- Scope of directory change: "global", "tab", or "win"
      }

      -- Load the Telescope extension to work with project.nvim
      require("telescope").load_extension "projects"
    end,
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
