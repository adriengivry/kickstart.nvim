return {
  'stevearc/overseer.nvim',
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  config = function()
    vim.keymap.set('n', '<leader>ot', '<cmd>OverseerToggle<CR>')
    vim.keymap.set('n', '<leader>or', '<cmd>OverseerRun<CR>')
    vim.keymap.set('n', '<leader>os', '<cmd>OverseerShell<CR>')
  end,
  opts = {},
}
