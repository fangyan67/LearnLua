print("----------- Chapter15 Log -----------")

--[[
require "mod"
mod.foo

local m = require "mod"
m.foo

require "mod"
local f = mode.foo
f()
--]]

-----------15.1-------------

local m = require "io"
m.write("hello world\n")

function require(name)
	if not package.loaded[name] then
		local loader = findloader(name)
		if loader == nil then
			error("unable to load module " .. name)
		end
		package.loaded[name] = true
		local res = loader(name)
		if res ~= nil then
			package.loaded[name] = res
		end
		return package.loaded[name]
	end
end

--多次加载
--package.loaded["foo"] = nil
--require "foo"

--[[
?;?.lua;c:\windows\?;/usr/local/lua/?/?.lua

require:
sql
sql.lua
c:\windows\sql
/usr/local/lua/sql/sql.lua

LUA_PATH -> package.path

]]--

-----------15.2-------------

