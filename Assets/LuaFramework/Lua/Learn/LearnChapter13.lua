print("----------- Chapter13 Log -----------")

t = {}
print(getmetatable(t))

t1 = {}
setmetatable(t, t1)
print(getmetatable(t))
print(getmetatable(t) == t1)

print(getmetatable("hi"))
print(getmetatable(10))

-----------13.1-------------

Set = {}

local mt = {}	--集合的原表

--根据参数列表中的值创建一个新的集合
function Set.new(l)
	local set = {}
	setmetatable(set, mt)
	for _, v in ipairs(l) do set[v] = true end
	return set
end

function Set.union(a, b)
	if getmetatable(a) ~= mt or getmetatable(b) ~= mt then
		error("attempt to 'add' a set with a non-set value", 2)
		return nil
	end
	local res = Set.new{}
	for k in pairs(a) do res[k] = true end
	for k in pairs(b) do res[k] = true end
	return res
end

function Set.intersection(a, b)
	local res = Set.new{}
	for k in pairs(a) do
		res[k] = b[k]
	end
	return res
end

function Set.tostring(set)
	local l = {}	--用于存放集合中所有元素的列表
	for e in pairs(set) do
		l[#l + 1] = e
	end
	return "{" .. table.concat(l, ", ") .. "}"
end

function Set.print(s)
	print(Set.tostring(s))
end

s1 = Set.new{10, 20, 30, 50}
s2 = Set.new{30, 1}
print(getmetatable(s1))
print(getmetatable(s2))

mt.__add = Set.union

s3 = s1 + s2
Set.print(s3)

-- __add(加法) _mul（乘法） __sub（减法） __div（除法）
-- __unm(相反数) __mod(取模) __pow(乘幂) __concat（相连）

s = Set.new{1,2,3}
--s = s + 8

-----------13.2-------------

-- __eq(等于) __lt(小于) __le(小于等于)
--a ~= b -> not(a == b)
--a > b -> b < a
-- a >= b -> b <= a

mt.__le = function(a, b)	--集合包含
	for k in pairs(a) do
		if not b[k] then return false end
	end
	return true
end

mt.__lt = function(a, b)
	return a <= b and not(b <= a)
end

mt.__eq = function(a, b)
	return a <= b and b <= a
end

mt.__mul = function(a, b)
	return Set.new{}
end

s1 = Set.new{2,4}
s2 = Set.new{4,10,2}
print(s1 <= s2)
print(s1 < s2)
print(s1 >= s1)
print(s1 > s1)
print(s1 == s2 * s1)

-----------13.3-------------

print({})

mt.__tostring = Set.tostring

s1 = Set.new{10, 4, 5}
print(tostring(s1) )

mt.__metatable = "not your business"

s1 = Set.new{}
print(getmetatable(s1))
--setmetatable(s1, {})

-----------13.4.1-------------

Window = {}	--创建一个名字空间
--使用默认值来创建一个原型
Window.prototype = {x=0, y=0, width=100, height=100}
Window.mt = {}	--创建元表
--声明构造函数
function Window.new(o)
	setmetatable(o, Window.mt)
	return o
end

--[[
Window.mt.__index = function(table, key)
	return Window.prototype[key]
end
--]]
Window.mt.__index = Window.prototype

w = Window.new{x=10, y=20}
print(w.width)

--rawget 只访问table，不访问元表

-----------13.4.2-------------

-- __index 查询
-- __newindex 不存在的值赋值时使用

-----------13.4.3-------------

function setDefault(t, d)
	local mt = {__index = function()
		return d;
	end}
	setmetatable(t, mt);
end

tab = {x = 10, y = 20}
print(tab.x, tab.z)
setDefault(tab, 0)
print(tab.x, tab.z)

local mt = {__index = function(t)
	return t.___
end}
function setDefault(t, d)
	t.___ = d
	setmetatable(t, mt)
end

local key = {}	--唯一的key
local mt = {__index = function(t)
	return t[key]
end}
function setDefault(t, d)
	t[key] = d
	setmetatable(t, mt)
end

-----------13.4.4-------------

t = {}	--原来的table（在其他地方创建的
--保持对原table的一个私有访问
local _t = t
--创建代理
t = {}
--创建元表
local mt = {
	__index = function(t, k)
		print("*access to element " .. tostring(k) )
		return _t[k]	--访问原来的table
	end,
	__newindex = function(t, k, v)
		print("*update of element " .. tostring(k) .. " to " .. tostring(v) )
		_t[k] = v 	--更新原来的table
	end
}
setmetatable(t, mt)

t[2] = "hello"
print(t[2])


local index = {}	--创建私有索引
local mt = {	--创建元表
	__index = function(t, k)
		print("*access to element " .. tostring(k) )
		return t[index][k]	--访问原来的table
	end,
	__newindex = function(t, k, v)
		print("*update of element " .. tostring(k) .. " to " .. tostring(v) )
		t[index][k] = v 	--更新原来的table
	end
}

function track(t)
	local proxy = {}
	proxy[index] = t
	setmetatable(proxy, mt)
	return proxy
end

t[5] = "32132"
t = track(t)

-----------13.4.5-------------

function readOnly(t)
	local proxy = {}
	local mt = {	--创建元表
		__index = t,
		__newindex = function(t, k, v)
			error("attempt to update a read-only table", 2)
		end
	}
	setmetatable(proxy, mt)
	return proxy
end

days = readOnly{"Sunday", "Monday", "Tuesday", "Wednesday",
"Thursday", "Friday", "Saturday"}
print(days[1])	--Sunday
days[2] = "Noday"
