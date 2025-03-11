-- its for just rblx test place to use function, cannot use this code own on somewhere, this project is doesnt work on ever only things


local function enableParticle(particleParent, truefalse)
	local coroutines = {}

	for _, v in pairs(particleParent:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			local emitDelay = tonumber(v:GetAttribute("EmitDelay"))
			local emitCount = tonumber(v:GetAttribute("EmitCount"))
			table.insert(coroutines, coroutine.create(function()
				task.wait(emitDelay)
				if truefalse == true then 
					v.Enabled = true
				else
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
	local coroutines = {}
	table.insert(coroutines, coroutine.create(function()
		game:GetService('TweenService'):Create(Light, TweenInfo.new(fadeinDelay), {Brightness = Bright}):Play()
		game:GetService('TweenService'):Create(Light, TweenInfo.new(fadeinDelay), {Range = Ra}):Play()
		task.wait(lightDelay)
		game:GetService('TweenService'):Create(Light, TweenInfo.new(fadeoutDelay), {Brightness = 0}):Play()
		game:GetService('TweenService'):Create(Light, TweenInfo.new(fadeoutDelay), {Range = 0}):Play()
	end)
	for _, co in ipairs(coroutines) do
		coroutine.resume(co)
	end
end


local function emitBeam(Beam, beamdelay, fadeinDelay, fadeoutDelay, z, o)
	local coroutines = {}
	table.insert(coroutines, coroutine.create(function()
		game:GetService('TweenService'):Create(Beam, TweenInfo.new(fadeinDelay), {Width0 = z}):Play()
		game:GetService('TweenService'):Create(Beam, TweenInfo.new(fadeinDelay), {Width1 = o}):Play()
		task.wait(beamdelay)
		game:GetService('TweenService'):Create(Beam, TweenInfo.new(fadeoutDelay), {Width0 = 0}):Play()
		game:GetService('TweenService'):Create(Beam, TweenInfo.new(fadeoutDelay), {Width1 = 0}):Play()
	end)
	for _, co in ipairs(coroutines) do
		coroutine.resume(co)
	end
end

local function emitMesh(Part, sidelay, fadeinDelay, fadeoutDelay, Cframe0, Cframe1, Size0, Size1, transparency0, transparency1)
	local coroutines = {}
	table.insert(coroutines, coroutine.create(function()
		game:GetService('TweenService'):Create(Part, TweenInfo.new(fadeinDelay), {Cframe = Cframe0})
		game:GetService('TweenService'):Create(Part, TweenInfo.new(fadeinDelay), {Size = Size0})
		Part.Transparency = transparency0
		task.wait(sidelay)
		game:GetService('TweenService'):Create(Part, TweenInfo.new(fadeoutDelay), {Cframe = Cframe1})
		game:GetService('TweenService'):Create(Part, TweenInfo.new(fadeoutDelay), {Size = Size1})
		game:GetService('TweenService'):Create(Part, TweenInfo.new(fadeoutDelay), {Transparency = transparency1})
	end)
	for _, co in ipairs(coroutines) do
		coroutine.resume(co)
	end
end