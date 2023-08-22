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
    scene_api.BindEvent("NPC/Nanxian", "mainscene.TalkNanXian")
    scene_api.BindEvent("NPC/Beichou", "mainscene.TalkBeichou")
    scene_api.BindEvent("NPC/skilladv", "mainscene.TalkGirl")
    scene_api.BindEvent("NPC/merchant", "mainscene.TalkMerchant")
    scene_api.BindEvent("NPC/niuniuniu", "mainscene.TalkNiuniuniu")

    --快速绑定flag到物体控制是否显示
    --scene_api.Register("NPC/Nanxian")
    --scene_api.Register("NPC/Beichou")

    --整个场景只调用一次
    scene_api.CallOnce(FirstTimeAccessScene)
    --AddItem(200, 10)
    --AddItem(201, 100)
    --Jyx2.LootMgr:AddItemsByLootId(3)
    --Join(5)
    --Jyx2.BridgeMgr:TeamRoleSkillLearn(0, 79)
    --Join(19)
    --Jyx2.BridgeMgr:TeamRoleSkillLearn(19, 12)
    --Jyx2.BridgeMgr:TeamRoleSkillLearn(19, 84)
    
end

--必须，退出场景
function Exit()

end

--只调用一次
function FirstTimeAccessScene()
    --首先隐藏北丑
    scene_api.SetActive("NPC/Beichou", false)

    print("第一次进入无名山谷..")

    Talk(0, "。。。咦，我，我这是在哪？")
    Talk(0, "前面有个人，问问这是哪里。。。")

    local role = Jyx2.BridgeMgr:GetPlayerInstance()
    --AddHpWithoutHint(0, 200) --默认加300血
    local v = Jyx2.BridgeMgr:AddAttr(role, "MaxHp", 300)
    Jyx2.BridgeMgr:AddAttr(role, "Hp", v)
    --Jyx2.LootMgr:AddMoney(100000)
    --Jyx2.BridgeMgr:SetSkillInRole(0, 0, 610004, 900)

    --[[
    Join(76)
    Join(1)
    Join(21)
    Join(47)
    Join(59)
    ]]
end

--与南贤对话
function TalkNanXian()

    local nanXianFlag = scene_api.GetInt("Nanxian")
    local roleId = 73

    --ShowSelectPanel(roleId, "测试选择项的最大数", {"1", "2", "3", "4","5","6","7"})


    if (nanXianFlag == 0) then
        Talk(0, "老人家，请问这是何处？")
        Talk(roleId, "年轻人，你来了。");
        Talk(roleId, "这里是传说中与江湖客栈齐名的江湖闹市，江湖闹市只存在于梦境")
        Talk(0, "你知道我要来？！我。。。我这是在梦里？")
        Talk(roleId, "换句话说，你做了一个可能醒不来的梦……")
        Talk(0, "醒不来我怎么回去，话说这梦境我能做什么？")
        Talk(roleId, "你想生存下去，只能在这里不断战斗，不断变强。")
        Talk(0, "。。。")
        Talk(roleId, "只有战斗胜利，才能获得出去的机会。");

        Talk(0, "额，为什么要战斗，我们的敌人是谁？")
        Talk(roleId, "一言难尽，你准备好了就来找我吧。旁边那个怪人也是跟我一起被困在这里的，不过一直嘟嘟囔囔不知道在说什么。。。");
        Talk(roleId, "或许他跟这个困境有什么关系也说不定…… ");

        scene_api.Dark()
        scene_api.SetActive("NPC/Beichou", true) --把北丑显示出来
        scene_api.Light()

        scene_api.SetInt("Nanxian", 1)
    elseif (nanXianFlag == 1) then

        local level = scene_api.GetInt("Level") + 1
        Talk(roleId, "当前是第 <color=red>" .. level .. "</color> 层，你准备好了吗？\n记住：每次挑战胜利将<color=red>自动存档</color>，不容反悔。")

        local ret = ShowYesOrNoSelectPanel("开始下一场挑战？")
        if (ret) then
            NextBattle()
        end
    elseif (nanXianFlag == 2) then
        Talk(roleId, "先去找怪人领奖励吧!");
    end
