---@diagnostic disable: duplicate-set-field
--尝试将Jyx2LuaBridge.cs实现到lua侧
--问题：未打上[LuaCallCSharp]的C#类，将使用效率低的反射来调用， 且很可能因为Il2CPP的代码裁剪而无法访问
--大多数返回的数组是C#中的类型，下标从0开始

BridgeMgr = {}

---获取游戏运行时数据的单例 
---@return userdata runtime CS.GameRuntimeData.Instance
function BridgeMgr:GetRuntime()
    return CS.Jyx2.GameRuntimeData.Instance
end

--------------角色物品---------------

---获取角色物品数量
---@param itemId integer
---@return integer
function BridgeMgr:GetPlayerItemCount(itemId)
    return self:GetRuntime():GetItemCount(itemId)
end
---角色是否拥有物品
---@param itemId integer
---@return boolean
function BridgeMgr:IsPlayerHaveItem(itemId)
    local count = self:GetPlayerItemCount(itemId)
    --print("count:"..count)
    return count > 0
end
---获取玩家金钱
---@return integer
function BridgeMgr:GetPlayerMoney()
    return self:GetRuntime():GetItemCount(CS.GameConst.MONEY_ID)
end
---增加玩家金钱
---@param count integer 数量
---@param isShow boolean 是否显示提示
function BridgeMgr:AddPlayerMoney(count, isShow)
    if isShow == nil or isShow == false then
        self:AddPlayerItem(CS.GameConst.MONEY_ID, count);
    else
        AddItem(CS.GameConst.MONEY_ID, count);
    end
    
end
---增加玩家物品
---@param itemId integer
---@param count integer
function BridgeMgr:AddPlayerItem(itemId, count)
    self:GetRuntime():AddItem(itemId, count);
end

--------------队伍---------------

---判断角色是否在队伍中
---@param roleId integer
---@return boolean
function BridgeMgr:IsRoleInTeam(roleId)
    return self:GetRuntime():GetRoleInTeam(roleId) ~= nil
end
---获取队伍中的角色实例
---@param roleId integer 角色id
---@return userdata roleInstance CS.RoleInstance
function BridgeMgr:GetRoleInTeam(roleId)
    return self:GetRuntime():GetRoleInTeam(roleId)
end


--------------角色---------------

---获取角色实例
---@param roleId integer 角色id
---@return userdata roleInstance CS.RoleInstance
function BridgeMgr:GetRole(roleId)
    return self:GetRuntime():GetRole(roleId)
end
---获取队伍中的角色ID
---@return userdata teamIds CS.List_int
function BridgeMgr:GetTeamIds()
    return self:GetRuntime():GetTeamId()
end
---获取场景中玩家对象
---@return userdata playerObj CS.Jyx2Player
function BridgeMgr:GetPlayerObj()
    return CS.LevelMaster.Instance:GetPlayer()
end

--------------武功---------------

---获取武功名称
---@param skillId integer 武功id
---@return string skillName 武功名称
function BridgeMgr:GetSkillName(skillId)
    return Jyx2.ConfigMgr.Skill[skillId].Name
end
---获取指定角色的武功实例数组
---@param roleId integer
---@return nil|userdata skills CS.List_SkillInstance
function BridgeMgr:GetSkillsInRole(roleId)
    local role = self:GetRole(roleId)
    if role == nil then
        return nil
    end

    return role.Wugongs
end
---获取角色身上的武功实例
---@param roleId integer
---@param skillId integer
---@return nil|userdata skillInstance CS.SkillInstance
function BridgeMgr:GetSkillInRole(roleId, skillId)
    if roleId == nil or skillId == nil then
        error("参数不能为nil")
        return nil
    end

    local skills = self:GetSkillsInRole(roleId)
    if skills == nil then
        warn("获取角色身上的武功列表为nil,roleId:"..roleId)
        return nil
    end

    for i = 0, skills.Count - 1, 1 do
        local skill = skills[i]
        local id = skill.Key
        if skillId == id then
            return skill
        end
    end

    warn("角色身上没有指定武功,roleId:"..roleId..",skillId:"..skillId)
    return nil
end
---通过武功实例获取武功id
---@param skillInstance userdata CS.SkillInstance
---@return nil|integer skillId 武功id
function BridgeMgr:GetSkillId(skillInstance)
    if skillInstance == nil then
        return nil
    end

    return skillInstance.Key
end
---获取武功等级
---@param skillInstance userdata CS.SkillInstance
---@return integer
function BridgeMgr:GetSkillLevel(skillInstance)
    return skillInstance:GetLevel()
end
---获取武功在角色中的索引
---@param roleId integer 角色id
---@param skillId integer 武功id
---@return nil|integer index 索引
function BridgeMgr:GetSkillIndex(roleId, skillId)
    if roleId == nil or skillId == nil then
        return nil
    end

    local role = self:GetRoleInTeam(roleId)
    if role == nil then
        role = self:GetRole(roleId)
    end

    if role ==  nil then
        error("无法获取role，roleId:"..roleId)
        return nil
    end

    local skills = role.Wugongs
    for i = 0, skills.Count - 1, 1 do
        if skills[i].Key == skillId then
            return i
        end
    end

    error("角色身上不存在此武功, roleId:"..roleId..",skillId:"..skillId)
    return nil
