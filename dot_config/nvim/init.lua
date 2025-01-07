vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.keymap.set('n', '<Esc><Esc>', ':w<cr>')

vim.g.mapleader = ' '

vim.keymap.set('n', '<Leader>q', ':q<CR>', { silent = true, desc = "Leave!" })
vim.keymap.set('n', '<Return>', ':set hlsearch!<CR>', { silent = true, desc = "Toggle search highlighting" })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

require("lazy").setup({
  {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
      -- Move to previous/next
      vim.api.nvim_set_keymap('n', '<A-,>', '<Cmd>BufferPrevious<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<A-.>', '<Cmd>BufferNext<CR>', { silent = true, noremap = true })

      -- Re-order to previous/next
      vim.api.nvim_set_keymap('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<A->>', '<Cmd>BufferMoveNext<CR>', { silent = true, noremap = true })

      -- Goto buffer in position...
      vim.api.nvim_set_keymap('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<A-0>', '<Cmd>BufferLast<CR>', { silent = true, noremap = true })

      -- Pin/unpin buffer
      vim.api.nvim_set_keymap('n', '<A-p>', '<Cmd>BufferPin<CR>', { silent = true, noremap = true })

      -- Close buffer
      vim.api.nvim_set_keymap('n', '<A-c>', '<Cmd>BufferClose<CR>', { silent = true, noremap = true })
    end,
    opts = {
      animation = true,
      sidebar_filetypes = { ['neo-tree'] = { event = 'BufWipeout' } }
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-moon]])
    end,
  },
  {
    "lervag/vimtex",
    init = function()
      vim.g.vimtex_view_general_viewer = "okular"
      vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
      vim.g.vimtex_toc_config = { layers = { "content", "label", "todo" }, split_pos = "botright" }
    end
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  {
    "folke/neodev.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = "folke/neodev.nvim",
  },
  {
    "RRethy/vim-illuminate",
    lazy = false,
    opts = {
      delay = 100,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    opts = function(_, _)
      local luasnip = require 'luasnip'
      local cmp = require 'cmp'
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
      return {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        view = {
          entries = { name = 'custom', selection_order = 'near_cursor' }
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
              -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
              -- that way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
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
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'vimtex' },
        }, {
          { name = 'buffer' },
        })
      }
    end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'micangl/cmp-vimtex',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    }
  },
  { 'kevinhwang91/nvim-ufo',      dependencies = { 'kevinhwang91/promise-async' } },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  'kaarmu/typst.vim',
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git Explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer Explorer",
      },
    },

    opts = {
      close_if_last_window = true,
    }
  },
  { 'echasnovski/mini.bufremove', version = '*' },
})

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = '',
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require 'neodev'.setup {}

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local servers = { 'pyright', 'rust_analyzer', 'lua_ls', 'ts_ls', 'clangd', 'tinymist' }
local lspconfig = require('lspconfig')
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- lspconfig.tinymist.setup{
  -- offset_encoding = "utf-8",
  -- capabilities = capabilities
-- }

---@diagnostic disable-next-line: missing-fields
require('ufo').setup {
  provider_selector = function(_, _, _)
    return { 'treesitter', 'indent' }
  end
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<Leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<Leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- ufo fold config
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Open all folds" })
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "Close all folds" })
