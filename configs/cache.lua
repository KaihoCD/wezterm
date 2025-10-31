local M = {}
local cache_path = (os.getenv("HOME") or ".") .. "/.cache/wezterm.cache"

--- Save a key-value pair to cache (overwrite if exists)
--- @param key string
--- @param value string|number|boolean
function M.save_cache(key, value)
    local cache = {}
    -- Read existing cache
    local f = io.open(cache_path, "r")
    if f then
        for line in f:lines() do
            local k, v = line:match("^([^=]+)=(.*)$")
            if k then cache[k] = v end
        end
        f:close()
    end
    -- Overwrite/add
    cache[key] = value
    -- Write back
    f = io.open(cache_path, "w")
    if f then
        for k, v in pairs(cache) do
            f:write(k .. "=" .. v .. "\n")
        end
        f:close()
    end
end


--- Read all cache as a table (map)
--- @return table<string, string>
function M.load_cache()
    local result = {}
    local f = io.open(cache_path, "r")
    if not f then return result end
    for line in f:lines() do
        local k, v = line:match("^([^=]+)=(.*)$")
        if k then result[k] = v end
    end
    f:close()
    return result
end

--- Remove cache file
function M.clear_cache()
    os.remove(cache_path)
end

--- Initialize cache with a table, using keys array (only if cache file does not exist)
--- @param keys table<string>  @desc array of keys to save
--- @param tbl table           @desc source table to read values from
function M.init_cache(keys, tbl)
    local f = io.open(cache_path, "r")
    if f then f:close(); return end -- already exists, do nothing
    if type(tbl) ~= "table" or type(keys) ~= "table" then return end
    for _, k in ipairs(keys) do
        local v = tbl[k]
        if v ~= nil then
            M.save_cache(k, tostring(v))
        end
    end
end

return M
