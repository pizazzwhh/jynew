local EIMgr = {}

function EIMgr:InitEI(refreshPointTable, ETable)
    if refreshPointTable == nil or #refreshPointTable <= 0 or ETable == nil or #ETable <= 0 then
        return -1
    end

    local now = os.time()
    math.randomseed(now)
    local ran = math.random(1, #ETable)

    --随机一个元素
    local ranE = ETable[ran];

    --获取与当前元素对应的刷新点
    local eObjs = {}

    for index, value in ipairs(refreshPointTable) do
        local objName = string.sub(value, 5)
        local strs = Jyx2.Util.StringSplit(objName, "_")
        if(strs[1] ~= "EI") then
            return -1
        end

        local e = strs[2]
        if e == ranE then
            table.insert(eObjs, value)
        end
    end

    if #eObjs == 0 then
        return -1
    end

    --指定元素的刷新点内再随机一个出来
    local ranEObjIndex = math.random(1, #eObjs)
    local eobj = eObjs[ranEObjIndex]
    
    local eEventId = 0;
    local toastE;
    if ranE == "gold" then
        eEventId = 0;
        toastE = "<color=#FFC107>金</color>"
    elseif ranE == "timber" then
        eEventId = 1;
        toastE = "<color=#388E3C>木</color>"
    elseif ranE == "water" then
        eEventId = 2;
        toastE = "<color=#03A9F4>水</color>"
    elseif ranE == "fire" then
        eEventId = 3;
        toastE = "<color=#E64A19>火</color>"
    elseif ranE == "soil" then
        eEventId = 4;
        toastE = "<color=#795548>土</color>"
    end

    SetGameEvent(eobj, nil, eEventId, nil)

    print("元素:"..ranE..",\n对象:"..eobj)
    ShowMessage("环境交互".. toastE.."已刷新")
end

return EIMgr