end
--与商人对话
function TalkMerchant()
    WeiShop()
end
--北丑对话
function TalkBeichou()
    local flag = scene_api.GetInt("Beichou")
    local roleId = 74

    if (flag == 0) then
        Talk(roleId, "噫唏嘘！")
        Talk(0, "什么鬼……")
        Talk(roleId, "汝可在吾之前，不知道吾是谁？")
        Talk(0, "这个神经病看起来有点问题，我还是尽量少惹他吧。。。")
        Talk(roleId, "此间战斗仅可<color=red>自动进行</color>，最多上阵<color=red>6</color>名队友，好好规划汝之队伍！")
        Talk(roleId, "每完成一次战斗和奖励选择都会<color=red>自动存档</color>！所有来此大侠须直面人生，无法反悔！")

        Talk(0, "行吧，我试试看.. 还有什么么？")
        Talk(roleId, "噫唏嘘，危乎高哉！此间秘密不可语...")
        Talk(0, "看来还是先不要理这个怪人了……")

        scene_api.SetInt("Beichou", 1)
    elseif (flag == 1) then
        Talk(roleId, "噫唏嘘，危乎高哉！此间秘密不可语...")
        Talk(0, "还是先不要理这个怪人了……")
    elseif (flag == 2) then
        print("发奖励..")

        local rndItem = scene_api.GetInt("rndItem", itemRndId)
        local rndBook = scene_api.GetInt("rndBook", bookRndId)
        local rndTeamMate = scene_api.GetInt("rndTeamMate", teamMateId)


        local item = Jyx2.ConfigMgr.Item[rndItem]
        local book = Jyx2.ConfigMgr.Item[rndBook]
        local teamMate = Jyx2.ConfigMgr.Character[rndTeamMate]

        local level = scene_api.GetInt("Level")

        --只有奇数关可以选队友
        --[[
        local ret = 3
        if (level % 2 == 1) then
            ret = ShowSelectPanel(roleId, "汝欲神兵、秘笈，还是队友？\n选择后将<color=red>自动存档</color>，不容反悔。"
                , { item.Name, book.Name, teamMate.Name, "随机大礼包", "再想想" })
        else
            ::label_retry::
            ret = ShowSelectPanel(roleId, "汝欲神兵、秘笈？\n选择后将<color=red>自动存档</color>，不容反悔。"
                , { item.Name, book.Name, "<color=grey>(暂不可选队友)</color>", "随机大礼包", "再想想" })
            if (ret == 2) then
                goto label_retry
            end
        end
        ]]

        ::awardSelect::
        --取消只能奇数关选队友的机制
        local ret = ShowSelectPanel(roleId, "汝欲神兵、秘笈，还是队友？\n选择后将<color=red>自动存档</color>，不容反悔。"
                , { item.Name, book.Name, teamMate.Name, "<color=grey>随机大礼包</color>", "再想想" })

        if (ret == 0) then
            AddItem(rndItem, 1)
        elseif (ret == 1) then
            AddItem(rndBook, 1)
        elseif (ret == 2) then
            Join(rndTeamMate)
        elseif ret == 3 then
            --Jyx2.LootMgr:AddItemsByLootId(2)
            ShowToast("随机大礼包机制已取消")
            goto awardSelect
        elseif (ret == 4) then
            goto label_end
        end

        scene_api.SetInt("Beichou", 3)
        scene_api.SetInt("Nanxian", 1)
        AutoSave()
        ::label_end::

    elseif (flag == 3) then
        Talk(roleId, "噫唏嘘，危乎高哉！此间秘密不可语...")
        Talk(0, "……")
    end
end

local battleInfo = ""
local girlId = 59
local niuId = 1005
local skillAdvItemId = 200
local skillUpItemId = 201

