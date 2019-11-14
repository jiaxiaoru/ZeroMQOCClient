#!/usr/bin/python
#-*-coding:utf-8-*-

import zmq
context = zmq.Context()
#socket = context.socket(zmq.PUB)
#socket.bind("tcp://*:5555")
#while True:
#    msg = raw_input('input your data:')
#    socket.send(msg)
socket = context.socket(zmq.REP)
socket.bind("tcp://*:5555")
while True:
    print socket.recv()
    msg = raw_input('say something to client:')
    socket.send(msg)

