local pegasus = require 'pegasus'
local sqlite3 = require 'lsqlite3'
local db = sqlite3.open("rotel.rs232lib")

local server = pegasus:new('9090')

function commands()
	for row in db:nrows("SELECT name FROM Strings WHERE device = 22 OR device = 23") do
	  print(row.name)
	end
end

function command(cmd)
	if nil == cmd then
		return nil
	end

	local stmt = assert( db:prepare("SELECT string FROM Strings WHERE device = 22 AND name = ?") )
	stmt:bind_values(cmd)
	for row in stmt:nrows() do
		return row.string
	end
end

function hex_dump(buf)
	local out = ""
	for i=1,math.ceil(#buf/16) * 16 do
		out = out .. ( i > #buf and '   ' or string.format('%02X ', buf:byte(i)) )
		if i %  8 == 0 then out = out .. ' ' end
--		if i % 16 == 0 then out = out .. buf:sub(i-16+1, i):gsub('%c','.') end
	end
	return out
end

local tty = "/dev/ttyUSB0"
local port = assert( io.open(tty, "w") )
server:start(function (req, rep)
	print("path: " .. req.path)
	if "./commands" == req.path then
		rep.writeHead(200).finish('feel you should have some commands')
	elseif "./write" == req.path then

		local buf = command(req.post.command)

		print(req.post.command)

		if nil == buf then
			rep.writeHead(400).finish('{"error":"invalid command"}')
			print("DEBUG: pegasus sucks.... PATTERN_QUERY_STRING = '([^=]*)=([^&]*)&?")
		else
			print("write " .. hex_dump(buf))
			port:write(buf)
			port:flush()
			rep.writeHead(201).finish('{"message":"OK, GREAT!"}')
		end
	else
		rep.writeHead(400).finish('{"error":"no such endpoint"}')
	end
end)

db:close()


local select_stmt = assert( db:prepare("SELECT * FROM test") )

local function select()
  for row in select_stmt:nrows() do
    print(row.id, row.content)
  end
end
