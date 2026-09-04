-- Disable plugins
-- Might not need these anymore with Lazy?
local disabled_builtins = {
  'netrw',
}

for _, name in pairs(disabled_builtins) do
  vim.g['loaded_' .. name] = 1
end

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Load modules
require('calebdw')