--与龙女对话
function TalkGirl()

    --Jyx2.BridgeMgr:Transport(2, "0")

    --Test()
    local selectRoleId = -1 ---选择的角色id
    local selectMod = -1 ---选择的操作模式 1武学升级，2武学进阶
    local selectSkillId = -1
    local selectSkillUpLevel = -1

    ::modSelect::
    local ret = ShowSelectPanel(girlId, "<color=yellow>武学10级后可进阶，进阶完成后武功会重置为1级\n</color><i>进阶只是增大了武功的伤害上限，进阶后的1级强度要远小于之前的10级</i>",
        { "<color=grey>武学学习</color>", "武学升级", "武学进阶", "武学遗忘","武学信息", "离开" })

    if ret == 0 then
        Talk(girlId, "待实现");
        goto modSelect
    elseif ret == 1 or ret == 2 or ret == 3 or ret == 4 then
        selectMod = ret
        goto roleSelect
    else
        return
    end

    ::roleSelect::
    selectRoleId = Jyx2.UIHelper:ShowTeamSelectPanel(girlId, "选择要操作的角色")
    if selectRoleId == -1 then
        goto modSelect
    else
        goto skillSelect
    end

    ::skillSelect::
    if selectMod == 1 then
        if Jyx2.SkillMgr:JudgeCanUpSkill(selectRoleId) then
            selectSkillId = Jyx2.UIHelper:ShowCanUpSkillSelectPanel(girlId, selectRoleId)
        else
            Talk(girlId, "此角色没有可以升级的武学")
            --选择栏无法拖动，导致卡在选择面板，这里先直接退出
            --goto roleSelect
            return
        end

    elseif selectMod == 2 then
        --print("selectRoleId:"..selectRoleId)

        if Jyx2.SkillMgr:JudgeCanAdvSkill(selectRoleId) then
            selectSkillId = Jyx2.UIHelper:ShowCanAdvSkillSelectPanel(girlId, selectRoleId)
        else
            Talk(girlId, "此角色没有可以进阶的武学")
            --选择栏无法拖动，导致卡在选择面板，这里先直接退出
            --goto roleSelect
            return
        end
    elseif selectMod == 3 then--武学遗忘
        selectSkillId = Jyx2.UIHelper:ShowAllSkillsSelectPanel(girlId, selectRoleId)

    elseif selectMod == 4 then
        selectSkillId = Jyx2.UIHelper:ShowAllSkillsSelectPanel(girlId, selectRoleId, "选择要查看的武学信息")
    end

    if selectSkillId == -1 then
        --选择栏无法拖动，导致卡在选择面板，这里先直接退出
        --goto roleSelect
        return
    else
        if selectMod == 1 then
            goto skillUp
        elseif selectMod == 2 then
            goto skillAdv
        elseif selectMod == 3 then
            goto skillForget
        elseif selectMod == 4 then
            local skill = Jyx2.BridgeMgr:GetSkillInRole(selectRoleId, selectSkillId)
            local levelInfo = Jyx2.BridgeMgr:GetSkillLevelInfo(skill)
            local msg = skill.Name
            .."\n"
            .."威力"..tostring(levelInfo.Attack)
            .." | ".."选择范围"..tostring(levelInfo.SelectRange)
            .." | ".."杀伤范围"..tostring(levelInfo.AttackRange)
            .."\n"
            .."加内力"..tostring(levelInfo.AddMp)
            .." | ".."杀伤内力"..tostring(levelInfo.KillMp)

            ShowMessage(msg)
            goto skillSelect
        end
    end

    ::skillAdv::
    --判断进阶丹
    if Jyx2.Util:IsPlayerHaveItem(skillAdvItemId) == true then

        --开始进阶
        local state, message = Jyx2.SkillMgr:SkillAdv(selectRoleId, selectSkillId)

        --判断进阶是否成功
        if state then
            ShowToast(message)
            AddItem(skillAdvItemId, -1)
            return
        else
            ShowMessage(message)
            goto skillSelect
        end

    else
        Talk(girlId, "你没有进阶丹")
        --选择栏无法拖动，导致卡在选择面板，这里先直接退出
        --goto modSelect
        return
    end

    ::skillUp::
    --判断升级丹
    if Jyx2.Util:IsPlayerHaveItem(skillUpItemId) == true then

        local upItemCount = Jyx2.BridgeMgr:GetPlayerItemCount(skillUpItemId)
        ret = ShowSelectPanel(girlId, "你要升多少级？当前拥有<color=yellow>" .. upItemCount .. "</color>个升级丹"
            , { "升一级", "给我满上！", "取消" })
        if ret == 0 then
            selectSkillUpLevel = 1
        elseif ret == 1 then
            selectSkillUpLevel = upItemCount
        elseif ret == 2 then
            goto skillSelect
        end

        --print("selectRoleId:"..selectRoleId)
        --print("selectSkillId:"..selectSkillId)
        --print("selectSkillUpLevel:"..selectSkillUpLevel)
        local state,message,upNumber = Jyx2.SkillMgr:SkillUp(selectRoleId, selectSkillId,selectSkillUpLevel)

        if state then
            AddItem(skillUpItemId, -upNumber)
            ShowToast(message)
            return
        else
            ShowMessage(message)
            goto skillSelect
        end

    else
        --选择栏无法拖动，导致卡在选择面板，这里先直接退出
        Talk(girlId, "你没有升级丹")
        return
    end

    ::skillForget::
    local skillCount = Jyx2.BridgeMgr:GetRoleSkillCountById(selectRoleId)
    if skillCount == 1 then
        ShowMessage("人物必须保留一个技能")
        --选择栏无法拖动，导致卡在选择面板，这里先直接退出
        return
    end

    if ShowYesOrNoSelectPanel("确认遗忘？<color=gray>该过程不可逆</color>") == true then
        if Jyx2.BridgeMgr:TeamRoleSkillForget(selectRoleId, selectSkillId) ~= nil then
            ShowToast("遗忘成功!")
        end
    else
        --选择栏无法拖动，导致卡在选择面板，这里先直接退出
        return
    end

    ::skillShow::

    

    return

