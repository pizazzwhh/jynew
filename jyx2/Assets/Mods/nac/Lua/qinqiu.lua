



local function TalkPrologue()
    DarkScence()
    LightScence()
    Jyx2.Util:ShowMessage0("主角给去世的父母的排位前烧香")
    Talk(0, "父亲母亲，今天是第十年了，你们离开了我整整十年，孩儿每天有好好照顾自己，每天都按时烧香，但是我还是没有好好习武，孩儿不想当大侠，不想用性命守护别人，我只想安安稳稳的度过一生。。。")
    Jyx2.Util:ShowMessage0("主角起身")
    Talk(0, "又要去武馆了，不管了，去武馆玩玩吧，反正我是不会学什么武功拯救世界！")
end

local function CallOnce()
    TalkPrologue()
end

local function Start()
    scene_api.BindEvent("NPC/girl", "qinqiu.TalkGirl")
    scene_api.BindEvent("NPC/girl2", "qinqiu.TalkGirl2")
    scene_api.BindEvent("NPC/laotaitai", "qinqiu.TalkLaotaitai")
    scene_api.BindEvent("NPC/man", "qinqiu.TalkMan")

    SetGameEvent("NPC/EI_timber", "qinqiu.TalkTimber", -1, -1)
    SetGameEvent("NPC/EI_timber_1", "qinqiu.TalkTimber", -1, -1)
    SetGameEvent("NPC/EI_soil", "qinqiu.TalkSoil", -1, -1)
    SetGameEvent("NPC/EI_water", "qinqiu.TalkWater", -1, -1)

    scene_api.CallOnce(CallOnce)
end

local function Exit()

end










local function TalkGirl()

    Talk(1, "这里演示武学进阶相关功能");
    local ret = ShowSelectPanel(1, "<color=green>需要做点什么</color>", {"闲聊", "武学进阶", "武学学习", "武学升级","离开"})

    --闲聊
    if ret == 0 then
        TalkingGirl()

    --武学进阶
    elseif ret == 1 then
        if Jyx2.SkillMgr:JudgeCanAdvSkill() then
            local selectSkillId = ShowCanAdvSkillSelectPanel()
            if selectSkillId ~= -1 then
                Jyx2.SkillMgr:SkillAdv(selectSkillId)
            end
        else
            Talk(1, "你没有可以进阶的武学")
        end

    --武学学习
    elseif ret == 2 then
        LearnMagic2(0, 2, 1);

    --武学升级
    elseif ret == 3 then
        if Jyx2.SkillMgr:JudgeCanUpSkill() then
            local selectSkillId = ShowCanUpSkillSelectPanel()
            print("selectSkillId:"..selectSkillId)
            if selectSkillId ~= -1 then
                Jyx2.SkillMgr:SkillUp(selectSkillId)
            end
        else
            Talk(1, "你没有可以升级的武学")
        end
    end
end
local function TalkGirl2()

    Talk(2, "这里演示战利品模块的功能")
    if(Jyx2.ConfigMgr.Loot == nil and #Jyx2.ConfigMgr.Loot <= 0) then
        Talk(2, "请先配置战利品表")
        return
    end

    local lootId = ShowLootConfigSelectPanel("选择战利品配置表ID")
    if lootId == -1 then
        return
    end

    local items,exp,money = Jyx2.LootMgr:CreateLootsById(lootId)

    local itemsStr = "物品: <color=red>|</color> "

    print("lootId:"..lootId)
    print(#items)
    for key, value in pairs(items) do
        itemsStr = itemsStr.."id:"..key..",count:"..value.." <color=red>|</color> "
    end

    local message = "战利品掉落模拟:\n"..itemsStr.."\n经验:"..exp.."\n金币:"..money

    print(message)
    ShowMessage(message)
    --_,_,_ = CreateLoots(1)

end
function TalkLaotaitai()
    Talk(3,"这里进行战斗的测试")
    local selectIndex = ShowSelectPanel(3, "选择战斗场景", {"示例场景", "当前场景"})

    if TryBattle(selectIndex + 1) == true then
        Talk(3, "??????")
    else
        Talk(3, "输是必然的")
    end
end
function TalkMan()
    Talk(4, "这里进行环境交互的测试")
    if ShowYesOrNoSelectPanel("是否领取元素武器?") then
        EIAddItem()
        Talk(4, "带上元素武器,去寻找环境交互吧")

        local eObjNames = {"NPC/EI_timber", "NPC/EI_timber_1", "NPC/EI_soil", "NPC/EI_water"}
        local e = {"timber", "soil", "water"}
        Jyx2.EIMgr:InitEI(eObjNames, e)
    end
end


function EIAddItem()
    AddItem(10900010, 1)
    AddItem(10900020, 1)
    AddItem(10900030, 1)
    AddItem(10900040, 1)
    AddItem(10900050, 1)
end


function TalkGold()
    Talk(0, "这是环境交互[金]")
end

function TalkTimber()
    Talk(0, "这是环境交互[木]")
end

function TalkWater()
    Talk(0, "这是环境交互[水]")
end

function TalkFire()
    Talk(0, "这是环境交互[火]")
end

function TalkSoil()
    Talk(0, "这是环境交互[土]")
end


function InteractionGold()

end





function ShowLootConfigSelectPanel(talkContent)
    local lootTable = Jyx2.ConfigMgr.Loot
    local lootIds = {}

    print(lootTable.ItemNum)

--[[
    for index, value in ipairs(lootTable) do
        table.insert(lootIds,tostring(value.Id))
    end
]]

    table.insert(lootIds, "0")
    table.insert(lootIds, "1")

    table.insert(lootIds, "取消")
    local ret = ShowSelectPanel(2, talkContent, lootIds)

    --如果选择了取消
    if ret == #lootIds - 1 then
        return -1
    end

    return tonumber(lootIds[ret+1])

end







function TalkingGirl()
    Talk(1,"清晨的阳光好温暖啊")
    Talk(0, "...")
    Talk(1,"你觉着呢")
    Talk(0, "...")
end

function ShowCanUpSkillSelectPanel()
    local skillIDs = Jyx2.SkillMgr:GetCanUpSkill()
    return ShowSKillSelectPanel(skillIDs, "选择要<color=yellow>升级</color>的武学")
end

function ShowCanAdvSkillSelectPanel()
    local skillIDs = Jyx2.SkillMgr:GetCanAdvSkill()
    return ShowSKillSelectPanel(skillIDs, "选择要<color=yellow>进阶</color>的武学")
end

---显示技能选择面板
---@param skillIDs userdata
---@param talkContent string
---@return number selectSkillId
function ShowSKillSelectPanel(skillIDs, talkContent)
    local skillNames = {}
    local skillIDs = skillIDs

    for i = 0, skillIDs.Length - 1, 1 do
        local id = skillIDs[i]
        local skillName = Jyx2.ConfigMgr.Skill[id].Name

        table.insert(skillNames, skillName)
    end

    --添加取消的选择项
    table.insert(skillNames, "取消")
    local ret = ShowSelectPanel(1, talkContent, skillNames)

    --如果选择了取消
    if ret == #skillNames - 1 then
        return -1
    end
    --ShowMessage("你选择ID:"..skillIDs[ret].." name:"..skillNames[ret+1])

    return skillIDs[ret]
end







