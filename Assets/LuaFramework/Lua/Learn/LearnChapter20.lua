print("----------- Chapter20 Log -----------")

--string.upper(s)
--s:upper()

-----------20.1-------------

--table.sort(a, function(a, b)
--	return string.lower(a) < string.lower(b)
--end)

--string.sub(s, 1, j)	-1

s = "[in brackets]"
print(string.sub(s, 2, -2) )

print(string.char(97))
i = 99; print(string.char(i, i+1, i+2))
print(string.byte("abc"))
print(string.byte("abc"), 2)
print(string.byte("abc"), -1)

print(string.byte("abc"), 1, 2)

--{s:byte(1, -1)}
--string.char(unpack(t))

--string.format()	--d x o f s

print(string.format("pi = %.4f", math.pi))
d = 5; m = 11; y = 1990
print(string.format("%02d/%02d/%04d", d, m, y))
tag, title = "hl", "a title"
print(string.format("<%s>%s</%s", tag, title, tag))

-----------20.2-------------

-----------20.2.1-------------

s = "hello world"
i, j = string.find(s, "hello")
print(i, j)
print(string.sub(s, i, j))
print(string.find(s, "world"))
i, j = string.find(s, "l")
print(i, j)
print(string.find(s, "111"))

local t = {}
local i = 0
while true do
	i = string.find(s, "\n", i+1)
	if i == nil then break end
	t[#t+1] = i
end

-----------20.2.2-------------

print(string.match("hello world", "hello"))

date = "Today is 17/7/1990"
d = string.match(date, "%d+/%d+/%d+")
print(d)

-----------20.2.3-------------

s = string.gsub("Lua is cute", "cute", "great")
print(s)
s = string.gsub("all lii", "l", "x")
print(s)
s = string.gsub("Lua is great", "Sol", "Sun")
print(s)

s = string.gsub("all lii", "l", "x", 1)
print(s)
s = string.gsub("all lii", "l", "x", 2)
print(s)

str = "fewfw  fewfew fewfw ";
count = select(2, string.gsub(str, " ", " "))
print(count)

-----------20.2.4-------------

words = {}
for w in string.gmatch(s, "%a+") do
	words[#words + 1] = w
end
print(words[1])

function search(modname, path)
	modname = string.gsub(modname, "%.", "/")
	for c in string.gmatch(path, "[^;]+") do
		local fname = string.gsub(c, "?", modename)
		local f = io.open(fname)
		if f then
			f:close()
			return fname
		end
	end
	return nil
end

-----------20.3-------------

s = "Deadline is 30/05/1999, firm"
date = "%d%d/%d%d/%d%d%d%d"
print(string.sub(s, string.find(s, date)))

print(string.gsub("hello, up-down!", "%A", "."))

--nvow = select(2, string.gsub(text), "[AEIOUaeiou]", ""))

--%S == [^%s]

print(string.gsub("one, and two; and three", "%a+", "word"))

print(string.match("the number 1298 is even", "%d+"))

--%(%s*%)
--[_%a][_%w]* [_%a][_%w]-
--/%*.*%*/

test = "int x; /* x */  int y; /* y */"
print(string.gsub(test, "/%*.*%*/", "<COMMENT>"))

test = "int x; /* x */  int y; /* y */"
print(string.gsub(test, "/%*.-%*/", "<COMMENT>"))

--[+-]?%d+

--if string.find(s, "^%d") then ...
--if string.find(s, "^[+-]?%d+$") then ...
--%b<x><y>

s = "a (enclosed (in) parentheses) line"
print(string.gsub(s, "%b()", ""))

-----------20.4-------------

pair = "name = Anna"
key, value = string.match(pair, "(%a+)%s*=%s*(%a+)")
print(key, value)

date = "Today is 17/7/1990"
d, m, y = string.match(date, "(%d+)/(%d+)/(%d+)")
print(d, m, y)

s = [[then he said: "it's all right"!]]
q, quotedPart = string.match(s, "([\"'])(.-)%1")
print(quotedPart)
print(q)

p = "%[(=*)%[(.-)%]%1%]"
s = "a = [=[[[ something ]] ]==] ]=]; print(a)"
print(string.match(s, p))

print(string.gsub("hello Lua!", "%a", "%0-%0"))
print(string.gsub("hello Lua", "(.)(.)", "%2%1"))

--...

function trim(s)
	return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

-----------20.5-------------

function expand(s)
	return (string.gsub(s, "$(%w+)", _G))
end

name = "Lua"; status = "great"
print(expand("$name is $status, isn't it?"))
print(expand("$othername is $status, isn't it?"))

function expand(s)
	return (string.gsub(s, "$(%w+)", function(n)
		return tostring(_G[n])
	end))
end

print(expand("print = $print; a = $a"))

function toxml(s)
	s = string.gsub(s, "\\(%a+)(%b{})", function(tag, body)
		body = string.sub(body, 2, -2)
		body = toxml(body)
		return string.format("<%s>%s</%s>", tag, body, tag)
	end)
	return s
end

print(toxml("\\title{The \\bold{big} example}"))

-----------20.5.1-------------

--name = "al"; query = "a+b=c"; q = "yes or no"
--"name=al&query=a%2Bb+%3D+c&q=yes+or+no"

function unescape(s)
	s = string.gsub(s, "+", " ")
	s = string.gsub(s, "%%(%x%x)", function(h)
		return string.char(tonumber(h, 16))
	end)
	return s
end

print(unescape("a%2Bb+%3D+c"))

cgi = {}
function decode(s)
	for name, value in string.gmatch(s, "([^&=]+)=([^&=]+)") do
		name = unescape(name)
		value = unescape(value)
		cgi[name] = value
	end
end

function  escape(s)
	s = string.gsub(s, "[&=+%%%c]", function(c)
		return string.format("%%%02X", string.byte(c))
	end)
	s = string.gsub(s, " ", "+")
	return s
end

function encode(t)
	local b = {}
	for k, v in pairs(t) do
		b[#b + 1] = (escape(k) .. "=" .. escape(v))
	end
	return table.concat(b, "&")
end

t = {name = "a1", query = "a+b = c", q = "yes or no"}
print(encode(t))

-----------20.5.2-------------

print(string.match("hello", "()ll()"))

function expandTabs(s, tab)
	tab = tab or 8
	local corr = 0
	s = string.gsub(s, "()\t", function(p)
		local sp = tab - (p - 1 + corr) % table
		corr = corr - 1 + sp
		return string.rep(" ", sp)
	end)
	return s
end

function unexpandTabs(s, tab)
	tab = tab or 8
	s = expandTabs(s)
	local pat = string.rep(".", tab)
	s = string.gsub(s, pat, "%0\1")
	s = string.gsub(s, " +\1", "\t")
	s = string.gsub(s, "\1", "")
	return s
end

-----------20.6-------------

