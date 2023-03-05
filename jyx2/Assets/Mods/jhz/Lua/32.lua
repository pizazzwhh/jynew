Talk(34, "你要和我一个人打吗");
if AskBattle() == true then
    goto danTiao
else
    Talk(34, "那你是要打我一队？！");
    if AskBattle() == true then
        goto qunOu
    else
        Talk(34, "哈，怕了吧")
        do return end;
    end
end;

::danTiao::

if TryBattle(31) == true then
    ShowMessage("单挑赢了");
    AddItem(174,3);
else
    ShowMessage("单挑输了");
end;
do return end;

::qunOu::

if TryBattle(91) == true then
    ShowMessage("群殴赢了");
    AddRepute(10);
    AddItem(174,3);
else
    ShowMessage("群殴输了");
end;
do return end;
