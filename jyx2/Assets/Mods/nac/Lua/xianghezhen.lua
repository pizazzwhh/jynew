
local function TalkWuguanshifu()
    --武馆师傅1003
    --王胖子1000
    --1001,1002
    Talk(1003, "大家都到齐了，我们就开始吧，今天的任务是户外的体力训练！")
    Talk(1000, "又是体力训练，这下完了！")
    Talk(0, "师傅，我不练武，可以不参与吗？")
    Talk(1003, "林佑之，你父母用其生命为代价铸得双剑，望舒，羲和，以此双剑才使得村庄十年免受自然异化的侵蚀。你要像你父母那样做一个顶天立地的大英雄！")
    Talk(0, "为什么要做英雄，做英雄就一定要死吗？")
    Talk(1001, "……")
    Talk(1002, "……")
    Talk(1000, "……")
    Talk(1003, "好了好了，你们也长大了，马上也要独当一面了，你们要像顾惜如学习，顾惜如从小刻苦习武，现在已成为望舒剑主了！")
    Talk(1003, "我们分2队训练，一队由我，林佑之，顾惜如一起。一队由王阳，苏墨，易武一起，那大家准备出发吧！")
    DarkScence()
    Jyx2.Util:ShowMessage0("武馆师傅，顾惜如入队\n隐藏场景NPC")
    LightScence()
end

local function CallOnce()

end

function Start()
    scene_api.BindEvent("NPC/wuguanshifu", "xianghezhen.TalkWuguanshifu")
    scene_api.BindEvent("NPC/wangyang", "-1")
    scene_api.BindEvent("NPC/yiwu", "-1")
    scene_api.BindEvent("NPC/sumo", "-1")

    scene_api.CallOnce(CallOnce)
end

function Exit()

end