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
{0,[[初始场景]],[[MainScene]],[[Leave:1]],19,-1,0,[[START:0]],[[mainscene]]},
{1,[[祥和镇]],[[01_xianghezhen]],[[Leave:0,Leave2:2]],15,-1,0,"",[[wumingshangu]]},
{2,[[草原]],[[02_caoyuan]],[[Leave:1,Leave2:3]],17,-1,0,"",[[caoyuan]]},
{3,[[破劫堡]],[[03_pojiebao]],[[Leave:2,Leave2:4]],19,-1,0,"",""},
{4,[[森林]],[[04_senlin]],[[Leave:3]],5,-1,0,"",""},
{5,[[怡麟楼]],[[05_yilinlou]],[[Leave:1000]],14,-1,0,"",""},
{6,[[将军府]],[[06_jiangjunfu]],[[Leave:1000]],8,-1,0,"",""},
{7,[[曼陀谷]],[[07_yingsugu]],[[Leave:1000]],18,-1,0,"",""},
{8,[[鸽子楼]],[[08_gezilou]],[[Leave:1000,Leave2:15]],18,-1,0,"",""},
{9,[[牛头岭]],[[09_niutouling]],[[Leave:1000]],15,-1,0,"",""},
{10,[[滨湖茅庐]],[[10_binhumaolu]],[[Leave:1000]],16,-1,0,"",""},
{11,[[水果摊]],[[11_shuiguotan]],[[Leave:1000]],12,-1,0,"",""},
{12,[[隋仙堂]],[[12_suixiantang]],[[Leave:1000]],16,-1,0,"",""},
{13,[[野狼谷]],[[13_yelanggu]],[[Leave:1000,Leave2:14]],10,-1,0,"",""},
{14,[[野狼洞]],[[14_yelangdong]],[[Leave:13]],9,-1,0,"",""},
{15,[[鸽子笼台]],[[15_gezilongtai]],[[Leave:8]],-1,-1,0,"",""},
{16,[[黑熊谷]],[[16_heixionggu]],[[Leave:1000]],11,-1,0,"",""},
{17,[[罗记饼行]],[[17_luojibinghang]],[[Leave:1000]],12,-1,0,"",""},
{18,[[无名窟]],[[18_wumingku]],[[Leave:1000]],9,-1,0,"",""},
{19,[[无际坊]],[[19_wujifang]],[[Leave:1000]],15,-1,0,"",""},
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