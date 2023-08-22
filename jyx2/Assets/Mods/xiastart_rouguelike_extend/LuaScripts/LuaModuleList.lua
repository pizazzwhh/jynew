--[[
 * 金庸群侠传3D重制版
 * https://github.com/jynew/jynew
 *
 * 这是本开源项目文件头，所有代码均使用MIT协议。
 * 但游戏内资源和第三方插件、dll等请仔细阅读LICENSE相关授权协议文档。
 *
 * 金庸老先生千古！
 ]]--
-- 本脚本负责注册 Lua 模块
-- moduleName = modulePath
local LuaModuleList = {
    ConfigMgr = "Jyx2Configs/Jyx2ConfigMgr",
    Battle = "Jyx2Battle/BattleInit",
    BridgeMgr = "BridgeMgr",
    Util = "Util",
    LootMgr = "LootMgr",
    SkillMgr = "SkillMgr",
    UIHelper = "UIHelper",

}

---@class Jyx2
---@field BridgeMgr BridgeMgr 桥接模块
---@field ConfigMgr ConfigMgr 配置模块
---@field Battle Battle 战斗模块
---@field Util Util 通用模块
---@field LootMgr LootMgr 战利品模块
---@field SkillMgr SkillMgr 技能模块
---@field UIHelper UIHelper UI帮助模块
local t = {}


return LuaModuleList
