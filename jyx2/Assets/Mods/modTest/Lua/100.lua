Talk(190, "来啊,过两招");
if AskBattle() == true then goto label0 end;
    Talk(0, "不敢,不敢……");
    do return end;
::label0::
    Talk(0, "来");
    Talk(190, "痛快");
if TryBattle(1) == true then goto label1 end;
    Talk(190, "啊哈,你个菜鸡");
    do return end;
::label1::
    Talk(190, "高手,高手!");
    do return end;
