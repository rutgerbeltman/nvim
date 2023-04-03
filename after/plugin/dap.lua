local dap = require 'dap'
local dapui = require 'dapui'
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')

-- Basic debugging keymaps, feel free to change to your liking!
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = "[d]ebug [c]ontinue" })
vim.keymap.set('n', '<leader>ds', dap.step_into, { desc = "[d]ebug [s]tep-into" })
vim.keymap.set('n', '<leader>dn', dap.step_over, { desc = "[d]ebug [n]ext" })
vim.keymap.set('n', '<leader>du', dap.up, { desc = "[d]ebug [u]p" })
vim.keymap.set('n', '<leader>dd', dap.down, { desc = "[d]ebug [d]own" })
vim.keymap.set('n', '<leader>dq', dap.close, { desc = "[d]ebug [q]uit" })
vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "[d]ebug [b]reakpoint" })
vim.keymap.set('n', '<leader>dB', function()
   dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = "[d]ebug [B]reakpoint condition" })

-- Dap UI setup
-- For more information, see |:help nvim-dap-ui|
dapui.setup {
   -- Set icons to characters that are more likely to work in every terminal.
   --    Feel free to remove or use ones that you like more! :)
   --    Don't feel like these are good choices.
   icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
   controls = {
      icons = {
         pause = '⏸',
         play = '▶',
         step_into = '⏎',
         step_over = '⏭',
         step_out = '⏮',
         step_back = 'b',
         run_last = '▶▶',
         terminate = '⏹',
      },
   },
}

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close
