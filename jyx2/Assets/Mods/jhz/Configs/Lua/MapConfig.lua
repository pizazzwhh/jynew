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
{0,[[胡居]],[[00_hufeiju]],[[Leave:2]],-1,0,1,"",""},
{1,[[江湖客栈]],[[01_heluokezhan]],[[Leave:0,Leave2:11,Leave3:21,Leave4:31,Leave5:41,Leave6:51,Leave7:61,Leave8:71]],2,19,0,[[START:0]],[[01_jianghukezhan]]},
{2,[[云崖]],[[02_yunheya]],[[Leave:3]],-1,19,1,"",""},
{3,[[有间客栈]],[[03_youjiankezhan]],[[Leave:4]],2,19,0,"",""},
{4,[[昆仑]],[[04_kunlunxianjing]],[[Leave:5]],8,12,1,[[POINTLIGHT]],""},
{5,[[闯王]],[[05_shandong]],[[Leave:6]],12,0,1,[[POINTLIGHT]],""},
{6,[[北居]],[[06_beichouju]],[[Leave:7]],11,19,1,"",""},
{7,[[神洞]],[[07_shandong]],[[Leave:9]],12,16,1,[[POINTLIGHT]],""},
{8,[[大轮寺]],[[08_dalunsi]],[[Leave:9]],4,0,1,"",""},
{9,[[成居]],[[09_chengkunju]],[[Leave:10]],-1,0,1,"",""},
{10,[[蜘蛛洞]],[[10_shandong]],[[Leave:1]],12,19,1,[[POINTLIGHT]],""},
{11,[[明顶]],[[11_guangmingding]],[[Leave:13]],10,0,1,"",""},
{12,[[明舵]],[[12_mingjiaofenduo]],[[Leave:13]],-1,0,1,"",""},
{13,[[明道]],[[13_mingjiaodidao]],[[Leave:14]],12,16,1,"",""},
{14,[[高宫]],[[14_gaochangmigong]],[[Leave:15]],12,16,1,[[POINTLIGHT]],""},
{15,[[沙墟]],[[15_shamofeixu]],[[Leave:16]],12,16,1,"",""},
{16,[[金寺]],[[16_jinlunsi]],[[Leave:17]],4,0,1,"",""},
{17,[[回落]],[[17_huizubuluo]],[[Leave:20]],4,16,1,"",""},
{18,[[古墓]],[[18_gumu]],[[Leave:19]],12,16,1,[[POINTLIGHT]],""},
{19,[[重宫]],[[19_chongyanggong]],[[Leave:20]],22,0,1,"",""},
{20,[[百谷]],[[20_baihuagu]],[[Leave:1]],13,19,1,"",""},
{21,[[黑潭]],[[21_heilongtan]],[[Leave:23]],8,16,1,[[NONAVAGENT]],""},
{22,[[绝谷]],[[22_jueqinggu]],[[Leave:23]],-1,16,1,"",""},
{23,[[洪居]],[[23_hongqigongju]],[[Leave:24]],-1,0,1,"",""},
{24,[[苗居]],[[24_miaorenfengju]],[[Leave:26]],-1,16,1,"",""},
{25,[[武会]],[[25_wudaodahui]],[[Leave:26]],15,19,1,"",""},
{26,[[黑崖]],[[26_heimuya]],[[Leave:29]],-1,16,1,"",""},
{27,[[嵩山]],[[27_songshanpai]],[[Leave:28]],-1,0,1,"",""},
{28,[[少林]],[[28_shaolinsi]],[[Leave:29]],20,0,1,"",""},
{29,[[泰山]],[[29_taishanpai]],[[Leave:30]],22,0,1,"",""},
{30,[[指居]],[[30_pingyizhiju]],[[Leave:1]],-1,0,1,"",""},
{31,[[恒山]],[[31_hengshanpai]],[[Leave:32]],21,0,1,"",""},
{32,[[海边]],[[32_haibianxiaowu]],[[Leave:33]],1,19,1,"",""},
{33,[[峨嵋]],[[33_emeipai]],[[Leave:34]],23,0,1,"",""},
{34,[[崆峒]],[[34_kongtongpai]],[[Leave:35]],-1,0,1,"",""},
{35,[[星宿]],[[35_xingxiuhai]],[[Leave:38]],4,0,1,"",""},
{36,[[青城]],[[36_qingchengpai]],[[Leave:37]],-1,16,1,"",""},
{37,[[五毒]],[[37_wudujiao]],[[Leave:38]],-1,19,1,"",""},
{38,[[摩天]],[[38_motianya]],[[Leave:40]],-1,16,1,"",""},
{39,[[凌霄]],[[39_lingxiaocheng]],[[Leave:40]],4,0,1,"",""},
{40,[[悦来]],[[40_yuelaikezhan]],[[Leave:1]],2,19,0,"",""},
{41,[[神山]],[[41_shandong]],[[Leave:43]],12,16,1,[[POINTLIGHT]],""},
{42,[[无洞]],[[42_wuliangshandong]],[[Leave:43]],12,16,1,[[POINTLIGHT]],""},
{43,[[武当]],[[43_wudangpai]],[[Leave:44]],22,0,1,"",""},
{44,[[蝴蝶]],[[44_hudiegu]],[[Leave:45]],-1,16,1,"",""},
{45,[[程居]],[[45_chengyingju]],[[Leave:46]],8,19,1,"",""},
{46,[[金洞]],[[46_jinsheshandong]],[[Leave:47]],12,0,1,[[POINTLIGHT]],""},
{47,[[灯居]],[[47_yidengju]],[[Leave:49]],8,16,1,"",""},
{48,[[铁山]],[[48_tiezhangshan]],[[Leave:49]],-1,0,1,"",""},
{49,[[药王]],[[49_yaowangzhuang]],[[Leave:50]],1,16,1,"",""},
{50,[[阎居]],[[50_yanjiju]],[[Leave:1]],1,19,1,"",""},
{51,[[丐帮]],[[51_gaibang]],[[Leave:54]],-1,16,1,"",""},
{52,[[燕子]],[[52_yanziwu]],[[Leave:53]],1,0,1,"",""},
{53,[[擂山]],[[53_leigushan]],[[Leave:54]],-1,16,1,"",""},
{54,[[华居]],[[54_xuemuhuaju]],[[Leave:56]],-1,0,1,"",""},
{55,[[梅庄]],[[55_meizhuang]],[[Leave:56]],1,0,1,"",""},
{56,[[福局]],[[56_fuweibiaoju]],[[Leave:57]],9,16,1,"",""},
{57,[[华山]],[[57_huashanpai]],[[Leave:58]],-1,0,1,"",""},
{58,[[衡山]],[[58_hengshanpai]],[[Leave:59]],-1,0,1,"",""},
{59,[[田居]],[[59_tianboguangju]],[[Leave:60]],-1,0,1,"",""},
{60,[[龙门]],[[60_longmenkezhan]],[[Leave:1]],2,19,0,"",""},
{61,[[高升]],[[61_gaoshengkezhan]],[[Leave:62]],2,19,0,"",""},
{62,[[破庙]],[[62_pomiao]],[[Leave:63]],-1,0,1,"",""},
{63,[[天宁]],[[63_tianningsi]],[[Leave:64]],-1,0,1,"",""},
{64,[[南居]],[[64_nanxianju]],[[Leave:65]],11,0,0,"",""},
{65,[[唐诗]],[[65_shandong]],[[Leave:66]],12,19,1,[[POINTLIGHT]],""},
{66,[[冰蚕]],[[66_shandong]],[[Leave:67]],12,16,1,[[POINTLIGHT]],""},
{67,[[昆仑二]],[[67_shandong]],[[Leave:69]],12,16,1,[[POINTLIGHT]],""},
{68,[[昆派]],[[68_kunlunpai]],[[Leave:69]],4,0,1,"",""},
{69,[[白驼]],[[69_baituoshan]],[[Leave:70]],4,0,1,"",""},
{70,[[米居]],[[70_xiaoxiamiju]],[[Leave:1]],-1,19,0,"",""},
{71,[[龙教]],[[71_shenlongjiao]],[[Leave:73]],-1,0,1,"",""},
{72,[[火岛]],[[72_binghuodao]],[[Leave:73]],12,16,1,[[POINTLIGHT]],""},
{73,[[蛇岛]],[[73_lingshedao]],[[Leave:75]],-1,0,1,"",""},
{74,[[侠岛]],[[74_xiakedao]],[[Leave:75]],12,16,1,"",""},
{75,[[花岛]],[[75_taohuadao]],[[Leave:76]],-1,0,1,"",""},
{76,[[霹堂]],[[76_pilitang]],[[Leave:78]],-1,19,1,"",""},
{77,[[鳄岛]],[[77_wanedao]],[[Leave:78]],-1,19,1,"",""},
{78,[[泥岛]],[[78_bonidao]],[[Leave:79]],-1,0,1,"",""},
{79,[[鸳鸯山]],[[79_shandong]],[[Leave:80]],12,19,1,"",""},
{80,[[情谷底]],[[80_jueqinggudi]],[[Leave:1]],9,16,1,"",""},
{81,[[思过崖]],[[81_siguoya]],[[Leave:1]],16,19,1,"",""},
{82,[[梅庄地牢]],[[82_meizhuangdilao]],[[Leave:1]],12,1,1,"",""},
{83,[[圣堂]],[[83_shengtang]],[[Leave:1]],17,19,1,[[POINTLIGHT]],""},
{1000,[[大地图]],[[1000_daditu]],[[-1]],19,-1,0,[[WORLDMAP]],""},
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