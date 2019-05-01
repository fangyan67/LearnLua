print("----------- Chapter3 Log -----------")

-----------3.1-------------
--a % b == a - floor(a/b)*b

x = math.pi
print(x - x%0.01)

local tolerance = 10
function isturnback(angle)
	angle = angle % 360
	return (math.abs(angle - 180) < tolerance)
end

print(isturnback(-180))

local tolerance = 0.17
function isturnback(angle)
	angle = angle % (2*math.pi)
	return (math.abs(angle - math.pi) < tolerance)
end

--------3.2---------

a = {}; a.x = 1; a.y = 0
b = {}; b.x = 1; b.y = 0
c = a
print(a == c)
print(a ~= b)

--------3.3----------

print(4 and 5)
print(nil and 13)
print(false and 13)
print(4 or 5)
print(false or 5)

x = nil
v = 2
x = x or v
print(x)

z = (2 < 3) and 2 or 3
print(z)

print(not nil)
print(not false)
print(not 0)
print(not not nil)

--------3.4--------------

print("Hello " .. "World")
print(0 .. 1)

a = 'Hello'
print(a .. " World")
print(a)

----------3.5-------------

--a + i < b / 2 + 1
--5 + x ^ 2 * 8
--a < y and y <= z
---x ^ 2
--x ^ y ^ z

n = 3 / 2 + 1
print(n)

----------3.6------------

t = {}
days = {"Sunday", "Monday", "Tuesday", "Wednesday",
		"Thursday", "Friday", "Saturday"};
print(days[4])

a = {x=10, y=20}

w = {x = 0, y = 0, label = "console"}
x = {math.sin(0), math.sin(1), math.sin(2)}
w[1] = "another field"
x.f = w
print(w["x"])
print(w[1])
print(x.f[1])
print(x.f.label)
w.x = nil

listSource = {
	"1321fewfw",
	"fewfw231",
	"fewfew213",
	"fewvw1231321"
}
print(tostring(listSource) )

list = nil
for k, v in pairs(listSource) do
	print(tostring(v) )
	list = {next=list, value=v}
end

local l = list
while l do
	print(l.value)
	l = l.next
end

polyline = {color="blue", thickness=2, npoints=4,
			{x=0, y=0},
			{x=-10, y=0},
			{x=-10, y=1},
			{x=0, y=1}
			}
print(polyline[2].x)	--> -10
print(polyline[4].y)	--> 1

opnames = {["+"] = "add", ["-"] = "sub",
			["*"] = "mul", ["/"] = "div"}

i = 20; s = "-"
a = {[1+0] = s, [i+1] = s .. s, [i+2] = s .. s .. s}

print(opnames[s])	-->sub
print(a[22])		-->---

days = {[0]="Sunday", "Monday", "Tuesday", "Wednesday",
		"Thursday", "Friday", "Saturday"}
print(days[3])

a = {x = 10, y = 45; "one", "two", "three"}
print(a[2])