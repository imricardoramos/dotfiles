return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
  "neovim/nvim-lspconfig",
   config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
   end,
  },
  {
   "williamboman/mason.nvim",
   opts = {
      ensure_installed = {
        "lua-language-server",
        "html-lsp",
        "prettier",
        "stylua",
        "elixir-ls"
      },
    },
  },
  { 'tanvirtin/monokai.nvim',
    config = function()
      require('monokai').setup {}
    end,
  },
  {
	"L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp"
  },
  {"norcalli/nvim-colorizer.lua",
    config = function()
    require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        })
    end,
  },
  {"nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "jfpedroza/neotest-elixir"
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-elixir")
        }
      })
    end
  },
  {
    'nvim-orgmode/orgmode',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', lazy = true },
    },
    event = 'VeryLazy',
    config = function()
      -- Setup treesitter
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'org' },
        },
        ensure_installed = { 'org' },
      })

      -- Setup orgmode
      require('orgmode').setup({
        org_hide_emphasis_markers = true,
        org_agenda_files = '~/Sync/org/*',
        org_default_notes_file = '~/Sync/org/inbox.org',
      })
    end,
  },
  {'akinsho/org-bullets.nvim', config = function()
    require('org-bullets').setup()
  end
  },
  {'tpope/vim-fugitive'},
  {'tpope/vim-rhubarb'},
  {'tpope/vim-abolish'},
  {'tpope/vim-projectionist',
    config = function()
      vim.g.projectionist_heuristics = {
        ["*"] = {
          ["lib/*.ex"] = {
            type = "src",
            alternate = "test/{}_test.exs"
          },
          ["test/*_test.exs"] = {
            type = "test",
            alternate = "lib/{}.ex",
          }
        }
      }
  end},
  { "folke/trouble.nvim",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   opts = {},
  },
  { "adalessa/telescope-projectionist.nvim" },
  {
    "jackMort/ChatGPT.nvim",
      event = "VeryLazy",
      config = function()
        require("chatgpt").setup({
        api_key_cmd = "rbw get OpenAI -f chatgpt.nvim_key",
        openai_params = { 
         model = "gpt-4o", 
         frequency_penalty = 0, 
         presence_penalty = 0, 
         max_tokens = 256, 
         temperature = 0.6, 
         top_p = 0.7, 
         n = 1, 
       }, 
       openai_edit_params = { 
         model = "gpt-4o", 
         frequency_penalty = 0, 
         presence_penalty = 0, 
         temperature = 0.6, 
         top_p = 0.7, 
         n = 1, 
       }
      })
      end,
      dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
        "nvim-telescope/telescope.nvim"
      }
  },
  {
   "simrat39/rust-tools.nvim",
    -- ft = { "rust", "rs" }, -- IMPORTANT: re-enabling this seems to break inlay-hints
    config = function()
      require("rust-tools").setup {
        tools = {
          executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
          reload_workspace_from_cargo_toml = true,
          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "<-",
            other_hints_prefix = "=>",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          hover_actions = {
            border = {
              { "╭", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╮", "FloatBorder" },
              { "│", "FloatBorder" },
              { "╯", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╰", "FloatBorder" },
              { "│", "FloatBorder" },
            },
            auto_focus = true,
          },
        },
        server = {
          on_init = require("lvim.lsp").common_on_init,
          on_attach = function(client, bufnr)
            require("lvim.lsp").common_on_attach(client, bufnr)
            local rt = require "rust-tools"
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<leader>lA", rt.code_action_group.code_action_group, { buffer = bufnr })
            print("rust-tools attached")
          end,
          settings = {
            ['rust-analyzer'] = {
              cargo = {
                features = "all"
              },
              checkOnSave = {
                features = "all"
              }
            }
          }
        },
      }
    end,
  },
  {"elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup {
        nextls = {enable = true},
        credo = {},
        elixirls = {
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = false,
            enableTestLenses = false,
          },
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        }
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
