print("----------- Chapter14 Log -----------")

-- _G 全局环境table
for n in pairs(_G) do print(n) end

-----------14.1-------------

--value = loadstring("return " .. varname)()
-->

--value = _G[varname]
--_G[varname] = value

function getfield(f)
	local v = _G	--从全局变量的table开始
	for w in string.gmatch(f, "[%w_]+") do
		v = v[w]
	end
	return v
end

function setfield(f, v)
	local t = _G	--从全局变量的table开始
	for w, d in string.gmatch(f, "([%w_]+)(%.?)") do
		if d == "." then		--是最后一个字段吗？
			t[w] = t[w] or {}	--如果不存在就创建table
			t = t[w]			--获取该table
		else					--最后的字段
			t[w] = v 			--完成赋值
		end
	end
end

setfield("t.x.y", 10)
print(t.x.y)
print(getfield("t.x.y") )

-----------14.2-------------
--[[
setmetatable(_G, {
	__newindex = function(_, n)
		local w = debug.getinfo(2, "S").what
		if w ~= "main" and w ~= "C" then
			error("attempt to write to undeclared variable " .. n, 2)
		end
		rawset(t, n, v)
	end,
	__index = function(_, n)
		error("attempt to read undeclared variable ".. n, 2)
	end,
})

print(a)

function declare(name, initval)
	rawset(_G, name, initval or false)
end

--a = 1
--]]
local declaredNames = {}

setmetatable(_G, {
	__newindex = function(t, n, v)
		if not declaredNames[n] then
			local w = debug.getinfo(2, "S").what
			if w ~= "main" and w ~= "C" then
				error("attempt to write to undeclared variable "..n, 2)
			end
			declaredNames[n] = true
		end
		rawset(t, n, v);	--完成实际的设置
	end,
	__index = function(_, n)
		if not declaredNames[n] then
			error("attempt to read undeclared variable "..n, 2);
		else
			return nil
		end
	end
})

xggee = 1
print(xggee)

-----------14.3-------------

--TODO
--[[
a = 1
setfenv(1, {g = _G})
g.print(a)
g.print(g.a)

setfenv(1, {_G = _G})
_G.print(a)
_G.print(_G.a)

a = 1
--]]