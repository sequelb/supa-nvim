-- enables inlay hints
-- vim.api.nvim_create_autocmd("LspAttach", {
--     group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--     callback = function(args)
--         local client = vim.lsp.get_client_by_id(args.data.client_id)
--         if client.server_capabilities.inlayHintProvider then
--             vim.lsp.inlay_hint.enable(true)
--         end
--         -- whatever other lsp config you want
--     end
-- })

--https://www.reddit.com/r/neovim/comments/1c00cl0/comment/kytl2zv/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
-- Map arrow keys for wildmenu completion
--=================================================================================================
vim.api.nvim_set_keymap('c', '<C-j>', 'v:lua.get_wildmenu_key("<right>", "<Tab>")', { expr = true })
vim.api.nvim_set_keymap('c', '<C-k>', 'v:lua.get_wildmenu_key("<left>", "<S-Tab>")', { expr = true })
function _G.get_wildmenu_key(key_wildmenu, key_regular)
  return vim.fn.wildmenumode() ~= 0 and key_wildmenu or key_regular
end
--=================================================================================================

-- compiling and running C code
--=================================================================================================
function CompileAndRunInCurrentDirectory()
  local file_extension = vim.fn.expand('%:e')
  local file_path = vim.fn.expand('%:p:h')
  local cmd
  if file_extension == 'c' then
    cmd = string.format('cd %s && clang main.c -o main -lm && clear && ./main\n', file_path)
  elseif file_extension == 'cpp' then
    cmd = string.format('cd %s && clear && bear -- cmake --build build && clear && ./build/a.out\n', file_path)
  elseif file_extension == 'rs' then
    cmd = string.format('cd %s && clear && cargo run\n', file_path)
  else
    cmd = 'clear\n exit'
  end
  vim.cmd('w | Lspsaga term_toggle')
  vim.api.nvim_feedkeys(cmd, 'i', true)
end
--=================================================================================================


-- running C/C++ code
--=================================================================================================
function RunInCurrentDirectory()
  local file_extension = vim.fn.expand('%:e')
  local file_path = vim.fn.expand('%:p:h')
  local cmd
  if file_extension == 'c' then
    cmd = string.format('cd %s && clear && ./main\n', file_path)
  elseif file_extension == 'cpp' then
    cmd = string.format('cd %s && clear && ./build/a.out\n', file_path)
  elseif file_extension == 'rs' then
    cmd = string.format('cd %s && clear && cargo run\n', file_path)
  else
    cmd = 'clear\n exit'
  end
  vim.cmd('w | Lspsaga term_toggle')
  vim.api.nvim_feedkeys(cmd, 'i', true)
end
--=================================================================================================

-- building C/C++ code
--=================================================================================================
function BuildInCurrentDirectory()
  local file_extension = vim.fn.expand('%:e')
  local file_path = vim.fn.expand('%:p:h')
  local cmd
  if file_extension == 'c' then
    cmd = string.format('cd %s && clang main.c -o main -lm && clear && exit\n', file_path)
  elseif file_extension == 'cpp' then
    cmd = string.format('cd %s && clear && bear -- cmake --build build && clear && exit\n', file_path)
  elseif file_extension == 'rs' then
    cmd = string.format('cd %s && clear && cargo build\n', file_path)
  else
    cmd = 'clear\n exit'
  end
  vim.cmd('w | Lspsaga term_toggle')
  vim.api.nvim_feedkeys(cmd, 'i', true)
end
--=================================================================================================


--changing nvim opened directory to one of opened buffer
--=================================================================================================
function CdToCurrentDirectory()
    local file_path = vim.fn.expand('%:p:h')
    local cmd = string.format('cd %s ', file_path)
    vim.cmd('' .. cmd)
end
--=================================================================================================


--https://github.com/Bekaboo/dropbar.nvim/discussions/148
---Set WinBar & WinBarNC background to Normal background
---@return nil
local function clear_winbar_bg()
  ---@param name string
  ---@return nil
  local function _clear_bg(name)
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    if hl.bg or hl.ctermbg then
      hl.bg = nil
      hl.ctermbg = nil
      vim.api.nvim_set_hl(0, name, hl)
    end
  end

  _clear_bg('WinBar')
  _clear_bg('WinBarNC')
end

clear_winbar_bg()

vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('WinBarHlClearBg', {}),
  callback = clear_winbar_bg,
})
