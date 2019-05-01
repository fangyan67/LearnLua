print("----------- Chapter2 Log -----------")

print(type("Hello world"))
print(type(10.4*3))
print(type(print))
print(type(type))
print(type(true))
print(type(nil))
print(type(type(X)))

print(type(a))
a = 10
print(type(a))
a = "a string!!"
print(type(a))
a = print
print(type(a))

----2.4 string----

a = "one string"
b = string.gsub(a, "one", "another")
print(a)
print(b)

a = "a line"
b = 'another line'

print("one line\nnext line\n\"in quotes\", 'in quotes'")

print('a backslash inside quotes: \'\\\'')

print("a simpler way: '\\'")

page = [[
<html>
<head>
<title>An HTML Page</title>
</head>
<body>
<a href="http://www.lua.org">Lua</a>
</body>
</html>
]]

print(page)

print("10" + 1)
print("10 + 1")
print("-5.3e-10" * "2")
--print("hello" + 1)

print(10 .. 20)

n = tonumber(666)
if n == nil then
	error("is not a valid number")
else
	print(n*2)
end

print(tostring(10) == "10")
print(10 .. "" == "10")

a = "hello"
print(#a)
print(#"good\0bye")

----2.5 table----

a = {}
k = "x"
a[k] = 10
a[20] = "great"
print(a["x"])
k = 20
print(a[k])
a["x"] = a["x"] + 1
print(a["x"])

a = {}
a["x"] = 10
b = a
print(b["x"])
b["x"] = 20
print(a["x"])
a = nil
b = nil

a = {}
for i = 1, 1000 do a[i] = i * 2 end
print(a[9])
a["x"] = 10
print(a["x"])
print(a["y"])

a.x = 10
print(a.x)
print(a.y)

a = {}
x = "y"
a[x] = 10
print(a[x])
print(a.x)
print(a.y)

a = {}
for i = 1, 10 do
	a[i] = i
end
print(#a)
for i = 1, #a do
	print(a[i])
end

v = 11
print(a[#a])
a[#a] = nil
print(a[#a])
a[#a + 1] = v
print(#a)
print(a[#a])

a = {}
a[10000] = 1
print(#a)
print(table.maxn(a))

i = 10; j = "10"; k = "+10"
a = {}
a[i] = "one value"
a[j] = "another value"
a[k] = "yet another value"
print(a[j])
print(a[k])
print(a[tonumber(j)])
print(a[tonumber(k)])