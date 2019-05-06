print("----------- Chapter7 Log -----------")

-----------7.1-------------

function values(t)
	local i = 0
	return function()
		i = i + 1
		return t[i]
	end
end

t = {10, 20, 30}
iter = values(t)
while true do
	local element = iter()
	if element == nil then break end
	print(element)
end

t = {10, 20, 30}
for element in values(t) do
	print(element)
end

--[[
function allwords()
	local line = io.read()
	local pos = 1
	return function()
		while line do
			local s, e = string.find(line, "%w+", pos)
			if s then
				pos = e + 1
				return string.sub(line, s, e)
			else
				line = io.read()
				pos = 1
			end
		end
		return nil
	end
end

for word in allwords() do
	print(word)
end
--]]

-----------7.2-------------
--[[
for <var-list> in <exp-list> do
	<body>
end
--]]

--for k, v in pairs(t) do print(k, v) end

-----------7.3-------------


local function iter(a, i)
	i = i + 1
	local v = a[i]
	if v then
		return i, v
	end
end

function ipairs(a)
	return iter, a , 0
end

a = {"one", "two", "three"}
for i, v in ipairs(a) do
	print(i, v)
end

function pairs(t)
	return next, t, nil
end

t = {1, 2, 3}
for k, v in next, t do
	print(v)
end

local function getnext(list, node)
	if not node then
		return list
	else
		return node.next
	end
end

function traverse(list)
	return getnext, list, nil
end

list = {val = 1, next = {val = 2, next = nil}}

for node in traverse(list) do
	print(node.val)
end

-----------7.4-------------

--[[
local iterator

function allwords()
	local state = {line = io.read(), pos = 1}
	return iterator, state
end

function iterator(state)
	while state.line do
		local s, e = string.find(state.line, "%w+", state.pos)
		if s then
			state.pos = e + 1
			return string sub(state.line, s, e)
		else
			state.line = io.read()
			state.pos = 1
		end
	end
	return nil
end
--]]

-----------7.5-------------
lines = {
	"fewfewfw",
	"fewfeweeeww",
	"hello12321",
	"fewfewfewfwwqaaaa",
	"hello",
}
function allwords(f)
	for k, v in ipairs(lines) do	--for line in io.lines() do
		local line = v
		for word in string.gmatch(line, "%w+") do
			f(word)
		end
	end
end
allwords(print)

local count = 0
allwords(function(w)
	if w == "hello" then count = count + 1 end
end)
print(count)
--[[
local count = 0
for w in allwords() do
	if w == "hello" then count = count + 1 end
end
print(count)
--]]
