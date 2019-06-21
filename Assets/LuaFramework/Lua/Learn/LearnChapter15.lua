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
--m.write("hello world\n")

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

complex = {}

function complex.new(r, i)
	return {r=r, i=i}
end

--定义一个常量'i'
complex.i = complex.new(0, 1)

function complex.add(c1, c2)
	return complex.new(c1.r + c2.r, c1.i + c2.i)
end

function complex.sub(c1, c2)
	return complex.new(c1.r - c2.r, c1.i - c2.i)
end

function complex.mul(c1, c2)
	return complex.new(c1.r * c2.r - c1.i * c2.i, c1.r * c2.i +c1.i * c2.r)
end

local function inv(c)
	local n = c.r^2 + c.i^2
	return complex.new(c.r/n, -c.i/n)
end

function complex.div(c1, c2)
	return complex.mul(c1, inv(c2))
end

--return complex


local M = {}
complex = M

M.i = {r=0, i=1}
function M.new(r, i)
	return {r=r,i=i}
end

function M.add(c1, c2)
	return M.new(c1.r + c2.r, c1.i + c2.i)
end

local modname = ...
local M = {}
--_G[modname] = M

M.i = {r=0,i=1}

local modname = ...
local M = {}
--_G[modename] = M
--package.loaded[modenmae] = M

-----------15.3-------------

local modname = ...
local M = {}
--_G[modname] = M
--package.loaded[modname] = M
setfenv(1, M)

function add(c1, c2)
	return new(c1.r + c2.r, c1.i + c2.i)
end


local modname = ...
local M = {}
--_G[modname] = M
--package.loaded[modname] = M
--setmetatable(M, {__index = _G})
--setfenv(1, M)

--模块设置
local modname = ...
local M = {}
--_G[modname] = M
--package.loaded[modname] = M
--导入段：
--声明这个模块从外界所需的所有东西
--local sqrt = math.sqrt
--local io = io
--再这句之后就不再需要外部访问了
--setfenv(1, M)

-----------15.4-------------

--module(...)
--package.seeall
--setmetatable(M, {__index = _G})
--module(..., package.seeall)

-----------15.5-------------
--./?.lua;/usr/local/lua/?.lua;/usr/local/lua/?/init.lua
--require "a.b"
--a/b.lua