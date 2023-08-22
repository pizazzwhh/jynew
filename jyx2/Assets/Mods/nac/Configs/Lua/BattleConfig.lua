--[[
本文件由编辑器自动生成，如需修改请先修改Excel表格后再使用Unity生成本文件

金庸群侠传3D重制版
https://github.com/jynew/jynew

这是本开源项目文件头，所有代码均使用MIT协议。
但游戏内资源和第三方插件、dll等请仔细阅读LICENSE相关授权协议文档。

金庸老先生千古！
]]
local fieldIdx = {}
fieldIdx.Id = 1
fieldIdx.Name = 2
fieldIdx.MapScene = 3
fieldIdx.Exp = 4
fieldIdx.Music = 5
fieldIdx.TeamMates = 6
fieldIdx.AutoTeamMates = 7
fieldIdx.Enemies = 8
local data = {
{0,[[测试战斗]],[[testbattle]],200,23,{-1},{0},{5,6,7,8}},
{1,[[测试战斗2]],[[BattleSample]],200,23,{77},{0},{61,5}},
{2,[[测试战斗3]],[[testbattle]],200,23,{77,999},{0},{61}},
}
local helper = jy_utils.prequire('Jyx2Configs/BattleHelper')
local mt = {}
mt.__index = function(a,b)
	if fieldIdx[b] then
		return a[fieldIdx[b]]
	end
	if helper[b] then
		return helper[b]
	end
	return nil
end
mt.__metatable = false
for _,v in pairs(data) do
	setmetatable(v,mt)
end
local configMgr = Jyx2:GetModule('ConfigMgr')
configMgr:AddConfigTable([[Battle]], data)