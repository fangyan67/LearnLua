print("----------- Chapter19 Log -----------")

-----------19.1-------------

lines = {"111", "222", "333"}
t = {}
for k, v in pairs(lines) do	--line in io.lines()
	table.insert(t, v)
end
print(#t)

-----------19.2-------------

lines = {
	luaH_set = 10,
	luaH_get = 24,
	luaH_present = 48,
}

a = {}
for n in pairs(lines) do a[#a+1] = n end
table.sort(a)
for k, v in ipairs(a) do 
	print(tostring(v) ) 
end

function pairsByKeys(t, f)
	local a = {}
	for n in pairs(t) do a[#a+1] = n end
	table.sort(a, f)
	local i = 0	--迭代器变量
	return function()	--迭代器函数
		i = i + 1
		return a[i], t[a[i] ]
	end
end

for name, line in pairsByKeys(lines) do
	print(name, line)
end

-----------19.3-------------

function rconcat(l)
	if type(1) ~= "table" then return l end
	local res = {}
	for i = 1, #l do
		res[i] = rconcat(l[i])
	end
	return table.concat(res)
end

print(rconcat{{"a", {"nice"}}}, " and", {{"long"},{" list"}})