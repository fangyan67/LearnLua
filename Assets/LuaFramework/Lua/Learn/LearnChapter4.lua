print("----------- Chapter4 Log -----------")

-----------4.1-------------
--a, b = 10, 2*x

x, y = 10, 2
x, y = y, x
print(x .. "," .. y)

--a[i], a[j] = a[j], a[i]

a, b, c = 0, 1
print(a, b, c)
a, b = a+1, b+1, b+2	--b+2 ignore
print(a, b)
a, b, c = 0
print(a, b, c)
a, b, c = 0, 0, 0
print(a, b, c)

-----------4.2-------------
j = 10
local i = 1

x = 10
local i = 1
while i <= x do
	local x = i *2
	print(x)
	i = i + 1
end

if i > 20 then
	local x
	x = 20
	print(x + 2)
else
	print(x)
end
print(x)

do
	local a2 = 2*a
	local d = (b^2 - 4*a*c)^(1/2)
	x1 = (-b + d)/a2
	x2 = (-b - d)/a2
end
print(x1, x2)

local a, b = 1, 10
if a < b then
	print(a)
	local a
	print(a)
end
print(a, b)

local foo = foo	--this.foo = foo

-----------4.3-------------
if a < 0 then a = 0 end
--if a < b then return a else return b end
--if line > MAXLINES then
	--showpage()
	line = 0
--end

if op == "+" then
	r = a + b
elseif op == "-" then
	r = a - b
elseif op == "*" then
	r = a * b
elseif op == "/" then
	r = a / b
else
	--error("invalid operation")
end

local a = {1, 2, 3}
local i = 1
while a[i] do
	print(a[i])
	i = i + 1
end

local n = 1
repeat
	n = n + 1
	print(n)
until n > 3
print(n)

local x = 6
local sqr = x / 2
repeat
	sqr = (sqr + x / sqr) / 2
	local error = math.abs(sqr ^ 2 - x)
	print(error)
until error < x / 10000
print(error)

--for i = 1, f(x) do print(i) end
for i = 10, 1, -1 do print(i) end

for i = 1, math.huge do
	if(0.3 * i ^ 3 - 20 * i ^ 2 - 500 >= 0) then
		print(i)
		break
	end
end

--for i, v in ipairs(a) do print(v) end
--for k in pairs(t) do print(k) end

days = {"Sunday", "Monday", "Tuesday", "Wednesday",
		"Thursday", "Friday", "Saturday"}
revDays = {["Sunday"] = 1, ["Monday"] = 2,
			["Tuesday"] = 3, ["Wednesday"] = 4,
			["Thursday"] = 5, ["Friday"] = 6,
			["Saturday"] = 7}
x = "Tuesday"
print(revDays[x])

revDays = {}
for k, v in pairs(days) do
	revDays[v] = k
end
print(revDays[x])

-----------4.4-------------
local i = 1
while a[i] do
	if a[i] == v then break end
	i = i + 1
end

function foo()
	--return
	do
		--test code
		return
	end
	--logic code
end