--环境交互,火

local itemId = GetUseItem()
local itemE = GetItemE(itemId)

if itemE == "none" then
    Talk(0, "果然,平平无奇的属性无法与其发生反应")
elseif itemE == "timber" then
    Talk(0, "有反应了,啊,不好")
    if TryBattle(2) then
        ShowMessage("获取精金石的模拟")
    else
        Dead()
    end
else
    Talk(0, "啊,有异常")
    if TryBattle(2) then
        ShowMessage("由于不是元素克制,因此没有精金石")
    else
        Dead()
    end
end

do return end