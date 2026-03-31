return {
  'stevearc/overseer.nvim',
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  config = function() vim.keymap.set('n', '<leader>o', '<cmd>OverseerToggle<CR>') end,
  opts = {},
}
