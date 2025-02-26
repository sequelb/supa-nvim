-- sets up lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  --beyond Vhyrro's tutorial

  --Neogit
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      -- Only one of these is needed.
      "ibhagwan/fzf-lua",            -- optional
    },
    config = true
  },

  {
    "catppuccin/nvim",
    config = function()
      -- vim.cmd.colorscheme("catppuccin-frappe")
    end
  },

  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require('nvim-highlight-colors').setup({})
    end
  },

  -- space+b
  {
    "j-morano/buffer_manager.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("buffer_manager").setup {}
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({})
    end
  },

  {
    "christoomey/vim-tmux-navigator",
  },

  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },

  {
    'echasnovski/mini.splitjoin',
    version = '*',
    config = function() require("mini.splitjoin").setup {} end
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      debounce = 100,
      indent = { char = "" },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        injected_languages = false,
        highlight = { "Function", "Label" },
        priority = 500,
      }
    },
  },

  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        columns = {
          "icon",
          "mtime",
        },
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-s>"] = "actions.select_vsplit",
          ["<C-h>"] = false,
          ["<C-t>"] = false,
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = false,
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
        },
        keymaps_help = {
          border = "rounded",
        },
        float = {
          -- Padding around the floating window
          padding = 2,
          max_width = 70,
          max_height = 40,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
        },
        use_default_keymaps = false,
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = true,
        }
      })
    end
  },

  {
    'nvim-tree/nvim-web-devicons'
  },
  --fzf try
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({ "fzf-native" })
    end
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },

  {
    'szw/vim-maximizer'
  },

  {
    'mrjones2014/smart-splits.nvim'
  },

  {
    'echasnovski/mini.notify',
    config = function()
      local win_config = function()
        local has_statusline = vim.o.laststatus > 0
        local bottom_space = vim.o.cmdheight + (has_statusline and 1 or 0)
        bottom_space = bottom_space / 2
        return { anchor = 'SE', col = vim.o.columns, row = vim.o.lines - bottom_space }
      end
      require('mini.notify').setup({ window = { config = win_config } })
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    opts = {},
  },

  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      direction = 'float',
      open_mapping = [[<c-t>]],
      float_opts = {
        border = 'curved',
        height = 80,
      },
    },
  },

  --================NVIM-CMP=+=LUASNIP
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },

    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      vim.opt.completeopt = { "menu", "menuone", "noselect" }
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
          ["<Tab>"] = cmp.mapping.confirm({ select = false }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ['<C-g>'] = function()
            if cmp.visible_docs() then
              cmp.close_docs()
            else
              cmp.open_docs()
            end
          end,

        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          -- { name = "nvim_lua" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),

        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "path" },
            { name = "cmdline" },
          }),
        }),
        formatting = {
          format = function(entry, vim_item)
            local kind_icons = {
              Text = "",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "",
              Field = "",
              Variable = "󰂡",
              Class = "󰠱",
              Interface = "",
              Module = "",
              Property = "󰜢",
              Unit = "",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "󰅲",
            }                                                                                -- From kind_icons array
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
            -- Source
            vim_item.menu = ({
              buffer = "[]",
              nvim_lsp = "[󰘧]",
              luasnip = "[]",
              nvim_lua = "[Lua]",
              latex_symbols = "[󰒠]",
            })[entry.source.name]
            return vim_item
          end
        },
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('lspconfig').clangd.setup({ capabilities = capabilities })
      require('lspconfig').html.setup({ capabilities = capabilities })
      require('lspconfig').cssls.setup({ capabilities = capabilities })

      --from https://www.andersevenrud.net/neovim.github.io/lsp/configurations/html/
      -- capabilities.textDocument.completion.completionItem.snippetSupport = true
      -- require'lspconfig'.html.setup {
      --   capabilities = capabilities,
      -- }
    end,
  },

  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require('lspsaga').setup({
        scroll_preview = { scroll_down = "<C-j>", scroll_up = "<C-k>" },
        definition = {
          edit = "<CR>", -- use enter to open file with definition preview
        },
        floaterm = {
          height = 0.85,
          width = 0.95,
        },
        symbol_in_winbar = {
          enable = false,
        },
      })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    },
  },

  {
    "ray-x/lsp_signature.nvim",
    cevent = "VeryLazy",
    opts = {
      hint_prefix = " ",
      hint_inline = function()
        return false;
      end,
      floating_window = false,
      hint_scheme = "Comment",
      toggle_key = '<M-x>'
    },
    config = function(_, opts) require 'lsp_signature'.setup(opts) end,
  },

  {
    "lvimuser/lsp-inlayhints.nvim",
    event = { "LspAttach", },
    config = function()
      require("lsp-inlayhints").setup()
    end
  },


  -- in Vhyrro's tutorial
  {
    "rebelot/kanagawa.nvim",
    config = function()
      vim.cmd.colorscheme("kanagawa-wave")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp" },

        auto_install = false,

        highlight = {
          enable = true,
          disable = function(lang, bufnr) -- Disable in large C++ buffers
            return lang == "cpp" and vim.api.nvim_buf_line_count(bufnr) > 5000
          end,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>ss",    --selection start
            node_incremental = "<leader>si",  --selection increment
            scope_incremental = "<leader>sc", --selection sCope
            node_decremental = "<leader>sd",  --selection decrement
          }
        },
        --textobjects
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V',  -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = true,
          },
        },
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.clangd.setup({}) --installed seperately
      -- not in tutorial v
      lspconfig.html.setup({})   -- idek what im doing atp
      lspconfig.cssls.setup({})
      -- not in tutorial ^
    end
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({})
      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      })
    end,
  }
})
