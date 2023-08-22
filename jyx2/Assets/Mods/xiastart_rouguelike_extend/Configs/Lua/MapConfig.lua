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
fieldIdx.TransportToMap = 4
fieldIdx.InMusic = 5
fieldIdx.OutMusic = 6
fieldIdx.EnterCondition = 7
fieldIdx.Tags = 8
fieldIdx.BindScript = 9
local data = {
{0,[[寝丘]],[[00_main]],[[Leave:1]],19,-1,0,"",[[qinqiu]]},
{1,[[祥和镇]],[[01_xianghezhen]],[[Leave:0,Leave2:2]],15,-1,0,[[START:0]],[[mainscene]]},
{2,[[迷途森林]],[[04_senlin]],[[Leave:1,Leave2:3]],17,-1,0,"",[[scene2]]},
{1000,[[大地图]],[[1000_daditu]],[[-1]],0,-1,0,[[WORLDMAP]],""},
}
local helper = jy_utils.prequire('Jyx2Configs/MapHelper')
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
configMgr:AddConfigTable([[Map]], data)