local def_opts = { noremap = true, silent = true }
local term_opts = { silent = true}
local keymap = vim.keymap.set

vim.g.mapleader = " "

keymap("i", "jk", "<Esc>", def_opts)
keymap("i", "jk", "<Esc>", def_opts)
keymap("i", "kj", "<Esc>", def_opts)
keymap("t", "jk", "<C-\\><C-n>", def_opts) -- set jk up in terminal

keymap("i", "<C-;>", "<C-c>ddO", def_opts);
keymap("n", "<C-;>", "ddO", def_opts);

-- stole from https://www.reddit.com/r/neovim/comments/px7o11/comment/hentw61/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
keymap('n', '<bs>', '<c-^>\'”zz', def_opts)

keymap("n", "Y", "y$")
-- keymap("n", "<c-f>", '<nop>', term_opts)
-- keymap("n", "<c-f><c-w>", ':w<CR>', term_opts)
-- keymap("n", "<c-f><c-q>", ':q<CR>', term_opts)

keymap("n", "x", '"_x', term_opts) --x and X don't copy to clipboard
keymap("n", "X", '"_X', term_opts)

keymap("n", "<leader>nh", "<cmd>nohl<CR>", term_opts)
keymap("n", "U", "<C-r>", term_opts)
keymap("n", "<leader>wl", "<C-w>v", defopts) -- vertical split|window l(left)
keymap("n", "<leader>wj", "<C-w>s", defopts) -- horizontal split|window j(down)
keymap("n", "<leader>we", "<C-w>=", defopts) -- equal split
keymap("n", "<leader>wx", "<cmd>close<CR>", defopts) -- close window


keymap("n", "<leader>to", "<cmd>tabnew<CR>", defopts) --new tab
keymap("n", "<leader>tx", "<cmd>tabclose<CR>", defopts) -- close current tab
keymap("n", "<leader>tn", "<cmd>tabn<CR>", defopts) -- go to next tab 
keymap("n", "<leader>tp", "<cmd>tabp<CR>", defopts) -- go to previous tab


--H and L to go to first/last char of line
keymap("n", "L", "$")
keymap("n", "H", "^")
keymap("v", "L", "$")
keymap("v", "H", "^")
keymap("o", "L", "$")
keymap("o", "H", "^")

--open neovim config (nvim /lua)
keymap('n', '<leader><F26>', '<cmd>Oil ~/.config/nvim/lua/<CR>')

--=== stolen from theprimeagen :)
keymap("v", "J", ":m '>+1<CR>gv=gv", {silent = true})
keymap("v", "K", ":m '<-2<CR>gv=gv", {silent = true})

