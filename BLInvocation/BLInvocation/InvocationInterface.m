//
//  InvocationInterface.m
//  InvocationStudyDemo
//
//  Created by 班磊 on 15/12/11.
//  Copyright © 2015年 bennyban. All rights reserved.
//

#import "InvocationInterface.h"

@implementation InvocationInterface

- (void)test
{
    NSLog(@"test");
}

- (void)testWithParam:(NSString *)param
{
    NSLog(@"testWithParam:%@",param);
}

- (void)testWithParam1:(NSString *)param param2:(NSString *)param2 param3:(NSString *)param3
{
    NSLog(@"testWithParam1:%@ param2:%@ param3:%@",param,param2,param3);
}

- (NSString *)testGetReturnValue:(NSString *)param
{
    NSLog(@"getReturnValue:%@",param);
    NSString *title = [NSString stringWithFormat:@"执行成功，返回数据：%@",param];
    return title;
}

@end
