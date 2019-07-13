print("----------- Chapter17 Log -----------")

a = {}
b = {__mode = "k"}
setmetatable(a, b)	--现在a的key就是弱引用
key = {}
a[key] = 1
key = {}
a[key] = 2
collectgarbage()	--强制进行一次垃圾收集
for k, v in pairs(a) do print(v) end

-----------17.1-------------

local results = {}
setmetatable(results, {__mode = "kv"})	--value为弱用
function mem_loadstring(s)
	local res = results[s]
	if res == nil then	--是否已记录过
		res = assert(loadstring(s))	--计算新结果
		results[s] = res
	end
	return res
end

function createRGB(r, g, b)
	return {red = r, green = g, blue = b}
end

local results = {}
setmetatable(results, {__mode = "v"})	--使value为弱引用
function createRGB(r, g, b)
	local key = r .. "-" .. g .. "-" .. b
	local color = results[key]
	if color == nil then
		color = {red = r, green = g, blue = b}
		results[key] = color
	end
	return color
end

-----------17.2-------------


-----------17.3-------------

local defaults = {}
setmetatable(defaults, {__mode = "k"})
local mt = {__index = function(t)
	return defaults[t]
end}
function setDefault(t, d)
	defaults[t] = d
	setmetatable(t, mt)
end

local metas = {}
setmetatable(metas, {__mode = "v"})
function setDefault(t, d)
	local mt = metas[d]
	if mt == nil then
		mt = {__index = function()
			return d
		end}
		metas[d] = mt --备忘录
	end
	setmetatable(t, mt)
end