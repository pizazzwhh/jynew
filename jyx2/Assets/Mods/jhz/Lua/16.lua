Talk(1, "你好", "talkname1", 0);
Talk(0, "你好", "talkname0", 1);
if AskBattle() == true then goto label0 end;
    do return end;
::label0::
    Talk(0, "晚辈斗胆向前辈讨教讨教。", "talkname0", 1);
    if TryBattle(15) == false then goto label1 end;
        LightScence();
        Talk(1, "可恨啊！可恨！只恨胡某刀谱不全，未能练成我祖传之胡家刀法……", "talkname1", 0);
        do return end;
::label1::
        LightScence();
        Talk(1, "小兄弟，功夫虽有精进，但火候仍嫌不够。", "talkname1", 0);
        Talk(0, "他日再向胡大哥领教刀法。", "talkname0", 1);
do return end;
