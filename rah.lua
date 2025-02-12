-- its for just rblx test place to use function, cannot use this code own on somewhere, this project is doesnt work on ever


local function enableParticle(particleParent)
	local coroutines = {}

	for _, v in pairs(particleParent:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			local emitDelay = tonumber(v:GetAttribute("EmitDelay"))
			local emitCount = tonumber(v:GetAttribute("EmitCount"))
			table.insert(coroutines, coroutine.create(function()
				task.wait(emitDelay)
				v.Enabled = true
			end))
		end
	end
	for _, co in ipairs(coroutines) do
		coroutine.resume(co)
	end
end

local function disableParticle(particleParent)
	local coroutines = {}

	for _, v in pairs(particleParent:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			local emitDelay = tonumber(v:GetAttribute("EmitDelay"))
			local emitCount = tonumber(v:GetAttribute("EmitCount"))
			table.insert(coroutines, coroutine.create(function()
				task.wait(emitDelay)
				v.Enabled = false
			end))
		end
	end
	for _, co in ipairs(coroutines) do
		coroutine.resume(co)
	end
end

local function emitParticles(particleParent)
	local coroutines = {}

	for _, v in pairs(particleParent:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			local emitDelay = tonumber(v:GetAttribute("EmitDelay"))
			local emitCount = tonumber(v:GetAttribute("EmitCount"))
			table.insert(coroutines, coroutine.create(function()
				task.wait(emitDelay)
				v:Emit(emitCount)
			end))
		end
	end
	for _, co in ipairs(coroutines) do
		coroutine.resume(co)
	end
end


local function emitLight(Light, Bright, Ra, fadeinDelay, fadeoutDelay)
	game:GetService('TweenService'):Create(Light, TweenInfo.new(fadeinDelay), {Brightness = Bright}):Play()
	game:GetService('TweenService'):Create(Light, TweenInfo.new(fadeinDelay), {Range = Ra}):Play()
	wait(lightDelay)
	game:GetService('TweenService'):Create(Light, TweenInfo.new(fadeoutDelay), {Brightness = 0}):Play()
	game:GetService('TweenService'):Create(Light, TweenInfo.new(fadeoutDelay), {Range = 0}):Play()
end


local function emitBeam(Beam, beamdelay, fadeinDelay, fadeoutDelay, z, o)
	game:GetService('TweenService'):Create(Beam, TweenInfo.new(fadeinDelay), {Width0 = z}):Play()
	game:GetService('TweenService'):Create(Beam, TweenInfo.new(fadeinDelay), {Width1 = o}):Play()
    wait(beamdelay)
	game:GetService('TweenService'):Create(Beam, TweenInfo.new(fadeoutDelay), {Width0 = 0}):Play()
	game:GetService('TweenService'):Create(Beam, TweenInfo.new(fadeoutDelay), {Width1 = 0}):Play()
end