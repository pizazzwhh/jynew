function Start()
    ShowSelectPanel(1, "测试", {"0", "1", "2", "3", "4", "5", "6", "7", "8"})
    
    --local str = GetFlagGlobal("testKey");
    --ShowMessage("showMessage的测试:"..str);

end

function Exit()
    print("退出MainScene场景");
end