local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>po', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>ca', "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = 'Code Action' })
