--提供武器元素与等级的相关能力
--模块依赖：Util

local WeaponMgr = {}

function WeaponMgr:GetWeaponE(itemId)
    local idStr = tostring(itemId)
    local strs = Jyx.Util.StringSplit(idStr, "000")

    if #strs ~= 2 then
        return "none"
    end

    if #strs[2] ~= 2 then
        return "none"
    end

    local eIndex = tonumber(string.sub(strs[2], 1, 1))
    local ret = "none"

    if eIndex == 1 then
        ret = "gold"
    elseif eIndex == 2 then
        ret = "timber"
    elseif eIndex == 3 then
        ret = "water"
    elseif eIndex == 4 then
        ret = "fire"
    elseif eIndex == 5 then
        ret = "soil"
    end

    return ret
end

function WeaponMgr:GetWeaponLevel(itemId)
    local idStr = tostring(itemId)
    local strs = Jyx.Util.StringSplit(idStr, "000")

    if #strs ~= 2 then
        return 0
    end

    if #strs[2] ~= 2 then
        return 0
    end

    return tonumber(string.sub(strs[2], 2, 2))
end

return WeaponMgr