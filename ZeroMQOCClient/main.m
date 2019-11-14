//
//  main.m
//  ZeroMQOCClient
//
//  Created by Judith on 2019/11/13.
//  Copyright © 2019 Judith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMQObjC.h"

void zmq_client_requester() {
    ZMQContext *context = [[ZMQContext alloc] initWithIOThreads:1];
    ZMQSocket *requester = [context socketWithType:ZMQ_REQ];
    BOOL connect = [requester connectToEndpoint:@"tcp://localhost:5555"];
    if (connect) {
        NSLog(@"连接服务器成功!\n");
        for (int i = 0; i < 10; i++) {
            NSString *sendStr = @"你好呀！";
            NSData *data = [sendStr dataUsingEncoding:NSUTF8StringEncoding];
            [requester sendData:data withFlags:0];
            NSData *rData = [requester receiveDataWithFlags:0];
            NSString *rStr = [[NSString alloc] initWithData:rData encoding:NSUTF8StringEncoding];
            NSLog(@"%@",rStr);
            
        }
    }
    [context closeSockets];
    [context terminate];
}

void zmq_client_subcriber () {
    ZMQContext *context = [[ZMQContext alloc] initWithIOThreads:1];
    ZMQSocket *subcriber = [context socketWithType:ZMQ_SUB];
    BOOL connect = [subcriber connectToEndpoint:@"tcp://localhost:5555"];
    if (connect) {
        NSLog(@"连接服务器成功!\n");
        BOOL subcribe = [subcriber subscribe:@"1"];
        if (subcribe) {
            for (int i = 0; i < 10; i++) {
                NSData *rData = [subcriber receiveDataWithFlags:0];
                NSString *rStr = [[NSString alloc] initWithData:rData encoding:NSUTF8StringEncoding];
                NSLog(@"%@",rStr);
            }
        }
    }
    [context closeSockets];
    [context terminate];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        zmq_client_requester();
        zmq_client_subcriber();
    }
    return 0;
}
