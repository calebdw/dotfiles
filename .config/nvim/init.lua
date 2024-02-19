-- Impatient
local ok, impatient = pcall(require, 'impatient')
if ok then
  impatient.enable_profile()
end

-- Disable plugins
-- Might not need these anymore with Lazy?
local disabled_builtins = {
  'netrw',
}

for _, name in pairs(disabled_builtins) do
  vim.g['loaded_' .. name] = 1
end

-- disable perl provider
vim.g.loaded_perl_provider = 0

-- Load modules
require('user')
