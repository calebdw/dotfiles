local M = {}

--- Get relative path to file
---
--- @param file string|nil The file to get the relative path for (default='%')
--- @return nil
function M.relative_path(file)
  file = file or '%'

  return vim.fn.fnamemodify(vim.fn.expand(file), ':p:~:.')
end

--- Create a floating window
function M.float(opts)
  local api = vim.api

  local buf = api.nvim_create_buf(false, true)

  api.nvim_set_option_value(buf, 'bufhidden', 'wipe')

  local width = api.nvim_get_option_value('columns')
  local height = api.nvim_get_option_value('lines')

  local win_height = math.ceil(height * 0.8 - 4)
  local win_width = math.ceil(width * 0.8)

  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  if opts == nil then
    opts = {
      style = 'minimal',
      relative = 'editor',
      width = win_width,
      height = win_height,
      row = row,
      col = col,
      border = 'rounded',
      -- noautocmd = true,
    }
  end

  for _, v in ipairs({ 'q', '<esc>' }) do
    M.map({ 'n', 'v' }, v, ':close<cr>', {
      buffer = buf,
      nowait = true,
    })
  end

  local win = api.nvim_open_win(buf, true, opts)

  return buf, win
end

--- Calls `<Esc>` in normal mode
---
--- Necessary for visual range to be updated before executing
--- visual keymaps
---
--- @return nil
function M.escape()
  vim.cmd.normal('�')
end

--- Wrapper around `vim.keymap.set` to include defaults
---
---@see vim.keymap.set()
---
---@param modes string|table the keymap mode
---@param lhs string left hand side
---@param rhs string|function right hand side
---@param opts nil|table options
function M.map(modes, lhs, rhs, opts)
  local defaults = {
    silent = true,
    noremap = true,
    expr = false,
    -- unique = true,
  }
  vim.keymap.set(modes, lhs, rhs, vim.tbl_extend('force', defaults, opts or {}))
end

--- This proxies a command through `sail` if it is installed.
---
--- @param cmd string
--- @param as_string boolean
--- @return string|string[]
function M.sail_or_bin(cmd, as_string)
  local sail = './vendor/bin/sail'

  if vim.fn.executable(sail) == 1 then
    local result = { sail, 'bin', cmd }
    if as_string then
      return table.concat(result, ' ')
    end

    return result
  end

  return './vendor/bin/' .. cmd
end

return M
