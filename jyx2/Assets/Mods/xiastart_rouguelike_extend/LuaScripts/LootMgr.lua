--提供战利品掉落的相关功能
--模块依赖：ConfigMgr

---@class LootMgr
local LootMgr = {}

---创建战利品
---@param lootId integer 战利品配置id
---@return table items 物品表 {ItemId:Count}
---@return integer exp 经验
---@return integer money 金钱
function LootMgr:CreateLootsById(lootId)
    local loot = Jyx2.ConfigMgr.Loot[lootId]
    return self:CreateLoots(loot)
end

---通过战利品配置生成战利品
---@param loot any 战利品配置项
---@return table 生成的物品
---@return integer 生成的经验数
---@return integer 生成的金钱数
function LootMgr:CreateLoots(loot)
    local money = self:CreateLootMoney(loot)
    local exp = self:CreateLootExp(loot)
    local items = self:CreateLootItems(loot)

    return items,exp,money
end

---通过战利品配置生成物品
---@param loot any
---@return table 生成的物品
function LootMgr:CreateLootItems(loot)
    local lootItem = {}

    local weightSum = 0;
    for _, value in ipairs(loot.ItemConfig) do
        weightSum = weightSum + value.Weight
    end

    --print("weightSum:"..weightSum)

    --loot.ItemConfig;
    local now = os.time()
    math.randomseed(now)
    local ranFloat

    local itemCount = math.random(loot.ItemCountMin, loot.ItemCountMax)
    local isRepeat = loot.IsRepeat

    --当不允许重复，且ItemConfig配置的物品数量小于随机物品战力品数时，会引发死循环
    --这里判断一下，禁止这个问题
    --print(#loot.ItemConfig)
    if isRepeat == false then
        local validItemConfigCount = 0
        for index, value in ipairs(loot.ItemConfig) do
            if value.ItemId >= 0 then
                validItemConfigCount = validItemConfigCount + 1
            end
        end

        if validItemConfigCount < itemCount then
            error("当不允许重复时，ItemConfig配置的物品数不应小于战利品的随机数量")
            return lootItem
        end
    end

    --local test1 = 0;
    --local test2 = 0;

    --print("战利品数量:"..itemCount)
    --按掉落物品数进行循环
    while itemCount > 0 do
        --test1 = test1 + 1;
        --随机一个浮点数
        ranFloat = math.random() * weightSum
        --print("randomFloat:"..ranFloat)

        --按权重判断掉落的物品
        for index, value in ipairs(loot.ItemConfig) do
            ranFloat = ranFloat - value.Weight

            --随机到物品
            if ranFloat < 0 then
                --空占位
                if value.ItemId < 0 then
                    --随机到空占位,物品随机数-1,退出循环
                    itemCount = itemCount - 1;
                    break
                end

                local keyStr = tostring(value.ItemId)

                --向物品战利品表中添加数量
                if lootItem[keyStr] == nil then
                    lootItem[keyStr] = 1;
                else
                    --test2 = test2 + 1
                    --如果不允许重复,则退出循环,重新随机
                    if isRepeat == false then
                        break
                    end

                    lootItem[keyStr] = lootItem[keyStr] + 1
                end

                --成功添加随机物品,物品随机数-1,退出循环
                itemCount = itemCount - 1;
                break

            end
        end
    end

    --print("循环了"..test1.."次,重复了"..test2.."次")
    return lootItem
end

---通过战利品配置生成经验
---@param loot any 战利品配置项
---@return integer 经验数
function LootMgr:CreateLootExp(loot)
    local expMax = loot.ExpConfigMax;
    local expMin = loot.ExpConfigMin;
    if expMax == -1 or expMin == -1 then
        return 0
    end

    local lootExp = 0;

    local now = os.time()
    math.randomseed(now)
    lootExp = math.random(expMin, expMax)

    return lootExp
end

---通过战利品配置生成金钱
---@param loot any 战利品配置项
---@return integer 金钱数
function LootMgr:CreateLootMoney(loot)
    local moneyMax = loot.MoneyConfigMax
    local moneyMin = loot.MoneyConfigMin
    if moneyMax == -1 or moneyMin == -1 then
        return 0
    end

    local lootMoney = 0;

    local now = os.time()
    math.randomseed(now)
    lootMoney = math.random(moneyMin, moneyMax)

    return lootMoney
end

function LootMgr:AddItems(items)
    for key, value in pairs(items) do
        AddItem(key, value)
    end
end

function LootMgr:AddMoney(count)
    AddItem(CS.GameConst.MONEY_ID, count)
end

function LootMgr:AddItemsByLootId(lootId)
    local items,exp,money = LootMgr:CreateLootsById(lootId)
    print("[loot]exp:"..exp)
    print("[loot]money:"..money)
    local str = ""
    for key, value in pairs(items) do
        str = str.."|"..key..":"..value.."|\n"
    end
    print("[loot]items:\n"..str)
    print("itemCount:"..#items)

    LootMgr:AddItems(items)


    if exp ~= 0 then
        --添加经验会有问题，经验满了也不会触发升级，升级判断是在战斗后
        AddExp(0, exp)
    end

    if money ~= 0 then
        LootMgr:AddMoney(money)
    end

end

function LootMgr:AdditemsByLoot(loot)
    local items,exp,money = self:CreateLoots(loot)

    LootMgr:AddItems(items)

    if exp ~= 0 then
        --添加经验会有问题，经验满了也不会触发升级，升级判断是在战斗后
        AddExp(0, exp)
    end

    if money ~= 0 then
        LootMgr:AddMoney(money)
    end
end

return LootMgr