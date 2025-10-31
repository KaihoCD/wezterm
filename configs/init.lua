local config = require('configs.settings')
local cache = require('configs.cache')

local M = {}

local function setup_config()
    cache.init_cache({ 'themes' }, config)
    local cache_data = cache.load_cache()
    local merged_data = {}
    for k, v in pairs(config or {}) do
        merged_data[k] = v
        if cache_data and cache_data[k] ~= nil then
            merged_data[k] = cache_data[k]
        end
    end
    _G.configs = merged_data
end

-- setup config on load
setup_config()

M.setup_config = setup_config
M.load_cache = cache.load_cache
M.save_cache = cache.save_cache
M.clear_cache = cache.clear_cache

return M