end
---通过武学等级获取玩家身上的武学id
---@param level integer 指定的武学等级
---@param mod integer 判断武学等级的模式,1,>=  2,<=
---@return table|nil
function BridgeMgr:GetPlayerSkillIdsByLevel(level, mod)
    local player = CS.Jyx2.GameRuntimeData.Instance.Player;
    return self:GetRoleSkillIdsByLevel(player, level, mod)
end
---通过武学等级获取指定队伍角色身上的武学id
---@param roleId integer 角色id
---@param level integer 指定的武学等级
---@param mod integer 判断武学等级的模式,1,>=  2,<=
---@return table|nil skillIds 
function BridgeMgr:GetTeamRoleSkillIdsByLevel(roleId, level, mod)
    local role = self:GetRoleInTeam(roleId)
    if role == nil then
        return nil
    end

    return self:GetRoleSkillIdsByLevel(role, level, mod)
end
---通过武学等级获取角色实例上的武学id
---@param roleInstance userdata CS.RoleInstance
---@param level integer 指定的武学等级
---@param mod integer 判断武学等级的模式 [0,忽略筛选规则] [1,>=] [2,<=]
---@return table|nil
function BridgeMgr:GetRoleSkillIdsByLevel(roleInstance, level, mod)
    if roleInstance == nil then
        return nil
    end

    if mod == nil then
        mod = 1
    end

    local ret = {}
    --print(player.Wugongs.Count)

    for i = 0, roleInstance.Wugongs.Count - 1, 1 do
        --print("i:"..i)
        local skill = roleInstance.Wugongs[i]
        local skillLevel = skill:GetLevel()
        --print("level:"..skillLevel)

        if mod == 0 or (mod == 1 and skillLevel >= level) or (mod == 2 and skillLevel <= level) then
            table.insert(ret, skill.Key)
        end
    end

    return ret
end
---遗忘队伍角色的武学
---@param roleId integer
---@param skillId integer
---@return boolean state
function BridgeMgr:TeamRoleSkillForget(roleId, skillId)
    local roleInstance = self:GetRoleInTeam(roleId)
    if roleInstance == nil then
        return false
    end

    local skillIndex = self:GetSkillIndexByRoleInstance(roleInstance, skillId)
    if skillIndex == nil then
        return false
    end

    roleInstance.Wugongs:RemoveAt(skillIndex)
    roleInstance:ResetSkillCasts()
    return true
end
---添加队伍角色的武学
---@param roleId any
---@param skillId any
---@return boolean
function BridgeMgr:TeamRoleSkillLearn(roleId, skillId)
    if self:IsRoleInTeam(roleId) == false then
        return false
    end

    local role = self:GetRoleInTeam(roleId)
    if role == nil then
        return false
    end

    role:LearnMagic(skillId)
    return true
end



--待完善
function BridgeMgr:Transport(gameMapId, triggerName)

    local curMap = CS.LevelMaster:GetCurrentGameMap()
    if curMap == nil then
        error("获取当前场景为null")
        return
    end

    local nextMap = Jyx2.ConfigMgr.Map[gameMapId]
    local nextMap = CS.LuaToCsBridge.MapTable[gameMapId]
    if nextMap == nil then
        error("错误，传送目标地图未定义")
        return
    end

    CS.LevelMaster.LastGameMap = curMap
    local para = CS.LevelMaster.LevelLoadPara()
    para.loadType = CS.LevelMaster.LevelLoadPara.LevelLoadType.StartAtTrigger
    para.triggerName = triggerName

    --print(nextMap)
    print(nextMap.Name)
    print(nextMap.Id)
    CS.Jyx2.LevelLoader:LoadGameMap(nextMap)
end

function BridgeMgr:GetRoleSkillCountById(roleId)
    local role = self:GetRoleInTeam(roleId)
    if role == nil then
        return nil
    end

    return self:GetRoleSkillCount(role)
end
function BridgeMgr:GetRoleSkillCount(roleInstance)
    return roleInstance.Wugongs.Count
end

function BridgeMgr:GetRoleName(roleId)
    
end
function BridgeMgr:GetSkillIndexByRoleInstance(roleInstance, skillId)
    local skills = roleInstance.Wugongs
    for i = 0, skills.Count - 1, 1 do
        if skills[i].Key == skillId then
            return i
        end
    end

    error("角色身上不存在此武功, roleId:"..tostring(roleInstance.Key)..",skillId:"..skillId)
    return nil
end

function BridgeMgr:SetRoleInstanceSkill(roleInstance, oldSkillId, newSkillId, skillLevel)
    local skillIndex = self:GetSkillIndexByRoleInstance(roleInstance, oldSkillId)
    self:SetRoleInstanceSkillByIndex(roleInstance, skillIndex, newSkillId, skillLevel)
end

function BridgeMgr:SetRoleInstanceSkillByIndex(roleInstance, oldSkillIndex, newSkillId, skillLevel)
    roleInstance.Wugongs[oldSkillIndex].Key = newSkillId
    roleInstance.Wugongs[oldSkillIndex].Level = skillLevel
    roleInstance.Wugongs[oldSkillIndex]:ResetSkill()
end


return BridgeMgr
