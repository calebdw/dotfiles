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

--- This recursively symlinks files from a src directory to a dest directory.
--- @param src string
--- @param dest string
--- @param relative? boolean
--- @param force? boolean
--- @return nil
function M.symlink_files(src, dest, relative, force)
  relative = relative ~= false
  force = force == true

  local Job = require('plenary.job')
  local Path = require('plenary.path')
  local scan = require('plenary.scandir')

  local src_path = Path:new(src)
  local dest_path = Path:new(dest)

  if not src_path:exists() then
    vim.notify('Shared directory does not exist: ' .. src, vim.log.levels.DEBUG)
    return
  end

  scan.scan_dir_async(src_path:absolute(), {
    hidden = true,
    add_dirs = false,
    on_insert = function(entry)
      local target = dest_path:joinpath(Path:new(entry):make_relative(src_path:absolute()))

      local args = { '-s' }
      if relative then table.insert(args, '-r') end
      if force then table.insert(args, '-f') end

      table.insert(args, entry)
      table.insert(args, target:absolute())

      Job:new({
        command = 'ln',
        args = args,
        on_exit = function(_, code)
          if code == 0 then return end
          vim.schedule(function()
            vim.notify(
              'Failed to symlink ' .. entry .. ' -> ' .. target:absolute(),
              vim.log.levels.ERROR
            )
          end)
        end,
      }):start()
    end,
  })
end

return M
