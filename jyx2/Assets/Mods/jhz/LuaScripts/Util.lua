--通用模块
--尝试将Jyx2LuaBridge.cs实现到lua侧
--模块依赖：无

local Util = {}

---字符串拆分
---@param input any
---@param delimiter any
---@return any
function Util:StringSplit(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter == "") then return nil end
    local pos, arr = 0, {}
    for st, sp in function() return string.find(input, delimiter, pos, true) end do
        table.insert(arr, string.sub(input, pos, st - 1))
        pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
end

function Util:GetPlayerItemCount(itemId)
    return CS.Jyx2.GameRuntimeData.Instance:GetItemCount(itemId)
end

function Util:IsPlayerHaveItem(itemId)
    local count = Util:GetPlayerItemCount(itemId)
    print("count:"..count)
    return count > 0
end

function Util:ShowMessage0(str)
    ShowMessage("Timeline待添加:\n"..str)
end


return Util