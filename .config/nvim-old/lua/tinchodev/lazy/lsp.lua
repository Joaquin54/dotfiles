return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
    "rafamadriz/friendly-snippets",
    "Myriad-Dreamin/tinymist",
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()

    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    capabilities.textDocument.completion.completionItem.snippetSupport = true

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "clangd",
        "jdtls",
        "html",
        "cssls",
        "emmet_ls",
        "basedpyright",         -- replaced pyright
        "pylsp",
        "ts_ls",
        "jsonls",
        "tailwindcss",
        "tinymist",
      },
      handlers = {
        function(server_name)
          vim.lsp.config[server_name] = {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              local opts = { buffer = bufnr, silent = true }
              vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
              vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
              vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
              vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
              vim.keymap.set("n", "<leader>ln", function() vim.diagnostic.goto_next() end, opts)
              vim.keymap.set("n", "<leader>lp", function() vim.diagnostic.goto_prev() end, opts)
              vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
              vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
              vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
              vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end,
          }
        end,
      }
    })

    -- Java: 4-space indentation (C/C++ and everything else keep the global default).
    -- JDTLS formatting picks this up too, since vim.lsp.buf.format() sends shiftwidth as tabSize.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.expandtab = true
      end,
    })

    -- jdtls: use the formatter profile in ~/.config/nvim/java-format.xml
    -- (one-line simple methods/getters/setters, 4-space indent, 120-char line limit).
    -- Function-call form so the shared on_attach keymaps are kept.
    vim.lsp.config("jdtls", {
      settings = {
        java = {
          format = {
            enabled = true,
            settings = {
              url = vim.fn.stdpath("config") .. "/java-format.xml",
              profile = "NvimJava",
            },
          },
        },
      },
    })

    -- basedpyright
    -- Function-call form merges with the handler's config (keeps the shared on_attach keymaps)
    -- instead of replacing it the way `vim.lsp.config.basedpyright = { ... }` does.
    vim.lsp.config("basedpyright", {
      capabilities = capabilities,
      settings = {
        basedpyright = {
          typeCheckingMode = "standard",
          reportUnreachable = false,
        }
      }
    })

    -- clangd
    vim.lsp.config.clangd = {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
      end,
      cmd = { "clangd", "--background-index" },
      filetypes = { "c", "cpp", "objc", "objcpp" },
    }

    -- ts_ls
    vim.lsp.config.ts_ls = {
      capabilities = capabilities,
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      on_attach = function(client, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
      end,
    }

    -- TailwindCSS
    vim.lsp.config.tailwindcss = {
      capabilities = capabilities,
      filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescriptreact", "tsx", "jsx" },
    }

    -- cmp setup
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
      }),
    })

    vim.diagnostic.config({
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end,
}
