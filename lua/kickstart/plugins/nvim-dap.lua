return {
  'mfussenegger/nvim-dap',
  opts = {},
  config = function()
    local dap = require 'dap'

    -- codelldb adapter (installed via Mason)
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
        args = { '--port', '${port}' },
      },
    }

    -- C/C++ configurations
    dap.configurations.cpp = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
          local exe = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          vim.g.dap_last_executable = exe -- stash it for cwd
          return exe
        end,
        cwd = function() return vim.fn.fnamemodify(vim.g.dap_last_executable or vim.fn.getcwd(), ':h') end,
        stopOnEntry = false,
      },
    }

    dap.configurations.c = dap.configurations.cpp

    -- Default keymaps, as provided by nvim-dap
    vim.keymap.set('n', '<F5>', function() dap.continue() end)
    vim.keymap.set('n', '<F10>', function() dap.step_over() end)
    vim.keymap.set('n', '<F11>', function() dap.step_into() end)
    vim.keymap.set('n', '<F12>', function() dap.step_out() end)
    vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
    vim.keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end)
    vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ') end)
    vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
    vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)
    vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function() require('dap.ui.widgets').hover() end)
    vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function() require('dap.ui.widgets').preview() end)
    vim.keymap.set('n', '<Leader>df', function()
      local widgets = require 'dap.ui.widgets'
      widgets.centered_float(widgets.frames)
    end)
    vim.keymap.set('n', '<Leader>ds', function()
      local widgets = require 'dap.ui.widgets'
      widgets.centered_float(widgets.scopes)
    end)
    -- Custom keymaps
    vim.keymap.set({ 'n', 'v' }, '<Leader><F5>', function() dap.terminate() end)
  end,
}
