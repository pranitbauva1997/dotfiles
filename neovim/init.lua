-- [[ General Settings ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt
opt.hlsearch = false
opt.number = true
opt.relativenumber = true
opt.mouse = 'a'
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = 'yes'
opt.updatetime = 250
opt.timeoutlen = 300
opt.completeopt = 'menuone,noselect'
opt.termguicolors = true
opt.autoread = true
opt.foldmethod = 'indent'
opt.foldenable = true
opt.foldlevel = 99

-- [[ Plugin Manager Setup ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Core/Utilities
  'tpope/vim-fugitive',
  'tpope/vim-sleuth',
  'folke/which-key.nvim',
  'MunifTanjim/nui.nvim',
  { 'kylechui/nvim-surround', version = "*", event = "VeryLazy", config = true },
  { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },

  -- UI & Visuals
  { 'bluz71/vim-moonfly-colors', name = "moonfly", priority = 1000, config = function() vim.cmd.colorscheme 'moonfly' end },
  { 'nvim-lualine/lualine.nvim', opts = { options = { icons_enabled = false, component_separators = '|', section_separators = '' } } },
  { 'lewis6991/gitsigns.nvim', opts = { signs = { add = { text = '+' }, change = { text = '~' }, delete = { text = '_' }, topdelete = { text = '‾' }, changedelete = { text = '~' } } } },
  { 'nvim-tree/nvim-tree.lua', config = function() require("nvim-tree").setup({ view = { side = "right" } }) end },
  'nvim-tree/nvim-web-devicons',

  -- Navigation (Telescope)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim', { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
    config = function()
      require('telescope').setup { defaults = { mappings = { i = { ['<C-u>'] = false, ['<C-d>'] = false } } } }
      pcall(require('telescope').load_extension, 'fzf')
    end,
  },

  -- Treesitter (Highlighting)
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', 'windwp/nvim-ts-autotag' },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'go', 'lua', 'python', 'rust', 'typescript', 'tsx', 'javascript', 'bash', 'html', 'css', 'json', 'markdown', 'dockerfile' },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
      }
    end,
  },

  -- LSP Stack & Autocompletion
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'folke/neodev.nvim', 'hrsh7th/nvim-cmp', 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      require('neodev').setup()
      require('mason').setup()

      local on_attach = function(client, bufnr)
        local nmap = function(keys, func, desc) vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc }) end
        nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
        nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
        nmap('gd', vim.lsp.buf.definition, 'Goto Definition')
        nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", { buffer = bufnr, callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end })
        end
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local servers = { gopls = {}, pyright = {}, ts_ls = {}, rust_analyzer = {}, lua_ls = { settings = { Lua = { workspace = { checkThirdParty = false } } } } }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup { capabilities = capabilities, on_attach = on_attach, settings = servers[server_name] }
          end,
          ['eslint'] = function()
            require('lspconfig').eslint.setup { capabilities = capabilities, on_attach = on_attach, root_dir = require('lspconfig.util').root_pattern("package.json", "eslint.config.js"), settings = { experimental = { useFlatConfig = true } } }
          end,
        }
      }

      local cmp = require 'cmp'
      cmp.setup {
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
          ['<C-Space>'] = cmp.mapping.complete {},
        },
        sources = { { name = 'nvim_lsp' } },
      }
    end,
  },

  -- Debugging & Language Specific
  { "mfussenegger/nvim-dap", dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text", "leoluz/nvim-dap-go" },
    config = function()
      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()
      require("dap-go").setup()
    end
  },
  { "ray-x/go.nvim", dependencies = { "neovim/nvim-lspconfig", "nvim-treesitter/nvim-treesitter" }, config = true, event = { "CmdlineEnter" }, ft = { "go", 'gomod' } },

}, {})

-- [[ Clipboard Sync (OSC 52) ]]
vim.opt.clipboard = 'unnamedplus'
vim.g.clipboard = {
  name = 'OSC 52',
  copy = { ['+'] = require('vim.ui.clipboard.osc52').copy('+'), ['*'] = require('vim.ui.clipboard.osc52').copy('*') },
  paste = { ['+'] = require('vim.ui.clipboard.osc52').paste('+'), ['*'] = require('vim.ui.clipboard.osc52').paste('*') },
}
vim.keymap.set('v', '<C-c>', '"+y')

-- [[ Custom Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', { callback = function() vim.highlight.on_yank() end, group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }), pattern = '*' })
vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter', 'CursorHold'}, { command = "if mode() != 'c' | checktime | endif", pattern = {'*'} })

-- [[ Keymaps ]]
local function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { desc = desc }) end
map('n', '<leader>n', ':NvimTreeToggle<CR>', 'Toggle Tree')
map('n', '<leader>sff', require('telescope.builtin').find_files, 'Search Files')
map('n', '<leader>sg', require('telescope.builtin').live_grep, 'Search by Grep')
map('n', '<leader>sw', require('telescope.builtin').grep_string, 'Search current Word')
map('n', '<leader>db', function() require"dap".toggle_breakpoint() end, 'Debug Breakpoint')
map('n', '<leader>dc', function() require"dap".continue() end, 'Debug Continue')
map('n', '<leader>dus', function() require"dapui".toggle() end, 'Debug UI')

-- Go Specific
vim.api.nvim_create_autocmd('FileType', { pattern = 'go', callback = function()
    vim.bo.softtabstop = 4; vim.bo.tabstop = 4; vim.bo.shiftwidth = 4; vim.bo.expandtab = false
end })
