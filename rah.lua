-- its for just rblx test place to use function, cannot use this code own on somewhere, this project is doesnt work on ever only things
local TweenService = game:GetService("TweenService")

local function toNumber(v, default)
    local n = tonumber(v)
    if n == nil then return default end
    return n
end

-- particleParent 안의 모든 ParticleEmitter를 enable/disable (emitDelay 속성 존중)
-- particleParent: Instance, flag: boolean
local function enableParticle(particleParent, flag)
    for _, v in ipairs(particleParent:GetChildren()) do
        if v:IsA("ParticleEmitter") then
            local emitDelay = toNumber(v:GetAttribute("EmitDelay"), 0)
            task.spawn(function()
                if emitDelay > 0 then task.wait(emitDelay) end
                -- 안전하게 Enabled 설정
                pcall(function() v.Enabled = (flag == true) end)
            end)
        end
    end
end

-- ParticleEmitter:Emit을 호출 (EmitDelay, EmitCount 속성 존중)
-- particleParent: Instance
local function emitParticles(particleParent)
    for _, v in ipairs(particleParent:GetChildren()) do
        if v:IsA("ParticleEmitter") then
            local emitDelay = toNumber(v:GetAttribute("EmitDelay"), 0)
            local emitCount = toNumber(v:GetAttribute("EmitCount"), 1)
            task.spawn(function()
                if emitDelay > 0 then task.wait(emitDelay) end
                pcall(function() v:Emit(emitCount) end)
            end)
        end
    end
end

-- 라이트를 페이드 인 -> (hold) -> 페이드 아웃
-- Light: Light Instance (PointLight/SpotLight 등)
-- targetBrightness, targetRange: 숫자
-- holdDelay: (중간에 유지할 시간, 0 가능)
-- fadeInDelay, fadeOutDelay: 숫자
local function emitLight(Light, targetBrightness, targetRange, holdDelay, fadeInDelay, fadeOutDelay)
    targetBrightness = toNumber(targetBrightness, 1)
    targetRange = toNumber(targetRange, 0)
    holdDelay = toNumber(holdDelay, 0)
    fadeInDelay = toNumber(fadeInDelay, 0.15)
    fadeOutDelay = toNumber(fadeOutDelay, 0.2)

    task.spawn(function()
        local tweenIn = TweenService:Create(Light, TweenInfo.new(fadeInDelay), {Brightness = targetBrightness, Range = targetRange})
        tweenIn:Play()
        task.wait(fadeInDelay + holdDelay)
        local tweenOut = TweenService:Create(Light, TweenInfo.new(fadeOutDelay), {Brightness = 0, Range = 0})
        tweenOut:Play()
    end)
end

-- 빔(Beam) 가시화: Width0/Width1으로 페이드 인/아웃
-- Beam: Beam instance
-- holdDelay, fadeInDelay, fadeOutDelay, width0, width1: 숫자
local function emitBeam(Beam, holdDelay, fadeInDelay, fadeOutDelay, width0, width1)
    holdDelay = toNumber(holdDelay, 0.05)
    fadeInDelay = toNumber(fadeInDelay, 0.05)
    fadeOutDelay = toNumber(fadeOutDelay, 0.08)
    width0 = toNumber(width0, 0.5)
    width1 = toNumber(width1, 0.5)

    task.spawn(function()
        -- 시작값이 0이면 안전하게 세팅
        pcall(function()
            Beam.Width0 = 0
            Beam.Width1 = 0
        end)
        local tweenIn0 = TweenService:Create(Beam, TweenInfo.new(fadeInDelay), {Width0 = width0})
        local tweenIn1 = TweenService:Create(Beam, TweenInfo.new(fadeInDelay), {Width1 = width1})
        tweenIn0:Play()
        tweenIn1:Play()
        task.wait(fadeInDelay + holdDelay)
        local tweenOut0 = TweenService:Create(Beam, TweenInfo.new(fadeOutDelay), {Width0 = 0})
        local tweenOut1 = TweenService:Create(Beam, TweenInfo.new(fadeOutDelay), {Width1 = 0})
        tweenOut0:Play()
        tweenOut1:Play()
    end)
end

-- 파트(파티클 메쉬 등)를 움직이고 크기/투명도도 트윈. 
-- 파라미터가 많으므로 순서: Part, holdDelay, fadeInDelay, fadeOutDelay,
--   startCFrame, endCFrame, startSize, endSize, startTransparency, endTransparency
local function emitMesh(Part, holdDelay, fadeInDelay, fadeOutDelay, startCFrame, endCFrame, startSize, endSize, startTransparency, endTransparency)
    holdDelay = toNumber(holdDelay, 0)
    fadeInDelay = toNumber(fadeInDelay, 0.1)
    fadeOutDelay = toNumber(fadeOutDelay, 0.2)
    startTransparency = toNumber(startTransparency, Part.Transparency or 1)
    endTransparency = toNumber(endTransparency, 1)

    task.spawn(function()
        pcall(function()
            if startCFrame then Part.CFrame = startCFrame end
            if startSize then Part.Size = startSize end
            Part.Transparency = startTransparency
        end)

        if fadeInDelay > 0 then
            if startCFrame then
                local t = TweenService:Create(Part, TweenInfo.new(fadeInDelay), {CFrame = startCFrame})
                t:Play()
            end
            if startSize then
                local t2 = TweenService:Create(Part, TweenInfo.new(fadeInDelay), {Size = startSize})
                t2:Play()
            end
            task.wait(fadeInDelay)
        end

        task.wait(holdDelay)

        local outTweens = {}
        if endCFrame then
            table.insert(outTweens, TweenService:Create(Part, TweenInfo.new(fadeOutDelay), {CFrame = endCFrame}))
        end
        if endSize then
            table.insert(outTweens, TweenService:Create(Part, TweenInfo.new(fadeOutDelay), {Size = endSize}))
        end
        table.insert(outTweens, TweenService:Create(Part, TweenInfo.new(fadeOutDelay), {Transparency = endTransparency}))
        for _, tw in ipairs(outTweens) do tw:Play() end
    end)
end
