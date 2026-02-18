-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = true,
      inlay_hints = false,
      semantic_tokens = true,
    },
    formatting = {
      format_on_save = {
        enabled = true,
        allow_filetypes = {},
        ignore_filetypes = {},
      },
      disabled = {
        "ts_ls",
        "vtsls",
        "vts_ls",
      },
      timeout_ms = 1000,
    },
    servers = {},
    ---@diagnostic disable: missing-fields
    config = {
      vtsls = {
        settings = {
          vtsls = {
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = false,
                entriesLimit = 75,
              },
            },
          },
          typescript = {
            tsserver = {
              maxTsServerMemory = 8192,
              useSyntaxServer = "auto",
              watchOptions = {
                watchFile = "useFsEventsOnParentDirectory",
                watchDirectory = "useFsEvents",
                fallbackPolling = "dynamicPriorityPolling",
                excludeDirectories = {
                  "**/node_modules",
                  "**/.next",
                  "**/dist",
                  "**/.git",
                  "**/build",
                  "**/coverage",
                  "**/.turbo",
                  "**/.cache",
                },
              },
            },
            preferences = {
              importModuleSpecifier = "non-relative",
              includePackageJsonAutoImports = "off",
            },
            updateImportsOnFileMove = { enabled = "prompt" },
          },
          javascript = {
            tsserver = {
              maxTsServerMemory = 4096,
              useSyntaxServer = "auto",
              watchOptions = {
                watchFile = "useFsEventsOnParentDirectory",
                watchDirectory = "useFsEvents",
                fallbackPolling = "dynamicPriorityPolling",
                excludeDirectories = {
                  "**/node_modules",
                  "**/.next",
                  "**/dist",
                  "**/.git",
                  "**/build",
                  "**/coverage",
                },
              },
            },
          },
        },
      },
      eslint = {
        settings = {
          run = "onSave",
          codeActionOnSave = {
            enable = true,
            mode = "problems",
          },
        },
        on_attach = function(client, bufnr) client.server_capabilities.documentFormattingProvider = false end,
      },
    },
    handlers = {},
    autocmds = {
      lsp_codelens_refresh = {
        cond = "textDocument/codeLens",
        {
          event = { "InsertLeave", "BufEnter" },
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },
    mappings = {
      n = {
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },
      },
    },
    on_attach = function(client, bufnr) end,
  },
}
