print("----------- Chapter12 Log -----------")

-----------12.1-------------
--[[
local count = 0
function Entry (_) count = count + 1 end
dofile("data")

local authors = {}
function Entry(b)
	authors[b[1] ] = true
end
dofile("Learn/sth/data")
for name in pairs(authors) do print(name) end

-----------12.2-------------

function serialize(o)
	if type(o) == "number" then
		io.write(o)
	else if type(o) == "string" then
		io.write(string.format("%q", o) )
		--else
	end
end

function quote(s)
	--查找最长的等号序列
	local n = -1
	for w in string.gmatch(s, "]=*") do
		n = math.max(n, #w - 1)
	end
	--产生‘n'+1个等号
	local eq = string.rep("=", n + 1)
	--生成长字符串的字面表示
	return string.format(" [%s[\n%s]%s] ", eq, s, eq)
end

-----------12.2.1-------------

function serialize(o)
	if type(o) == "number" then
		io.write(o)
	elseif type(o) == "string" then
		io.write(string.format("%q", o))
	elseif type(o) == "table" then
		io.write("{\n")
		for k, v in pairs(o) do
			io.write(" ", k, " = ")
			serialize(v)
			io.write(",\n")
		end
		io.write("}\n")
	else
		error("cannot serialize a " .. type(o))
	end
end

-----------12.2.2-------------

function basicSerialize(o)
	if type(o) == "number" then
		return tostring(o)
	else 	-- assume it is a string
		return string.format("%q", o)
	end
end

function save(name, value, saved)
	saved = saved or {}	--初始值
	io.write(name, " = ")
	if type(value) == "number" or type(value) == "string" then
		io.write(basicSerialize(value), "\n")
	elseif type(value) == "table" then
		if saved[value] then	--该value是否已保存过？
			io.write(saved[value], "\n")	--使用先前的名字
		else
			saved[value] = name	--为下次使用保持名字
			io.write("{}\n")	--创建一个新的table
			for k, v in pairs(value) do --保存其字段
				k = basicSerialize(k)
				local fname = string.format("%s[%s]", name, k)
				save(fname, v, saved)
			end
		end
	else
		error("cannot save a " .. type(value))
	end
end

a = {x=1, y=2; {3,4,5}}
a[2] = a 	--环
a.z = a[1]	--共享子table

a = {}
a[1] = {}
a[1][1] = 3
a[1][2] = 4
a[1][3] = 5
a[2] = a
a["y"] = 2
a["x"] = 1
a["z"] = a[1]

a = {{"one", "two"}, 3}
b = {k = a[1]}
save("a", a)
save("b", b)

local t = {}
save("a", a, t)
save("b", b, t)
--]]