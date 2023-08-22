--[[
--#region
Jyx2.SkillMgr = require "SkillMgr"
Jyx2.LootMgr = require "LootMgr"
Jyx2.BridgeMgr = require "BridgeMgr"
Jyx2.UIHelper = require "UIHelper"
Jyx2.Util = require "Util"
--#endregion
--]]

--必须，进入场景调用
function Start()
    --快速绑定事件到物体
    scene_api.BindEvent("NPC/Nanxian", "scene2.TalkNanXian")
    scene_api.BindEvent("NPC/Beichou", "scene2.TalkBeichou")
    scene_api.BindEvent("NPC/skilladv", "scene2.TalkGirl")
    scene_api.BindEvent("NPC/merchant", "scene2.TalkMerchant")

    --快速绑定flag到物体控制是否显示
    --scene_api.Register("NPC/Nanxian")
    --scene_api.Register("NPC/Beichou")

    --整个场景只调用一次
    scene_api.CallOnce(FirstTimeAccessScene)
    --AddItem(200, 10)
    --AddItem(201, 100)
    --Jyx2.LootMgr:AddItemsByLootId(3)
    --Join(5)
end

--必须，退出场景
function Exit()

end

--只调用一次
function FirstTimeAccessScene()
    --首先隐藏北丑
    --scene_api.SetActive("NPC/Beichou", false)

    Talk(0, "哦？这又是那里")

    --AddHpWithoutHint(0, 300) --默认加300血
end


--生成对战敌人
function GenerateEnemies(level, battleConfig)
    --print(battleConfig.DynamicEnemies)
    battleConfig:InitForDynamicData()

    --最多8个敌人
    for i = 0, math.min(level / 4, 8) do
        local role = GenerateRole(level)
        battleConfig.DynamicEnemies:Add(role)

        --如果在5关以前，则NPC没有道具（否则太难了）
        if (level < 5) then
            role.Items:Clear()
        else
            --之后也会降低NPC的药量
            local items = role.Items
            for j = 0, items.Count - 1,1 do

                --如果携带物品是药品，则限制数量为3
                local itemId = items[j].Id
                if itemId >=0 and itemId <= 20 then
                    items[j].Count = 3
                end
            end
        end
    end
end

--根据等级，生成一个随机敌人
function GenerateRole(level)
    local roleId = math.random(1, 76)
    local selectRole = CS.Jyx2.GameRuntimeData.Instance:GetRole(roleId)

    --等级太高了，再重新随
    while (selectRole.Level > level + 3) do
        roleId = math.random(1, 76)
        selectRole = CS.Jyx2.GameRuntimeData.Instance:GetRole(roleId)
    end

    local role = selectRole:Clone()
    role:ResetItems()

    --把角色提升到现在关卡的等级
    while (role.Level < math.min(level, CS.GameConst.MAX_ROLE_LEVEL)) do
        role:LevelUp()
    end

    --每10关，随机给角色增加一个技能
    for i = 0, math.max(level / 10 - 1, 0) do
        if (role.Wugongs.Count < 10) then
            local skillId = math.random(0, 92)
            if (skillId == 75 or skillId == 76) then
                --do nothing
                --鳄鱼和蜘蛛的技能，会导致动作失效
            else
                role:LearnMagic(skillId)
            end
        end
    end

    --角色技能提升
    for i = 0, role.Wugongs.Count - 1 do
        local skill = role.Wugongs[i]

        --每4关升1级技能等级（一级对应是100level）
        if (skill ~= nil and skill.Level < level * 25) then

            --随机提升技能等级，不超过上限
            skill.Level = math.min(math.random(skill.Level, level * 25), 900)
        end
    end

    role:Recover()
    return role
end

function TalkNanXian()

    local level = scene_api.GetInt("Level")

    --动态构建一场战斗
    local battleConfig = CS.Jyx2.CsBattleConfig()

    battleConfig.Id = 9999 --随便拟定一个战斗ID，无所谓
    battleConfig.MapScene = "Jyx2Battle_" .. math.random(0, 25) --随机挑选一个战斗场景
    battleConfig.Exp = 400 * (level + 1)
    battleConfig.Music = 22
    battleConfig.TeamMates = { 0 }
    battleConfig.Enemies = {}
    battleConfig.AutoTeamMates = { -1 }
    GenerateEnemies(level, battleConfig)

    TryBattleWithConfig(battleConfig)
end