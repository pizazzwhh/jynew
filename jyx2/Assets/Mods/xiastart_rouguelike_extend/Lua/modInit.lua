--将所有的技能展示时间都减少，加快战斗节奏
function SpeedUpAllSkillAssets()
    local allSkillAssets = CS.Jyx2SkillDisplayAsset.All
    for i = 0, allSkillAssets.Count - 1 do
        local skillAsset = allSkillAssets[i]
        skillAsset.duration = skillAsset.duration * 0.4
    end
end


--SpeedUpAllSkillAssets()