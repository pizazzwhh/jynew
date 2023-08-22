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
fieldIdx.ItemConfig = 3
fieldIdx.ItemCountMin = 4
fieldIdx.ItemCountMax = 5
fieldIdx.IsRepeat = 6
fieldIdx.ExpConfigMin = 7
fieldIdx.ExpConfigMax = 8
fieldIdx.MoneyConfigMin = 9
fieldIdx.MoneyConfigMax = 10
local data = {
{0,[[测试掉落]],{{0,3},{1,10},{2,40}},3,3,false,200,300,10,20},
{1,[[测试掉落2]],{{0,3},{1,10},{2,40}},1,5,true,200,300,10,20},
{2,[[随机大礼包]],{{200,2},{201,15}},3,7,true,-1,-1,1,1000},
{3,[[随机大礼包]],{{200,2},{201,15},{1,2},{2,2},{-1,4}},4,4,false,-1,-1,1,1000},
{4,[[战斗奖励]],{{200,1},{201,10},{34,5},{35,6},{101,8},{105,8},{19,10},{20,10}},1,1,true,-1,-1,1,1000},
}
local helper = jy_utils.prequire('Jyx2Configs/LootHelper')
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
local fieldIdxItemConfig = {}
fieldIdxItemConfig.ItemId = 1
fieldIdxItemConfig.Weight = 2
local mtItemConfig = {}
mtItemConfig.__index = function(a,b)
	if fieldIdxItemConfig[b] then
		return a[fieldIdxItemConfig[b]]
	end
	return nil
end
mtItemConfig.__metatable = false
for _,v in pairs(data) do
	for _,t in pairs(v.ItemConfig) do
		if type(t) == 'table' then
			setmetatable(t,mtItemConfig)
		end
	end
end
local configMgr = Jyx2:GetModule('ConfigMgr')
configMgr:AddConfigTable([[Loot]], data)