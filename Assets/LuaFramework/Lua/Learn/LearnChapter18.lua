print("----------- Chapter18 Log -----------")

--[[
local sin, asin, ... = math.sin, math.asin, ...
local deg, rad = math.deg, math.rad
math.sin = function(x)
	return sin(rad(x))
end
math.asin = function(x)
	return deg(asin(x))
end

math.randomseed(os.time())

]]--