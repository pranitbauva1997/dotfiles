--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/

  And then you can explore or search through `:help lua-guide`


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-sleuth',

  -- LSP Stack
  {
    "williamboman/mason.nvim",
    config = true, -- Ensures mason.setup() is called
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'folke/neodev.nvim',
    },
    config = function()
      -- Must be run AFTER lspconfig. This will be automatically done due to dependency
      require('neodev').setup({
        library = { plugins = { "nvim-dap-ui" }, types = true },
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
    config = function()
      -- This function is the core of the LSP setup
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local on_attach = function(client, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end

      local servers = {
        clangd = {},
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = { unusedparams = true },
          staticcheck = true,
          gofumpt = true,
        },
        pyright = {},
        ts_ls = {},
        cmake = {},
        cssls = {},
        docker_compose_language_service = {},
        dockerls = {},
        elmls = {},
        eslint = {},
        html = {},
        -- pyre = {},
        rust_analyzer = {},
        terraformls = {},
        tflint = {},
        astro = {},
        awk_ls = {},
        -- bashls = {},
        -- grammarly = {},
        helm_ls = {},
        ruff = {},
        sqlls = {},
        tailwindcss = {},
        vimls = {},
        svelte = {},
        ansiblels = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          }
        },
      }

      -- Get the list of servers to install from the keys of the servers table
      local ensure_installed = vim.tbl_keys(servers)
      -- Manually add eslint to the list of servers to install
      table.insert(ensure_installed, "eslint")

      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        handlers = {
          -- This is the generic handler for all servers except eslint
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = servers[server_name] and servers[server_name].settings or nil,
            })
          end,
          -- START of the fix for ESLint
          -- This is a dedicated handler for eslint.
          ["eslint"] = function()
            require("lspconfig").eslint.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              -- This is the new, more robust root directory detection
              root_dir = require('lspconfig.util').root_pattern("eslint.config.js", "package.json"),
              settings = {
                experimental = {
                  useFlatConfig = true,
                },
              },
            })
          end,
          -- END of the fix for ESLint
        },
      })
    end,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
      }
    end,
  },

  -- Other plugins
  { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
  { 'folke/which-key.nvim', opts = {} },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },
  {
    'bluz71/vim-moonfly-colors',
    name = "moonfly",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'moonfly'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  { 'lukas-reineke/indent-blankline.nvim', main = "ibl", opts = {} },
  { 'numToStr/Comment.nvim', opts = {} },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = { ['<C-u>'] = false, ['<C-d>'] = false },
          },
        },
      }
      pcall(require('telescope').load_extension, 'fzf')
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', 'windwp/nvim-ts-autotag' },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'astro', 'bash', 'c', 'cpp', 'cmake', 'css', 'dart', 'diff', 'dockerfile', 'go',
          'git_config', 'git_rebase', 'gitcommit', 'gitignore', 'gomod', 'gosum', 'gowork',
          'haskell', 'html', 'htmldjango', 'http', 'javascript', 'java', 'json', 'ledger',
          'make', 'markdown', 'markdown_inline', 'scss', 'sql', 'svelte', 'lua', 'python',
          'rust', 'toml', 'tsx', 'vue', 'typescript', 'vimdoc', 'vim'
        },
        auto_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['aa'] = '@parameter.outer', ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer', ['if'] = '@function.inner',
              ['ac'] = '@class.outer', ['ic'] = '@class.inner',
            },
          },
        },
      }

      -- Configure nvim-ts-autotag
      require("nvim-ts-autotag").setup({
        filetypes = {
          "html",
          "javascript",
          "typescript",
          "jsx",
          "tsx",
          "svelte",
          "vue",
        }
      })

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.zimbu = {
        install_info = {
          url = "~/projects/tree-sitter-zimbu",
          files = { "src/parser.c" },
          branch = "main",
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = "zu",
      }
    end,
  },
  { 'nvim-neotest/nvim-nio', lazy = true },
  { "mfussenegger/nvim-dap" },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()'
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        view = {
          side = "right",
        },
      })
    end,
  },
  { "nvim-tree/nvim-web-devicons" },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {},
  },
  { "MunifTanjim/nui.nvim" },

}, {})

-- [[ Setting options ]]
vim.o.hlsearch = false
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true

-- [[ Basic Keymaps ]]
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Telescope Keymaps ]]
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>sfg', require('telescope.builtin').git_files, { desc = '[S]earch [G]it [F]iles' })
vim.keymap.set('n', '<leader>sff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Nvim-Tree Keymaps ]]
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- [[ Diagnostic keymaps ]]
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ DAP Keymaps ]]
vim.api.nvim_set_keymap('n', '<leader>db', '<Cmd>lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true, desc = 'Toggle debug breakpoint' })
vim.api.nvim_set_keymap('n', '<leader>dc', '<Cmd>lua require"dap".continue()<CR>', { noremap = true, silent = true, desc = 'Debug continue' })
vim.api.nvim_set_keymap('n', '<leader>dso', '<Cmd>lua require"dap".step_over()<CR>', { noremap = true, silent = true, desc = 'Debug step over' })
vim.api.nvim_set_keymap('n', '<leader>dsi', '<Cmd>lua require"dap".step_into()<CR>', { noremap = true, silent = true, desc = 'Debug step into' })
vim.api.nvim_set_keymap('n', '<leader>drpl', '<Cmd>lua require"dap".step_into()<CR>', { noremap = true, silent = true, desc = 'Debug REPL open' })
vim.api.nvim_set_keymap('n', '<leader>dus', '<Cmd>lua require"dapui".toggle()<CR>', { noremap = true, silent = true, desc = 'Debug UI' })
vim.api.nvim_set_keymap('n', '<leader>dt', '<Cmd>lua require"dap-go".debug_test()<CR>', { noremap = true, silent = true, desc = 'Debug Test' })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
