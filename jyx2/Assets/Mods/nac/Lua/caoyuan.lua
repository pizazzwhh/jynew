local function TalkPrologue()
    Talk(1003, "难道十年前的自然异化又重新上演了？主角，女主退后，我来解决他们！")
    DarkScence()
    Jyx2.Util:ShowMessage0("触发战斗，武馆师傅vs草精灵（必胜）\n胜利后出现大量草精灵，系统提示：武馆师傅体力不支，战亡！")
    LightScence()
    Talk(1004, "我一直很关注你，你一定会成为你父母那样的大英雄！")
    DarkScence()
    ShowToast("话音刚落，女主使出全身力量，用望舒剑奋力一击，击杀了大量草精灵！")
    jyx2_Wait(1)
    ShowToast("女主体力不支，望舒剑被异化精灵夺取，男主获救！")
    jyx2_Wait(1)
    ShowToast("男主发现女主还有呼吸，急忙背着女主回武馆！")
    jyx2_Wait(1)
    LightScence()
end

local function CallOnce()
    TalkPrologue()
end

local function Start()

    scene_api.CallOnce(CallOnce)
end

local function Exit()

end