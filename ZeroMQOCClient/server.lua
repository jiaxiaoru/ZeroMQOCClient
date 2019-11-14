require "zhelpers"
local zmq = require "lzmq"
local context = zmq.context()
-- local reply, err = context:socket{zmq.REP, bind = "tcp://*:5555"}
-- print(reply,err)
-- if err == nil then
-- 	print('等待客户端连接')
-- 	while true do
-- 		local request = reply:recv()
-- 		print('客户端的消息是：',request)
-- 		s_sleep(1000)
-- 		reply:send("连接上了 您好呀!")
-- 	end
-- end

local publisher, err = context:socket{zmq.PUB, bind = "tcp://*:5555"}
print(publisher,err)
if err == nil then
	print('等待订阅...')
	local i = 2
	while true do
		local msg = string.format("%d %s",i,' 连接上了 您好呀!')
		publisher:send(msg)
		i=i+1
		s_sleep(1000)
		print('休息完')
	end
end
