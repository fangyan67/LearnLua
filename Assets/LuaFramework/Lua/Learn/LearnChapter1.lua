print("----------- Chapter1 Log -----------")

print("hello world")

function fact(n)
	if n == 0 then
		return 1
	else
		return n * fact(n-1)
	end
end

--print("enter a number")
--a = io.read("*number")
print(fact(33))

--require("Learn/sth/lib1")
dofile("Learn/sth/lib1")
n = norm(3.4, 1.0)
print(twice(n))

--[[
print(10)
--]]

---[[
print(10)
--]]

print(b)
b = 10
print(b)

b = nil
print(b)

require("Learn/sth/lib2")