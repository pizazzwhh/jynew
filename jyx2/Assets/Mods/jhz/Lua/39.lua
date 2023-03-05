Talk(45, "你要和我一个人打吗");
if AskBattle() == true then
    goto danTiao
else
    Talk(45, "那你是要打我一队？！");
    if AskBattle() == true then
        goto qunOu
    else
        Talk(45, "哈，怕了吧")
        do return end;
    end
end;

::danTiao::

if TryBattle(38) == true then
    ShowMessage("单挑赢了");
    AddItem(174,3);
else
    ShowMessage("单挑输了");
end;
do return end;

::qunOu::

if TryBattle(98) == true then
    ShowMessage("群殴赢了");
    AddRepute(10);
    AddItem(174,3);
else
    ShowMessage("群殴输了");
end;
do return end;
