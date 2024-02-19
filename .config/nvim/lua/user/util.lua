local M = {}

--- Safely load config files by checking for module existence
-- prior to loading.
---@param opts (string|table) A table with the following variables
--     (if string then same as config below)
--         - config (string) The name of the config file
--         - deps (string|table, default={}) Any required dependencies in the config
--         - is_module (bool, default=true) Boolean determining if the config name is
--             a required module name in the config
function M.load_plugin_config(opts)
  if (opts == nil) then
    vim.notify('An argument is required!', vim.log.levels.ERROR, { title = 'load_plugin_config:' })
    return
  elseif (type(opts) == 'string') then
    opts = { config = opts }
  end

  if not opts.config then
    vim.notify('A config file must be provided!', vim.log.levels.ERROR, { title = 'load_plugin_config:' })
    return
  end

  opts.deps = opts.deps or {}
  if (type(opts.deps) == 'string') then
    opts.deps = { opts.deps }
  end

  if (opts.is_module == nil) then
    opts.is_module = true
  end
  if (opts.is_module == true) then
    table.insert(opts.deps, 1, opts.config)
  end

  for _, dep in pairs(opts.deps) do
    local ok, _ = pcall(require, dep)
    if not ok then
      vim.notify(
        'Failed to find module "' .. opts.dep .. '" when loading config "' .. opts.config .. '".',
        vim.log.levels.WARN,
        { title = 'load_plugin_config:' }
      )
      return
    end
  end

  return require('user.plugins.configs.' .. opts.config)
end

--- Get relative path to file
-- @param file (string, default='%') The file to get the relative path for
function M.relative_path(file)
  if (file == nil) then
    file = '%'
  end

  return vim.fn.fnamemodify(
    vim.fn.expand(file),
    ':p:~:.'
  )
end

--- Create a floating window
function M.float(opts)
  local api = vim.api

  local buf = api.nvim_create_buf(false, true)

  api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

  local width = api.nvim_get_option('columns')
  local height = api.nvim_get_option('lines')

  local win_height = math.ceil(height * 0.8 - 4)
  local win_width = math.ceil(width * 0.8)

  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  if (opts == nil) then
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
  vim.keymap.set(modes, lhs, rhs, vim.tbl_extend(
    'force',
    defaults,
    opts or {}
  ))
end

return M
