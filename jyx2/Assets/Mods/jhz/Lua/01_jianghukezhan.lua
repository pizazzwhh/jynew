--[
--#region
Jyx2.SkillMgr = require "SkillMgr"
Jyx2.LootMgr = require "LootMgr"
Jyx2.BridgeMgr = require "BridgeMgr"
Jyx2.UIHelper = require "UIHelper"
Jyx2.Util = require "Util"
--#endregion
--]]


local id_xiaoer = 1000;
local id_player = 0;

--必须，进入场景调用
function Start()
    --快速绑定事件到物体
    scene_api.BindEvent("NPC/店小二", "01_jianghukezhan.TalkXiaoer")
    scene_api.BindEvent("NPC/韦小宝", "01_jianghukezhan.TalkMerchant")

    --快速绑定flag到物体控制是否显示
    --scene_api.Register("NPC/Nanxian")
    --scene_api.Register("NPC/Beichou")

    --整个场景只调用一次
    scene_api.CallOnce(FirstTimeAccessScene)
end

--必须，退出场景
function Exit()

end

--只调用一次
function FirstTimeAccessScene()
    ShowMessage("系统提示：这一天主角做梦，梦见自己到了一个江湖集市的梦境，成为天下第一，为求一败而不得，顾自废武功，突然惊醒，原来是一场梦。")
    Talk(id_player,"(心想)呼！原来是梦，这是哪里，我怎么在这个鬼地方？")
    Talk(id_player, "前面有个客栈小二，我去问问。")
    AddItem(1006,1)
    AddItem(1007,1)
    AddItem(1008,1)
    AddItem(1009,1)
end

--与小二对话
function TalkXiaoer()
    Talk(id_player, "小二，这是什么地方？")
    Talk(id_xiaoer, "大侠，你可算醒了，几天前你喝的大醉，昏了好几天呢，这里是有名的江湖客栈，来到这里的客人，不完成八道关卡是走不出去的哦。")
    Talk(id_player, "黑店啊！");
    Talk(id_xiaoer, "别大呼小叫影响我做生意，我去招待客人了。");
    Talk(id_player, "刚从无限战斗的地狱醒来，又来到这个黑店。。。。。。");
    Jyx2.BridgeMgr:AddPlayerMoney(5, true);
end

--与商人对话
function TalkMerchant()
    WeiShop();
end






