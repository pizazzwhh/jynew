--提供武学升级与进阶的相关能力
--模块依赖：ConfigMgr，BridgeMgr

---@class SkillMgr 技能模块
local SkillMgr = {}
SkillMgr.SKILLADV_MAX = 4---最大进阶等级（0阶为初始武学）
SkillMgr.SKILLIDINTERVAL_STR = "000"--进阶后的武学ID格式应为   {原始ID}{SKILLIDINTERVAL_STR}{阶级（非0）}

---判断队伍中角色是否有可以升级的武学
---@param roleId any 为nil时代表主角
---@return boolean
function SkillMgr:JudgeCanUpSkill(roleId)
    if roleId == nil then
        roleId = 0
    end

    local ret = Jyx2.BridgeMgr:GetTeamRoleSkillIdsByLevel(roleId, 9, 2)
    return ret ~= nil and #ret > 0
end

---获取队伍中角色可以升级的武学id
---@param roleId any 为nil时代表主角
---@return table|nil
function SkillMgr:GetCanUpSkill(roleId)
    if roleId == nil then
        roleId = 0
    end

    return Jyx2.BridgeMgr:GetTeamRoleSkillIdsByLevel(roleId, 9, 2)
end

---判断队伍中角色是否有可以进阶的武学
---@param roleId any 为nil时代表主角
---@return boolean
function SkillMgr:JudgeCanAdvSkill(roleId)
    if roleId == nil then
        roleId = 0
    end

    local ret = Jyx2.BridgeMgr:GetTeamRoleSkillIdsByLevel(roleId,10)
    if ret == nil then
        return false
    end
    --[[print("teamRoleSkills,roleId:"..roleId)
    for index, value in ipairs(ret) do
        print(value)
    end
    print("end")
    --]]

    return ret ~= nil and #ret > 0
end

---获取队伍中角色可以进阶的武学Id
---@param roleId any 为nil时代表主角
---@return table|nil 
function SkillMgr:GetCanAdvSkill(roleId)
    if roleId == nil then
        roleId = 0
    end

    local ret = Jyx2.BridgeMgr:GetTeamRoleSkillIdsByLevel(roleId, 10)
    return ret
end

---升级角色的武学
---@param roleId any 角色id
---@param skillId any 武学id
---@param addLevel any 要升的级数
---@return boolean state 升级状态
---@return string message 输出消息
---@return number levelUpNumber 实际上所升的级数
function SkillMgr:SkillUp(roleId, skillId, addLevel)
    local skillInstance = Jyx2.BridgeMgr:GetSkillInRole(roleId, skillId)
    --print("roleId:"..roleId..",skillId:"..skillId)
    --print("isNull?:"..tostring(skillInstance == nil))

    local skillLevel = Jyx2.BridgeMgr:GetSkillLevel(skillInstance)
    if skillLevel >= 10 then
        return false, "武学已满级", 0
    end

    local targetLevel = skillLevel + addLevel
    if targetLevel > 10 then
        targetLevel = 10
    elseif targetLevel < 1 then
        targetLevel = 1
    end

    local targetLevelExp = (targetLevel - 1)*100

    local skillIndex = Jyx2.BridgeMgr:GetSkillIndex(roleId, skillId)

    Jyx2.BridgeMgr:SetSkillInRole(roleId, skillIndex, skillId, targetLevelExp)

    return true, "武学已升至"..targetLevel.."级", targetLevel - skillLevel
end

---进阶角色的武学
---@param roleId integer 角色id
---@param skillId integer 武功id
---@return boolean state 进阶状态
---@return string message 输出消息
function SkillMgr:SkillAdv(roleId, skillId)
    local idStr = tostring(skillId)
    local strLen = #idStr
    local subId = idStr
    local subClass

    --如果长度大于等于5，则判定为进阶后的武学
    if strLen >= 5 then
        --使用字符串拆分，当id为200002的格式会出现问题
        --local strs = Jyx2.Util:StringSplit(idStr, self.SKILLIDINTERVAL_STR)
        --subId = strs[1]
        --subClass = tonumber(strs[2])
        subClass = tonumber(string.sub(idStr, -1, -1))
        subId = string.sub(idStr, 1, -(#self.SKILLIDINTERVAL_STR+2))
    else
        subClass = 0
    end

    --print("id:"..idStr)
    --print("subId:"..subId)
    --print("subClass:"..subClass)

    if subClass >= self.SKILLADV_MAX then
        return false, "武功已是最高阶"
    end

    local targetClass = subClass + 1
    local targetSKillId = subId..self.SKILLIDINTERVAL_STR..tostring(targetClass)

    local targetSKillIdInt = tonumber(targetSKillId)
    local skillIndex = Jyx2.BridgeMgr:GetSkillIndex(roleId, skillId)

    --print("目标武学ID:"..targetSKillId)

    Jyx2.BridgeMgr:SetSkillInRole(roleId, skillIndex, targetSKillIdInt, 0)
    
    return true, "武学进阶成功!"
end

function SkillMgr:GetSkillAdvId(skillId, skillClass)
    local idStr = tostring(skillId)
    local strLen = #idStr
    local subId = idStr

    --如果长度大于等于5，则判定为进阶后的武学
    if strLen >= 5 then
        error("获取武学指定阶级的id应传入原始武学id")
        return -1
    end

    local targetSKillId = subId..self.SKILLIDINTERVAL_STR..tostring(skillClass)
    return tonumber(targetSKillId)
end



return SkillMgr