keymap("n", "J", "mzJ'z")
keymap("n", "<c-d>", "<c-d>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

keymap("x", "<leader>p", "\"_dP")

--what an atrocity
keymap("n", "<leader>rr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
--==========================SCRIPTS  KEYMAPS====================================
keymap('n', '<F6>', '<cmd>:lua CompileAndRunInCurrentDirectory()<CR>')
keymap('n', '<F7>', '<cmd>:lua RunInCurrentDirectory()<CR>')
keymap('n', '<F8>', '<cmd>:lua BuildInCurrentDirectory()<CR>')
keymap('n', '<leader>cd', '<cmd>:lua CdToCurrentDirectory()<CR>')
--===========================PLUGINKEYMAPS=====================================
--window maximizer
keymap("n", "<leader>wm", "<cmd>:MaximizerToggle<CR>")

--buffer_manager

keymap('n', '<leader>b', "<cmd>lua require('buffer_manager.ui').toggle_quick_menu()<CR>", def_opts)
keymap('n', '<leader>]', "<cmd>lua require('buffer_manager.ui').nav_next()<CR>", def_opts)
keymap('n', '<leader>[', "<cmd>lua require('buffer_manager.ui').nav_prev()<CR>", def_opts)

--telescope
-- keymap('n', '<leader>ff', "<cmd>Telescope find_files<CR>")
-- keymap('n', '<leader>fs', "<cmd>Telescope current_buffer_fuzzy_find<CR>")
-- keymap('n', '<leader>pd', "<cmd>Telescope diagnostics<CR>")
-- keymap('n', '<leader>fb', "<cmd>Telescope buffers<CR>")
-- keymap('n', '<leader>fg', "<cmd>Telescope grep_string<CR>")
-- keymap('n', '<leader>fr', "<cmd>Telescope resume<CR>")

--fzf-lua
keymap('n', '<leader>ff', "<cmd>FzfLua files<CR>")
keymap('n', '<leader>fs', "<cmd>FzfLua grep_curbuf<CR>")
keymap('n', '<leader>pd', "<cmd>FzfLua diagnostics_workspace<CR>")
keymap('n', '<leader>fb', "<cmd>FzfLua buffers<CR>")
keymap('n', '<leader>fd', "<cmd>FzfLua lsp_document_symbols<CR>")
keymap('n', '<leader>fr', "<cmd>FzfLua resume<CR>")

--oil.nvim
keymap('n', '<leader>i', '<cmd>:Oil --float<CR>')

--smart-splits
keymap('n', '<A-h>', require('smart-splits').resize_left)
keymap('n', '<A-j>', require('smart-splits').resize_down)
keymap('n', '<A-k>', require('smart-splits').resize_up)
keymap('n', '<A-l>', require('smart-splits').resize_right)

-- swapping buffers between windows
keymap('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
keymap('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
keymap('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
keymap('n', '<leader><leader>l', require('smart-splits').swap_buf_right)

--Lspsaga
local lspsaga_opts = { noremap = true, silent = true, buffer = bufnr }
-- keymaps using builtin vim.lsp.buf and vim.diagnostic functions
-- keymaps using builtin vim.lsp.buf and vim.diagnostic functions
-- keymap("n", "gd", "<Cmd>lua vim.lsp.buf.declaration()<CR>", lspsaga_opts) -- got to declaration
-- keymap("n", "gd", "<Cmd>lua vim.lsp.buf.declaration()<CR>", lspsaga_opts) -- got to declaration
-- keymap("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", lspsaga_opts) -- see definition and make edits in window
-- keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", lspsaga_opts) -- go to implementation
-- keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", lspsaga_opts) -- see available code actions
-- keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", lspsaga_opts) -- smart rename
-- keymap("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", lspsaga_opts) -- show  diagnostics for line
-- keymap("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", lspsaga_opts) -- show diagnostics for cursor
-- keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", lspsaga_opts) -- jump to previous diagnostic in buffer
-- keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", lspsaga_opts) -- jump to next diagnostic in buffer
-- keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", lspsaga_opts) -- show documentation for what is under cursor
-- keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", lspsaga_opts) -- see outline on right hand side
-- keymap("n", "<leader>=", "<cmd>lua vim.lsp.buf.format()<CR>", lspsaga_opts) -- see outline on right hand side
-- same but for lspsaga

keymap("n", "gf", "<cmd>Lspsaga finder<CR>", lspsaga_opts) -- show definition, references
keymap("n", "gd", "<Cmd>Lspsaga peek_definition<CR>", lspsaga_opts) -- got to declaration

keymap("n", "gD", "<cmd>Lspsaga goto_definition<CR>", lspsaga_opts) -- see definition and make edits in window
keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", lspsaga_opts) -- see available code actions

keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", lspsaga_opts) -- smart rename
keymap("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", lspsaga_opts) -- show  diagnostics for line
keymap("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", lspsaga_opts) -- show diagnostics for cursor
keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", lspsaga_opts) -- jump to previous diagnostic in buffer
keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", lspsaga_opts) -- jump to next diagnostic in buffer
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", lspsaga_opts) -- show documentation for what is under cursor
keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", lspsaga_opts) -- see outline on right hand side
keymap("n", "<leader>=", "<cmd>lua vim.lsp.buf.format()<CR>", lspsaga_opts) -- see outline on right hand side

--Toggling inlay hints
keymap("n",  "<leader>hh", ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>", def_opts)

--Opening lspsaga terminal 
--change to toggleterm!
-- keymap('n', '<leader>tt', '<cmd>:Lspsaga term_toggle<CR>')
keymap('n', '<leader>tt', '<cmd>:ToggleTerm<CR>')


