Talk(31, "你要和我一个人打吗");
if AskBattle() == true then
    goto danTiao
else
    Talk(31, "那你是要打我一队？！");
    if AskBattle() == true then
        goto qunOu
    else
        Talk(31, "哈，怕了吧")
        do return end;
    end
end;

::danTiao::

if TryBattle(28) == true then
    ShowMessage("单挑赢了");
    AddItem(174,3);
    AddItem(1005,3);
else
    ShowMessage("单挑输了");
end;
do return end;

::qunOu::

if TryBattle(88) == true then
    ShowMessage("群殴赢了");
    AddRepute(10);
    AddItem(174,10);
    AddItem(1005,3);
else
    ShowMessage("群殴输了");
end;
do return end;
