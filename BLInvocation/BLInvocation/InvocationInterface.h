//
//  InvocationInterface.h
//  InvocationStudyDemo
//
//  Created by 班磊 on 15/12/11.
//  Copyright © 2015年 bennyban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvocationInterface : NSObject

- (void)test;

- (void)testWithParam:(NSString *)param;

- (void)testWithParam1:(NSString *)param param2:(NSString *)param2 param3:(NSString *)param3;

- (NSString *)testGetReturnValue:(NSString *)param;

@end
