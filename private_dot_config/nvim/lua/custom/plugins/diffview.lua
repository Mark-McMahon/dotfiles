-- diffview.nvim — a "review everything before a PR" view.
-- Opens a panel listing every changed file; select a file to see its diff.
-- https://github.com/sindrets/diffview.nvim

-- 1. Download/register the plugin using Neovim's built-in package manager
--    (same `vim.pack.add` mechanism kickstart uses everywhere else).
vim.pack.add { 'https://github.com/sindrets/diffview.nvim' }

-- 2. Start the plugin with its default settings. Defaults are good;
--    we don't need to customize anything to get the file-list + diff view.
require('diffview').setup {}

-- 3. Keymaps, all under the `<leader>g` ("git") prefix. Leader is Spacebar,
--    so e.g. `<leader>gd` means: press Space, then g, then d.
local map = vim.keymap.set

-- Review all UNCOMMITTED changes (working tree vs the last commit).
map('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', { desc = 'git [d]iff: uncommitted changes' })

-- Review the WHOLE BRANCH vs main — this is the pre-PR review view.
-- NOTE: if your repo's base branch is `master`, change `main` below to `master`.
map('n', '<leader>gm', '<cmd>DiffviewOpen main...HEAD<cr>', { desc = 'git diff: branch vs [m]ain' })

-- Close the diffview tab when you're done reviewing.
map('n', '<leader>gc', '<cmd>DiffviewClose<cr>', { desc = 'git diff: [c]lose' })

-- Bonus: browse the commit history (and diffs) of the file you're in.
map('n', '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', { desc = 'git diff: file [h]istory' })

-- 4. Tell which-key the `<leader>g` prefix is a labeled group, so when you
--    press Space+g and pause, the popup menu shows "Git diff" with the keys above.
pcall(function()
  require('which-key').add { { '<leader>g', group = '[G]it diff' } }
end)
