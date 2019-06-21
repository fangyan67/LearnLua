print("----------- Chapter16 Log -----------")

Account = {balance = 0}
function Account.withdraw(v)
	Account.balance = Account.balance - v
end

Account.withdraw(100.00)

a = Account; --Account = nil
--a.withdraw(100.00)	--错误！

function Account.withdraw(self, v)
	self.balance = self.balance - v
end

a1 = Account; --Account = nil
a1.withdraw(a1, 100.00)

a2 = {balance=0, withdraw = Account.withdraw}
a2.withdraw(a2, 260.00)

function Account:withdraw(v)
	self.balance = self.balance - v
end

a:withdraw(100.00)

-----------16.1-------------

--setmetatable(a, {__index = b})

function Account:new(o)
	o = o or {}	--如果用户没有提供table，则创建一个
	setmetatable(o, self)
	self.__index = self
	return o
end

a = Account:new{balance = 0}
--a:deposit(100.00)

b = Account:new()
print(b.balance)

--b.balance = b.balance + v

-----------16.2-------------

Account = {balance = 0}

function Account:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Account:deposit(v)
	self.balance = self.balance + v
end

function Account:withdraw(v)
	if v > self.balance then
		print("error insufficient funds")
	end
	self.balance = self.balance - v
end

SpecialAccount = Account:new()
s = SpecialAccount:new{limit = 1000.00}
s:deposit(100.00)

function  SpecialAccount:withdraw(v)
	if v - self.balance >= self:getLimit() then
		print("error insufficient funds")
	end
	self.balance = self.balance - v
end

function SpecialAccount:getLimit()
	return self.limit or 0
end

s:withdraw(200.00)

function s:getLimit()
	return self.balance * 0.10
end

s:withdraw(200.00)

-----------16.3-------------

--在table 'plist'中查找'k'
local function search(k, plist)
	for i = 1, #plist do
		local v = plist[i][k]
		if v then
			return v
		end
	end
end

function createClass(...)
	local c = {}	--新类
	local parents = {...}

	--类在其父类列表中的搜索方法
	setmetatable(c, {__index = function(t, k)
		return search(k, parents);
	end})
--[[
setmetatable(c, {__index = function(t, k)
	local v = search(k, parents)
	t[k] = v	--保存下来，以备下次访问
	return v
end})
--]]
	--将'c'作为其实例的元表
	c.__index = c
	--为这个新类定义一个新的构造函数（construction)

	function c:new(o)
		o = o or {}
		setmetatable(o, c)
		return o
	end

	return c 	--返回新类
end

Named = {}
function Named:getname()
	return self.name
end

function Named:setname()
	self.name = n
end

NamedAccount = createClass(Account, Named)
account = NamedAccount:new {name = "Paul"}
print(account:getname() )

-----------16.4-------------

function newAccount(initialBalance)
	local self = {balance = initialBalance}
	local withdraw = function(v)
		self.balance = self.balance - v
	end
	local deposit = function(v)
		self.balance = self.balance + v
	end
	local getBalance = function()
		return self.balance
	end
	return {
		withdraw = withdraw,
		deposit = deposit,
		getBalance = getBalance
	}
end

acc1 = newAccount(100.00)
acc1.withdraw(40.00)
print(acc1.getBalance() )

function newAccount(initialBalance)
	local self = {
		balance = initialBalance,
		LIM = 10000.00,
	}
end

local extra = function()
	if self.balance > self.LIM then
		return self.balance * 0.10
	else
		return 0
	end
end

local getBalance = function()
	return self.balance + extra()
end

-----------16.5-------------

function newObject(value)
	return function(action, v)
		if action == "get" then return value
		elseif action == "set" then value = v
		else print("error invalid action")
		end
	end
end

d = newObject(0)
print(d("get"))
d("set", 10)
print(d("get"))