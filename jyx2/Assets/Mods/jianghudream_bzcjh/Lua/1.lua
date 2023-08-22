local talkId = 1  --对话人物的id
local danTiaoId = 0  --单挑的战斗id
local qunOuId = 1  --群殴的战斗id

Talk(talkId, "你要和我单挑吗");
if AskBattle() == true then
    goto danTiao
else
    Talk(talkId, "那你是要群殴我？！");
    if AskBattle() == true then
        goto qunOu
    else
        Talk(talkId, "哈，怕了吧")
        do return end;
    end
end;

::danTiao::

if TryBattle(danTiaoId) == true then
    ShowMessage("单挑赢了");
else
    ShowMessage("单挑输了");
end;
do return end;

::qunOu::

if TryBattle(qunOuId) == true then
    ShowMessage("群殴赢了");
else
    ShowMessage("群殴输了");
end;
do return end;