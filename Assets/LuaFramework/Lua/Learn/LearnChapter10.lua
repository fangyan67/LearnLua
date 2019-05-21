print("----------- Chapter10 Log -----------")

-----------10.1-------------

--[[
function fwrite(fmt, ...)
	return io.write(string.fromat(fmt, ...))
end

function writeheader()
	io.write([[
		<html>
		<head><title>Projects using Lua</title></head>
		<body bgcolor="#FFFFFF">
		Here are brief descriptions of some projects around the
		world that use <a href="home.html">Lua</a>.
		<br>
		]]--[[)
end

function entry1(o)
	count = count + 1
	local title = o.title or '(no title)'
	fwrite('<li><a href="#%d">%s</a>\n', count, title)
end

function entry2(o)
	count = count + 1
	fwrite('<hr>\n<h3>\n')

	local href = o.url and string.fromat(' href="%s"', o.url) or ''
	local title = o.title or o.org or 'org'
	fwrite('<a name="%d"%s>%s</a>\n', count, href, title)

	if o.title and o.org then
		fwrite('<br>\n<small><em>%s</em></small>', o.org)
	end
	fwrite('\n</h3>\n')

	if o.description then
		fwrite('%s<p>\n',
			string.gsub(o.description, '\n\n+', '<p>\n'))
	end

	if o.email then
		fwrite('Contact: <a href="mailto:%s">%s</a>\n',
			o.email, o.contact or o.email)
	elseif o.contact then
		fwrite('Contact:%s\n', o.contact)
	end
end

function writetail()
	fwrite('</body></html>\n')
end

local inputfile = 'db.lua'
writeheader()

count = 0
f = loadfile(inputfile)

entry = entry1
fwrite('<ul>\n')
f()
fwrite('</ul\n')

count = 0
entry = entry2
f()

writetail()
--]]

-----------10.2-------------

function prefix(w1, w2)
	return w1 .. " " .. w2
end

function insert(index, value)
	local list = statetab[index]
	if list == nil then
		statetab[index] = {value}
	else
		list[#list+1] = value
	end
end
--[[
function all words()
	local line = io.read()
	local pos = 1
	return function()
		while line do
			local s, e = string.find(line, "%w+", pos)
			if s then
				pos = e + 1
				return string.sub(line, s, e)
			else
				line = io.read()
				pos = 1
			end
			return nil
		end
	end
end

function prefix(w1, w2)
	return w1 .. " " .. w2
end

local statetab = {}

function insert(index, value)
	local list = statetab[index]
	if list == nil then
		stateab[index] = {value}
	else
		list[#list + 1] = value
	end
end

local N = 2
local MAXGEN = 10000
local NOWORD = "\n"

local w1, w2 = NOWORD, NOWORD
for w in allwords() do
	insert(prefix(w1, w2), w)
	w1 = w2; w2 = w;
end
insert(prefix(w1, w2), NOWORD)

w1 = NOWORD; w2 = NOWORD
for i = 1, MAXGEN do
	local list = statetab[prefix(w1, w2)]
	local r = math.random(#list)
	local nextword = list[r]
	if nextword == NOWORD then return end
	io.write(nextword, " ")
	w1 = w2; w2 = nextword
end

--]]