end

--与牛妞妞对话
function TalkNiuniuniu()
    Talk(niuId, "人家正和六一哥哥嗯呢，莫名奇妙就被拉到这里来了")
end

function ShowBattleInfo()
    --ShowMessage(battleInfo)
    Talk(0, battleInfo, "对话名", 3)
end

--生成对战敌人
function GenerateEnemies(level, battleConfig)
    --清空测试信息缓存
    battleInfo = ""

    print(battleConfig.DynamicEnemies)
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

    --敌人中排除王毒仙
    if roleId == 17 then
        roleId = 16
    end

    local selectRole = CS.Jyx2.GameRuntimeData.Instance:GetRole(roleId)

    --等级太高了，再重新随
    while (selectRole.Level > level + 3) do
        roleId = math.random(1, 76)

        --敌人中排除王毒仙
        if roleId == 17 then
            roleId = 16
        end

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
            if (skillId == 75 or skillId == 76 or skillId == 84) then
                --do nothing
                --鳄鱼和蜘蛛的技能，会导致动作失效
                --蟒蛇的技能同样会导致动作失效
            else
                role:LearnMagic(skillId)

                --添加测试信息，以验证是否是新增的技能导致卡死
                if battleInfo ~= "" then
                    battleInfo = battleInfo .. " | "
                end
                battleInfo = battleInfo .. role.Name.."->"..Jyx2.BridgeMgr:GetSkillName(skillId)
            end
        end

        
    end

    --每10关增加一次属性
    Jyx2.BridgeMgr:AddAttr(role, "MaxHp", level//10* 200)
    Jyx2.BridgeMgr:AddAttr(role, "Yujian", level//10*5)
    Jyx2.BridgeMgr:AddAttr(role, "Shuadao", level//10*5)
    Jyx2.BridgeMgr:AddAttr(role, "Quanzhang", level//10*5)
    Jyx2.BridgeMgr:AddAttr(role, "Qimen", level//10*5)
    Jyx2.BridgeMgr:AddAttr(role, "Anqi", level//10*5)

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

--下一场战斗
function NextBattle()
    print("next battle called..")

    local level = scene_api.GetInt("Level")

    --动态构建一场战斗
    local battleConfig = CS.Jyx2.CsBattleConfig()

    battleConfig.Id = 9999 --随便拟定一个战斗ID，无所谓
    battleConfig.MapScene = "Jyx2Battle_" .. math.random(0, 25) --随机挑选一个战斗场景
    battleConfig.Exp = 200 * (level + 1)
    battleConfig.Music = 22
    battleConfig.TeamMates = { 0 }
    battleConfig.Enemies = {}
    battleConfig.AutoTeamMates = { -1 }
    GenerateEnemies(level, battleConfig)

    if (TryBattleWithConfig(battleConfig) == false) then
        --战斗失败
        --断掉连胜统计
        scene_api.SetInt("winSteak", 0)
        --Talk(0, "<color=red>你真菜！</color>", "", 3)
        Talk(0, "咦？我怎么在这里。刚刚发生了什么？")
        Talk(73, "（笑而不语）")
    else
        --增加层数
        scene_api.SetInt("Level", level + 1)
        --增加连胜统计
        local winSteak = scene_api.GetInt("winSteak")
        winSteak= winSteak + 1
        scene_api.SetInt("winSteak", winSteak)

        --发放连胜奖励
        local awardCountMin = 1+winSteak/3
        local awardCountMax = awardCountMin + winSteak%3
        local awardCount = math.random(math.floor(awardCountMin), math.floor(awardCountMax))
        local money = 1000+(winSteak - 1)*100
        Talk(girlId, "当前连胜<color=red>"..tostring(winSteak).."</color>场，为你添加<color=red>"..tostring(awardCount).."</color>个补给")

        local lootTable = Jyx2.ConfigMgr.Loot[4]
        lootTable.ItemCountMin = awardCount
        lootTable.ItemCountMax = awardCount
        lootTable.IsRepeat = true
        lootTable.MoneyConfigMin = math.floor(money * 0.9)
        lootTable.MoneyConfigMax = math.floor(money * 1.1)
        Jyx2.LootMgr:AdditemsByLoot(lootTable)

        Talk(niuId, "呵呵，送给你一些药品补给")
        --生成普通药品奖励
        for i = 0, math.min(level / 10, 2) do
            local itemId = math.random(0, 36) --药品
            AddItem(itemId, 1)
        end

        Talk(74, "噫唏嘘，吾这里也有汝之奖励！")
        scene_api.SetInt("Beichou", 2)
        scene_api.SetInt("Nanxian", 2)

        --先生成奖励，防止SL
        local itemRndId = math.random(96, 123) --对应物品ID中的装备
        --原始为39-95
        local bookRndId = math.random(38, 95) --对应物品ID中的秘籍
        if bookRndId == 38 then
            bookRndId = 2 --野球拳
        end

        local role = GenerateRandomTeammate(level)

        scene_api.SetInt("rndItem", itemRndId)
        scene_api.SetInt("rndBook", bookRndId)
        scene_api.SetInt("rndTeamMate", role.Key)
    end
    RestTeam()
    AutoSave()
end

--根据等级生成一个随机队友
function GenerateRandomTeammate(level)

    local role = nil
    local maxLoop = 0
    while (true) do
        --已经在队伍了，或者随出来角色等级太高了，就重新随一下
        local teamMateId = math.random(401, 471) --对应角色ID

        --队伍中排除王毒仙
        if teamMateId == 417 then
            teamMateId = 416
        end

        role = CS.Jyx2.GameRuntimeData.Instance:GetRole(teamMateId)

        if ((not InTeam(teamMateId)) and (role.Level < level) and (role.Level >= level - 10)) then
            print("bingo")
            break
        end

        maxLoop = maxLoop + 1
        if (maxLoop > 100) then --防止死循环
            print("maxLoop " .. maxLoop)
            break
        end
    end

    --将角色提升到现在等级
    while (role.Level < math.min(level, CS.GameConst.MAX_ROLE_LEVEL)) do
        role:LevelUp()
    end

    --给角色增加生命、内力上限
    role.MaxHp = math.min(role.MaxHp + 100, CS.GameConst.MAX_ROLE_HP)
    role.MaxMp = math.min(role.MaxMp + 100, CS.GameConst.MAX_ROLE_MP)
    role:Recover()
    return role
end

--自动存档
function AutoSave()
    --覆盖存档
    ShowToast("正在自动存档..")
    CS.LevelMaster.Instance:OnManuelSave(0);
    
end

