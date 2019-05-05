print("----------- Chapter5 Log -----------")

-----------5.0-------------

print(8*9, 9/8)
a = math.sin(3) + math.cos(10)
print(os.date())

print "Hello World"	--	("")
--dofile 'a.lua'
print [[a multi-line
message]]
--f{x=10,y=20}
type{}

--o:foo(x)

function add(a)
	local sum = 0
	for i, v in ipairs(a) do
		sum = sum + v
	end
	return sum
end

function incCount(n)
	n = n or 1
	count = count + n
end

-----------5.1-------------

s, e = string.find("hello Lua users", "Lua")
print(s, e)

function maximum(a)
	local mi = 1	--index
	local m = a[mi]	--value
	for i, val in ipairs(a) do
		if val > m then
			mi = i; m = val
		end
	end
	return m, mi
end
print(tostring(maximum({3,5,8}) ) )

function foo0()
end

function foo1()
	return "a"
end

function foo2()
	return "a", "b"
end

x, y = foo2()
print(x .. "," .. y)
x = foo2()
print(x .. "," .. y)
x, y, z = 10, foo2()
print(x .. "," .. y .. "," ..z)

x, y = foo0()
print(tostring(x) .. "," .. tostring(y) )
x, y = foo1()
print(tostring(x) .. "," .. tostring(y))
x, y, z = foo2()
print(tostring(x) .. "," .. tostring(y) .. "," ..tostring(z))

x, y = foo2(), 20
print(tostring(x) .. "," .. tostring(y) )
x, y = foo0(), 20, 30
print(tostring(x) .. "," .. tostring(y) )

print(foo0())
print(foo1())
print(foo2())
print(foo2(), 1)
print(foo2() .. "x")

t = {foo0()}
t = {foo1()}
t = {foo2()}

t = {foo0(), foo2(), 4}
print(t[2])

function foo(i)
	if i == 0 then return foo0()
	elseif i == 1 then return foo1()
	elseif i == 2 then return foo2()
	end 
end
print(foo(1))
print(foo(2))
print(foo(0))
print(foo(3))

print((foo0()))
print((foo1()))
print((foo2()))

print(unpack{10, 20, 30})
a, b = unpack{10, 20, 30}
print(unpack(t))

f = string.find
a = {"hello", "ll"}
print(f(unpack(a)))

function unpack(t, i)
	i = i or 1
	print("unpack func:" .. tostring(t[i]))
	if t[i] then
		return t[i], unpack(t, i + 1)
	end
end
print(unpack({1,2,3,4}, 1))

-----------5.2-------------

function add(...)
	local s = 0
	for i, v in ipairs{...} do
		s = s + v
	end
	return s
end
print(add(3, 4, 10, 25, 12))

function foo( ... )
	local a, b, c = ...
end

function id( ... )
	return ...
end

--[[
function  fwrite(fmt,  ... )
	return io.write(string.format(fmt, ...) )
end
fwrite()
fwrite("a")
fwrite("%d%d", 4, 5)
--]]

function OnSel( ... )
	for i = 1, select('#', ...) do
		local arg = select(i, ...)
		print(tostring(arg) )
	end
end
OnSel(3, 5, 8)

function foo(a, b, ... )
	local arg = {...}
	arg.n = select("#", ...)
end

-----------5.3-------------

--rename{old="temp.lua", new="temp1.lua"}
function rename(arg)
	return os.rename(arg.old, arg.new)
end


function Window( options )
	if type(options.title) ~= "string" then
		error("no title")
	elseif type(options.width) ~= "number" then
		error("no width")
	elseif type(options.height) ~= "number" then
		error("no height")
	end
--[[
	_Window(options.title,
		options.x or 0,
		options.y or 0,
		options.width, options.height,
		options.background or "white",
		options.border)
--]]
end


w = Window{x=0, y=0, width=300, height=200,
title="Lua", background="blue", border = true}