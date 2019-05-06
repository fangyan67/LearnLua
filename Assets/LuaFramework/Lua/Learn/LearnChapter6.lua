print("----------- Chapter6 Log -----------")

-----------6.0-------------

a = {p = print}
a.p("Hello World")
print = math.sin
a.p(print(1))
sin = a.p
sin(10, 20)
print = a.p

function foo(x)
	return 2*x
end
-->foo = function(x) return 2*x end

network = {
	{name = "grauna", IP = "210.26.30.34"},
	{name = "arraial", IP = "210.26.30.23"},
	{name = "lua", IP = "210.26.23.12"},
	{name = "derain", IP = "210.26.23.20"},
}
table.sort( network, function (a, b)
	return (a.name < b.name)
end )
----[[
for k, v in ipairs(network) do
	for k2, v2 in pairs(v) do
		print(k2 .. ":" .. v2)
	end
end
--]]

function derivative(f, delta)
	delta = delta or 1e-4
	return function(x)
		return (f(x + delta) - f(x) ) / delta
	end
end
c = derivative(math.sin)
print(math.cos(10), c(10) )

-----------6.1-------------

names = {"Peter", "Paul", "Mary"}
grades = {Mary = 10, Paul = 7, Peter = 8}
table.sort(names, function(n1, n2)
	return grades[n1] > grades[n2]
end)

function sortbygrade(names, grades)
	table.sort( names, function (n1, n2)
		return grades[n1] > grades[n2]
	end)
end

function newCounter()
	local i = 0
	return function()
	    i = i + 1
	    return i
	end
end

c1 = newCounter()
print(c1())
print(c1())
c2 = newCounter()
print(c2())
print(c1())
print(c2())
--[[
function digitButton(digit)
	return Button{
		label = tostring(diget),
		action = function()
		add_to_display(digit)
	end
	}
end
--]]

do
	local oldSin = math.sin
	local k = math.pi/180
	math.sin = function(x)
		return oldSin(x*k)
	end
end

-----------6.2-------------

Lib = {}
Lib.foo = function(x, y)
    return x + y
end
Lib.goo = function(x, y)
    return x - y
end

Lib = {
	foo = function(x, y)
	    return x + y
	end,
	goo = function(x, y)
	    return x - y
	end
}

Lib = {}
function Lib.foo(x, y)
    return x + y
end
function Lib.goo(x, y)
    return x - y
end

local f = function()
end

local function f()
end

local fact
fact = function(n)
	if n == 0 then
		return 1
	else
		return n * fact(n - 1)
	end		
end

local function fact(n)
	if n == 0 then
		return 1
	else
		return n * fact(n - 1)
	end
end

local f, g
function g()
	f()
end
function f()
	g()
end

-----------6.3-------------

function foo(n)
	if n > 0 then
		return foo(n - 1)
	end
end

--return x[i].foo(x[j] + a * b, i + j)

--[[
function room1()
	local move = io.read
	if move == "south" then return room3()
	elseif move == "east" then return room2()
	else
		print("invalid move")
		return room1()
	end
end

function room2()
	local move = io.read
	if move == "south" then return room4()
	elseif move == "west" then return room1()
	else
		print("invalid move")
		return room2()
	end 
end

function room3()
	local move = io.read
	if move == "north" then return room1()
	elseif move == "east" then return room4()
	else
		print("invalid move")
		return room3()
	end 
end

function room4()
	print("congratulations!")
end

room1()
--]]