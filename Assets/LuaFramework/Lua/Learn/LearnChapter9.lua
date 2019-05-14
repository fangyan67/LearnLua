--require "socket"

print("----------- Chapter9 Log -----------")

-----------9.1-------------
co = coroutine.create(function()
	print("hi")
end)

print(co)	--挂起suspended 运行running 死亡dead 正常normal
print(coroutine.status(co))

coroutine.resume(co)
print(coroutine.status(co))

co = coroutine.create(function()
	for i = 1, 10 do
		print("co", i)
		coroutine.yield()
	end
end)
coroutine.resume(co)
print(coroutine.status(co))
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
coroutine.resume(co)
print(coroutine.resume(co))
local s = coroutine.resume(co)
print(s)
print(coroutine.status(co))

co = coroutine.create(function(a, b, c)
	print("co", a, b, c)
end)
coroutine.resume(co, 1, 2, 3)

co = coroutine.create(function(a, b)
	coroutine.yield(a + b, a - b)
end)
print(coroutine.resume(co, 20, 10))

co = coroutine.create(function()
	print("co2", coroutine.yield())
end)
coroutine.resume(co)
coroutine.resume(co, 4, 5)

co = coroutine.create(function()
	return 6, 7
end)
print(coroutine.resume(co))

-----------9.2-------------
--[[
function producer()
	while true do
		local x = io.read()
		send(x)
	end
end

function consumer()
	while true do
		local x = receive()
		io.write(x, "\n")
	end
end

function receive()
	local status, value = coroutine.resume(producer)
	return value
end

function send(x)
	coroutine.yield(x)
end

producer = coroutine.create(
	function()
		while true do
			local x = io.read()
			send(x)
		end
	end
end)
--]]

--[[
function receive(prod)
	local status, value = coroutine.resume(prod)
	return value
end

function send(x)
	coroutine.yield(x)
end

function producer()
	return coroutine.create(function()
		while true do
			local x = io.read()
			send(x)
		end
	end)
end

function filter(prod)
	return coroutine.create(function()
		for line = 1, math.huge do
			local x = receive(prod)
			x = string.format("%5d %s", line, x)
			send(x)
		end
	end)
end

function consumer(prod)
	while true do
		local x = receive(prod)
		io.write(x, "\n")
	end
end

p = producer()
f = filter(p)
consumer(f)

consumer(filter(producer()))
--]]

-----------9.3-------------

--[[
function permgen(a, n)
	n = n or #a
	if n <= 1 then
		printResult(a)
	else
		for i = 1, n do
			--将第i个元素放数组末尾
			a[n], a[i] = a[i], a[n]
			--生成其余元素的排列
			permgen(a, n - 1)
			--恢复第i个元素
			a[n], a[i] = a[i], a[n]
		end
	end
end
--]]

function printResult(a)
	local s = ""
	for i = 1, #a do
		s = s .. a[i] .. ","
	end
	print(s)
end

--permgen({1, 2, 3, 4})

function permgen(a, n)
	n = n or #a
	if n <= 1 then
		coroutine.yield(a)
	else	--as before
		for i = 1, n do
			--将第i个元素放数组末尾
			a[n], a[i] = a[i], a[n]
			--生成其余元素的排列
			permgen(a, n - 1)
			--恢复第i个元素
			a[n], a[i] = a[i], a[n]
		end
	end
end
--[[
function permutations(a)
	local co = coroutine.create(function()
		permgen(a)
	end)
	return function()	--迭代器
		local code, res = coroutine.resume(co)
		return res
	end
end
--]]

function permutations(a)
	return coroutine.wrap(function ()
		permgen(a)
	end)
end

for p in permutations({"a", "b", "c"}) do
	printResult(p)
end

-----------9.4-------------

--socket sample miss