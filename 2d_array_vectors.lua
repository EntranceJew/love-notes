-- [17:06] <BobbyJones> 2d we just do map[x][y] but for 1d its complicated you would have to find a way to store the coords in there along with the data.
-- [17:12] <BobbyJones> like for example map[x][y] returns {x,y}
-- [17:12] <BobbyJones> so rewriting that would be difficult.
-- [17:10] <+slime> instead of having {{x,y}, {x,y}, {x,y}, {x,y}, ...}, you could have {x,y, x,y, x,y, x,y, ...}
-- [17:12] <+slime> intead you could have it be map[x][y*2+0] returns x, and map[x][y*2+1] returns y
-- [17:18] <+slime> a basic test of a single table-of-1024-vectors saved 50% of the space by doing that

--[[
My results (OS X with 64-bit LuaJIT 2.0.3):

2D array of table vectors: 64.05 MB
2D array of loose vector components: 32.05 MB
linear array of table vectors: 64.00 MB
linear array of loose vector components: 16.00 MB
2D array of struct double vectors: 32.05 MB
2D array of struct float vectors: 24.05 MB
FFI linear array of struct double vectors: 31.69 MB
FFI linear array of struct float vectors: 15.08 MB
]]

local ffi = require("ffi")

ffi.cdef[[
struct DoubleVector { double x, y; };
struct FloatVector { float x, y; };
]]

local newDoubleVector = ffi.typeof("struct DoubleVector")
local newFloatVector = ffi.typeof("struct FloatVector")

local WIDTH = 1024
local HEIGHT = 1024

local function test(name, func)
	collectgarbage("collect")
	collectgarbage("collect")

	local memcount = collectgarbage("count")
	func()
	local diff = collectgarbage("count") - memcount
	print(string.format("%s: %.2f MB", name, diff/1024))
	
	collectgarbage("collect")
end

test("2D array of table vectors", function()
	local t = {}
	for y=1, HEIGHT do
		t[y] = {}
		for x=1, WIDTH do
			t[y][x] = {love.math.random(), love.math.random()}
		end
	end
end)

test("2D array of loose vector components", function()
	local t = {}
	for y=1, HEIGHT do
		t[y] = {}
		for x=1, WIDTH*2, 2 do
			t[y][x*2 + 0] = love.math.random()
			t[y][x*2 + 1] = love.math.random()
		end
	end
end)

test("linear array of table vectors", function()
	local t = {}
	for i=0, HEIGHT*WIDTH - 1 do
		t[i] = {love.math.random(), love.math.random()}
	end
	
	-- index using: vec = t[((y - 1) * WIDTH) + (x - 1)]
end)


test("linear array of loose vector components", function()
	local t = {}
	for i=0, HEIGHT*WIDTH*2 - 1, 2 do
		t[i+0] = love.math.random()
		t[i+1] = love.math.random()
	end
	
	-- index using:
	-- x_component = t[(((y - 1) * WIDTH) + (x - 1)) * 2 + 0]
	-- y_component = t[(((y - 1) * WIDTH) + (x - 1)) * 2 + 1]
end)

test("2D array of struct double vectors", function()
	local t = {}
	for y=1, HEIGHT do
		t[y] = {}
		for x=1, WIDTH do
			t[y][x] = newDoubleVector(love.math.random(), love.math.random())
		end
	end
end)

test("2D array of struct float vectors", function()
	local t = {}
	for y=1, HEIGHT do
		t[y] = {}
		for x=1, WIDTH do
			t[y][x] = newFloatVector(love.math.random(), love.math.random())
		end
	end
end)

test("FFI linear array of struct double vectors", function()
	local array = ffi.new("struct DoubleVector[?]", HEIGHT*WIDTH)
	for y=0, HEIGHT-1 do
		for x=0, WIDTH-1 do
			array[y*WIDTH + x].x = love.math.random()
			array[y*WIDTH + x].y = love.math.random()
		end
	end
end)

test("FFI linear array of struct float vectors", function()
	local array = ffi.new("struct FloatVector[?]", HEIGHT*WIDTH)
	for y=0, HEIGHT-1 do
		for x=0, WIDTH-1 do
			array[y*WIDTH + x].x = love.math.random()
			array[y*WIDTH + x].y = love.math.random()
		end
	end
end)