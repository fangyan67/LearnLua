print("----------- Chapter11 Log -----------")

-----------11.1-------------

a = {}
for i = 1, 1000 do
	a[i] = 0
end

print(#a)

a = {}
for i = -5, 5 do
	a[i] = 0
end
squares = {1, 4, 9, 16, 25, 36, 49, 64, 81}

-----------11.2-------------
--[[
mt = {}
for i = 1, N do
	mt[i] = {}
	for j = 1, M do
		mt[i][j] = 0
	end
end

mt = {}
for i = 1, N do
	for j = 1, M do
		mt[(i-1)*M + j] = 0
	end
end

function mult(a, rowindex, k)
	local row = a[rowindex]
	for i, v in pairs(row) do
		row[i] = v * k
	end
end
--]]

-----------11.3-------------

--[[
list = nil
list = {next = list, value = v}

local l = list
while l do
	l = l.next
end
--]]

-----------11.4-------------
--[[
function ListNew()
	return {first = 0, last = -1}
end
--]]

List = {}
function List.new()
	return {first = 0, last = -1}
end

function List.pushfirst(list, value)
	local first = list.first - 1
	list.first = first
	list[first] = value
end

function List.pushlast(list, value)
	local last = list.last + 1
	list.last = last
	list[last] = value
end

function List.popfirst(list)
	local first = list.first
	if first > list.last then error("list is empty") end
	local value = list[first]
	list[first] = nil	--for gc
	list.first = first + 1
	return value
end

function List.poplast(list)
	local last = list.last
	if list.first > last then error("list is empty") end
	local value = list[last]
	list[last] = nil
	list.last = last - 1
	return value
end

reserved = {
	["while"] = true,
	["end"] = true,
	["function"] = true,
	["local"] = true
}
--[[
for w in allwords() do
	if not reserved[w] then
		print(tostring(w) .. " is not include")
	end
end
]]--

function Set(list)
	local set = {}
	for _, l in ipairs(list) do set[l] = true end
	return set
end

reserved = Set{"while", "end", "function", "local",}
--Multiset

function inset(bag, element)
	bag[element] = (bag[element] or 0) + 1
end

function remove(bag, element)
	local count = bag[element]
	bag[element] = (count and count > 1) and count - 1 or nil
end

-----------11.6-------------

--[[
local buff = ""
for line in io.lines() do
	buff = buff .. line .. "\n"
end

local t = {}
for line in io.lines() do
	t[#t + 1] = line .. "\n"
end
--local s = table.concat(t) -->
--s = table.concat(t, "\n") .. "\n" -->
t[#t + 1] = ""
s = table.concat(t, "\n")

function addString(stack, s)
	stack[#stack + 1] = s
	for i = #stack - 1, 1, -1 do
		if #stack[i] > #stack[i+1] then
			break
		end
		stack[i] = stack[i] .. stack[i + 1]
		stack[i + 1] = nil
	end
end

-----------11.7-------------

local function name2node(graph, name)
	if not graph[name] then
		graph[name] = {name = name, adj = {}}
	end
	return graph[name]
end

function readgraph()
	local graph = {}
	for line in io.lines() do
		-- 切分行中2个名称
		local namefrom, nameto = string.match(line, "(%S+)%s+(%S+)")
		-- 查找相应的节点
		local from = name2node(graph, namefrom)
		local to = name2node(graph, nameto)
		-- 将'to'添加到'from'的邻接集合
		from.adj[to] = true
	end
	return graph
end

function findpath(curr, to, path, visited)
	path = path or {}
	visited = visited or {}
	if visited[curr] then	--节点是否已访问过
		return nil			--这里没有路径
	end
	visited[curr] = true	--将结点标记为访问过
	path[#path + 1] = curr	--将其加到路径中
	if curr == to then		--最后的节点吗？
		return path
	end
	--尝试所有的邻接节点
	for node in pairs(curr.adj) do
		local p = findpath(node, to, path, visited)
		if p then return p end
	end
	path[#path] = nil	--从路径中删除节点
end

function printpath(path)
	for i = 1, #path do
		print(path[i].name)
	end
end

g = readgraph()
a = name2node(g, "a")
b = name2node(g, "b")
p = findpath(a, b)
if p then printpath(p) end
--]]
