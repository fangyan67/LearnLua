print("----------- Chapter8 Log -----------")

-----------8.1-------------
function dofile(filename)
	local f = assert(loadfile(filename))	--can return error code
	return f()
end

f = loadstring("i = i + 1")	--load script from string
i = 0;
f();print(i)
f();print(i)

s = "print(3)"
loadstring(s)()
assert(loadstring(s))()

i = 32
local i = 0
f = loadstring("i = i + 1; print(i)")
g = function()
	i = i + 1
	print(i)
end
f()
g()


print "enter your expression:"
local l = "1 + 2"	--io.read()
local func = assert(loadstring("return " .. l))
print("the value of your expression is " .. func())

print "enter function to be plotted(with variable 'x'):"
local l = "x + 1"
local f = assert(loadstring("return " .. l))
for i = 1, 20 do
	x = i	--global x
	print(string.rep("*", f()))
end

f = loadstring("local a = 10; print(a + 20)")
f()

print "enter function to be plotted(with variable 'x'):"
local l = "x + 1"
local f = assert(loadstring("local x = ...; return " .. l))
for i = 1, 20 do
	print(string.rep("*", f(i)))
end

print(loadstring("i i"))

-----------8.2-------------

--local path = "/usr/local/lib/lua/5.1/socket.so"
--local f = package.loadfile(path, "luaopen_socket")

--require

-----------8.3-------------
--io.read("*number")
--if not n then error("invalid input") end
--n = assert(n, "invalid input " .. tostring(n) )

-----------8.4-------------
function foo()
	--...
end

if pcall(foo) then
	--ok
else
	--has error
end

local status, err = pcall(function ()
	error({code = 121})
end)
print(err.code)

-----------8.5-------------
--error("string expected", 2)
--xpcall
--debug.debug
print(debug.traceback())

