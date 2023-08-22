--对UI面板封装模块
--模块依赖：ConfigMgr，SkillMgr

---@class UIHelper UI帮助模块
local UIHelper = {}

---显示技能选择面板
---@param skillIds any C#Array<int>
---@param talkContent any
---@param talkRoleId any
---@return number selectSkillId
function UIHelper:ShowSKillSelectPanel(skillIds, talkContent, talkRoleId)
    local skillNames = {}

    for index, value in ipairs(skillIds) do
        local id = value
        local skillName = Jyx2.ConfigMgr.Skill[id].Name

        table.insert(skillNames, skillName)
    end

    --添加取消的选择项
    table.insert(skillNames, "取消")
    local ret = ShowSelectPanel(talkRoleId, talkContent, skillNames)

    --如果选择了取消
    if ret == #skillNames - 1 then
        return -1
    end
    --ShowMessage("你选择ID:"..skillIDs[ret].." name:"..skillNames[ret+1])

    return skillIds[ret+1]
end

local function GetTeamNames(teamIds)
    local ret = {}

    for i = 0, teamIds.Count - 1, 1 do
        local roleInstance = BridgeMgr:GetRoleInTeam(teamIds[i])
        table.insert(ret, roleInstance.Name)
    end

    return ret
end

function UIHelper:ShowTeamSelectPanel(talkRoleId,talkContent)
    local teamIds = Jyx2.BridgeMgr:GetTeamIds()
    local ruleNames = GetTeamNames(teamIds)

    --添加取消的选择项
    table.insert(ruleNames, "取消")
    local ret = ShowSelectPanel(talkRoleId, talkContent, ruleNames)

    --如果选择了取消
    if ret == #ruleNames - 1 then
        return -1
    end

    return teamIds[ret]
end

function UIHelper:ShowCanUpSkillSelectPanel(talkRoleId, roleId)
    local skillIDs = Jyx2.SkillMgr:GetCanUpSkill(roleId)
    local ret = UIHelper:ShowSKillSelectPanel(skillIDs, "选择要<color=yellow>升级</color>的武学\n升级武学需要升级丹", talkRoleId)
    return ret
end

function UIHelper:ShowAllSkillsSelectPanel(talkRoleId, roleId, msg)
    if msg == nil then
        msg = "选择要遗忘的武学"
    end
    local skillIds = Jyx2.BridgeMgr:GetTeamRoleSkillIdsByLevel(roleId, 0, 0)
    local ret = UIHelper:ShowSKillSelectPanel(skillIds, msg, talkRoleId)
    return ret
end

function UIHelper:ShowCanAdvSkillSelectPanel(talkRoleId, roleId)
    local skillIDs = Jyx2.SkillMgr:GetCanAdvSkill(roleId)
    --print("skillIds.Count:"..#skillIDs)
    return UIHelper:ShowSKillSelectPanel(skillIDs, "选择要<color=yellow>进阶</color>的武学\n进阶武学需要进阶丹",talkRoleId)
end

return UIHelper