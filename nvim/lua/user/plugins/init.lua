local map = require('user.util').map

-- List of many Neovim plugins:
-- https://github.com/rockerBOO/awesome-neovim

return { -- General
  'lewis6991/impatient.nvim', -- Super fast loading times through caching---must be loaded first in init.lua
  'nvim-lua/plenary.nvim', -- common dependency
  -- Subvert - awesome search/replace - :Subvert/child{,ren}/adult{,s}/g
  -- Coercion - turn fooBar into foo_bar (and many others)
  'tpope/vim-abolish',
  'tpope/vim-speeddating', -- Tools for datatimes
  'tpope/vim-eunuch', -- Unix shell commands for current buffer/window
  'tpope/vim-unimpaired', -- Complementary pairs of mappings []
  'tpope/vim-repeat', -- Enables . repeat for some plugins
  'tpope/vim-dadbod', -- database interface
  -- replace with 'kylechui/nvim-surround'
  'tpope/vim-surround', -- Easily changes surrounding chars ('' to [])
  'tpope/vim-sleuth', -- Auto sets indentation rules, respects EditorConfig
  -- 'tpope/vim-jdaddy', -- JSON formatter?
  -- 'tpope/vim-ragtag', -- Set of mappings for HTML, XML, PHP, JSP, etc
  -- 'machakann/vim-sandwhich', -- Alt to vim-surround
  -- 'ur4ltz/surround.nvim',
  'machakann/vim-swap', -- Swaps args in a function call
  'triglav/vim-visual-increment', -- Increments columns of numbers
  -- 'svermeulen/vim-cutlass', -- changes how delete works
  -- 'svermeulen/vim-yoink', -- changes how yank works
  -- 'svermeulen/vim-subversive', -- changes how yank works
  'farmergreg/vim-lastplace', -- Remembers cursor position in files
  'junegunn/vim-easy-align', -- align text
  'nelstrom/vim-visual-star-search', -- use * to search visual text
  'jessarcher/vim-heritage', -- auto create non-existant dirs
  'sickill/vim-pasta', -- auto indent when pasting (may need to exclude fugitive)
  'famiu/bufdelete.nvim', -- delete buffers without closing window
  { -- Switch between single and multi line statements --
    -- update to neovim --
    -- 'Wansmer/treesj'
    'andrewradev/splitjoin.vim',
    config = function()
      vim.g.splitjoin_html_attributes_brackets_on_new_line = 1
      vim.g.splitjoin_trailing_comma = 1
      vim.g.splitjoin_php_method_chain_full = 1
    end,
  },
  {
    'voldikss/vim-browser-search',
    init = function()
      map('n', '<leader>s', '<Plug>SearchNormal', {desc = 'Normal Web [S]earch'})
      map('v', '<leader>s', '<Plug>SearchVisual', {desc = 'Visual Web [S]earch'})
      vim.g.browser_search_engines = {
        brave = 'https://search.brave.com/search?q=%s',
      }
      vim.g.browser_search_default_engine = 'brave'
    end,
  },

  -- Inspect these plugins ---
  -- 'whatyouhide/vim-textobj-xmlattr'
  --     dependencies = 'kana/vim-textobj-user'


  -- FZF
  -- 'ibhagwan/fzf-lua',


  -- LaTeX --
  {
    'lervag/vimtex',
    enabled = false
  },


  -- Annotation Toolkit --
  -- use 'danymat/neogen'


  -- Remote Development --
  -- @todo - Setup
  -- use 'chipsenkbeil/distant.nvim' -- Work on remote machine with local environment
  {
    -- Dev inside Docker containers
    'jamestthompson3/nvim-remote-containers',
  },


  {
    'neomake/neomake',
    {
      'radenling/vim-dispatch-neovim',
      dependencies = 'tpope/vim-dispatch',
    },
  },

  -- Quickfix --
  -- {
  --   'kevinhwang91/nvim-bqf',
  --   ft = 'qf',
  -- },
  -- {
  --   'junegunn/fzf',
  --   build = function()
  --     vim.fn['fzf#install']()
  --   end
  -- },


  -- Games --
  { 'alec-gibson/nvim-tetris',    cmd = 'Tetris' },
  { 'seandewar/nvimesweeper',     cmd = 'Nvimesweeper' },
  { 'seandewar/killersheep.nvim', cmd = 'KillKillKill' },
}
