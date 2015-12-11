# BLInvocation
对iOS中的NSInvocation的理解和例子使用

#pragma mark - Invocation Part One
#pragma mark
- (void)invocationPartOne
{
    /**
     * 创建SEL方法两种 NSSelectorFromString(@"myLog"); 和 @selector(myLog);
     */
    SEL myMethod = @selector(doToLog);
    // 创建一个函数签名，这个签名可以是任意的，但需要注意，签名函数的参数数量和调用的一致。
    NSMethodSignature *methodSignature = [NSNumber instanceMethodSignatureForSelector:@selector(init)];
    // 通过签名初始化
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    // 设置target
    [invocation setTarget:self];
    // 设置selector
    [invocation setSelector:myMethod];
    
    [invocation invoke];
}

- (void)doToLog
{
    NSLog(@"是否执行了invocation");
}

#pragma mark - Invocation Part Two
#pragma mark
- (void)invocationPartTwo
{
    /**
     * 创建SEL方法两种 NSSelectorFromString(@"myLog"); 和 @selector(myLog);
     */
    SEL myMethod = @selector(doToMutableParam1:param2:param3:param4:);
    // 创建一个函数签名，这个签名可以是任意的，但需要注意，签名函数的参数数量和调用的一致。
    NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:myMethod];
    // 通过签名初始化
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    // 设置target
    [invocation setTarget:self];
    // 设置selector
    [invocation setSelector:myMethod];
    // 多于两个以上的参数
    NSString *param1 = @"执行param1";
    NSString *param2 = @"执行param2";
    NSString *param3 = @"执行param3";
    NSString *param4 = @"执行param4";
    [invocation setArgument:&param1 atIndex:2];
    [invocation setArgument:&param2 atIndex:3];
    [invocation setArgument:&param3 atIndex:4];
    [invocation setArgument:&param4 atIndex:5];
    
    // 消息调用
    [invocation invoke];
}

- (void)doToMutableParam1:(NSString *)param1 param2:(NSString *)param2 param3:(NSString *)param3 param4:(NSString *)param4
{
    NSLog(@"\nparam1:%@,\nparam2:%@,\nparam3:%@,\nparam4:%@",param1,param2,param3,param4);
}

#pragma mark - Invocation Part Three
#pragma mark
- (void)invocationPartThree
{
    /**
     * 创建SEL方法两种 NSSelectorFromString(@"myLog"); 和 @selector(myLog);
     */
    SEL myMethod = @selector(doToSimilarityMutableParam1:param2:param3:param4:);
    // 创建一个函数签名，这个签名可以是任意的，但需要注意，签名函数的参数数量和调用的一致。
    NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:myMethod];
    // 通过签名初始化
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    // 设置target
    ViewController *view = self;
    [invocation setArgument:&view atIndex:0];
    [invocation setArgument:&myMethod atIndex:1];
    // 多于两个以上的参数
    NSString *param1 = @"执行param1";
    NSString *param2 = @"执行param2";
    NSString *param3 = @"执行param3";
    NSString *param4 = @"执行param4";
    [invocation setArgument:&param1 atIndex:2];
    [invocation setArgument:&param2 atIndex:3];
    [invocation setArgument:&param3 atIndex:4];
    [invocation setArgument:&param4 atIndex:5];
    
    // 注意：签名函数的参数数量要和调用函数的一致。测试后发现，当签名函数参数数量大于被调函数时，也是没有问题的。
    
    // 消息调用
    [invocation invoke];
}

- (void)doToSimilarityMutableParam1:(NSString *)param1 param2:(NSString *)param2 param3:(NSString *)param3 param4:(NSString *)param4
{
    NSLog(@"\nparam1:%@,\nparam2:%@,\nparam3:%@,\nparam4:%@",param1,param2,param3,param4);
}

#pragma mark - Invocation Part Four
#pragma mark
- (void)invocationPartFour
{
    /**
     * 创建SEL方法两种 NSSelectorFromString(@"myLog"); 和 @selector(myLog);
     */
    SEL myMethod = @selector(doToMutableParam1:param2:param3:);
    // 创建一个函数签名，这个签名可以是任意的，但需要注意，签名函数的参数数量和调用的一致。
    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:myMethod];
    // 通过签名初始化
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
    // 设置target
    invocation.target = self;
    invocation.selector = myMethod;
    // 多于两个以上的参数
    NSString *param1 = @"执行param1";
    NSString *param2 = @"执行param2";
    NSString *param3 = @"执行param3";
    [invocation setArgument:&param1 atIndex:2];
    [invocation setArgument:&param2 atIndex:3];
    [invocation setArgument:&param3 atIndex:4];
    
    // 消息调用
    [invocation invoke];
    
    /**
     * 可以注意到- (void)retainArguments;这个方法，它会将传入的所有参数以及target都retain一遍。
     */
    //    [invocation retainArguments];
    //    [invocation setReturnValue:&param3];
    
    if ([sig methodReturnLength] > 0) {
        NSString *getReturnValue;
        [invocation getReturnValue:&getReturnValue];
        NSLog(@"\n getReturnValue:%@",getReturnValue);
    }
}

- (NSString *)doToMutableParam1:(NSString *)param1 param2:(NSString *)param2 param3:(NSString *)param3
{
    NSLog(@"\n执行返回值成功！！！\nparam1:%@,\nparam2:%@,\nparam3:%@",param1,param2,param3);
    return [NSString stringWithFormat:@"\n执行返回值成功！！！\nparam1:%@,\nparam2:%@,\nparam3:%@",param1,param2,param3];
}

#pragma mark - Invocation Part Five
#pragma mark - InvocationInterface - test
- (void)invocationPartFive
{
    // EasyJSWebView 使用方法可以借鉴
    //https://github.com/dukeland/EasyJSWebViewSample
    
    InvocationInterface *obj = [[InvocationInterface alloc] init];
    SEL mySeletor = @selector(test);
    // 创建一个函数签名，这个签名可以是任意的，但需要注意，签名函数的参数数量和调用的一致。
    NSMethodSignature *methodSignature = [[obj class] instanceMethodSignatureForSelector:mySeletor];
    // 通过签名初始化
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    // 设置target
    invocation.target = obj;
    invocation.selector = mySeletor;
    
    [invocation invoke];
}

#pragma mark - Invocation Part Six
#pragma mark - InvocationInterface - testWithParam:
- (void)invocationPartSix
{
    // EasyJSWebView 使用方法可以借鉴
    //https://github.com/dukeland/EasyJSWebViewSample
    
    InvocationInterface *obj = [[InvocationInterface alloc] init];
    SEL mySeletor = @selector(testWithParam:);
    // 创建一个函数签名，这个签名可以是任意的，但需要注意，签名函数的参数数量和调用的一致。
    NSMethodSignature *methodSignature = [[obj class] instanceMethodSignatureForSelector:mySeletor];
    // 通过签名初始化
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    // 设置target
    invocation.target = obj;
    invocation.selector = mySeletor;
    
    NSString *param = @"只有这一个参数";
    [invocation setArgument:&param atIndex:2];
    
    [invocation invoke];
}

#pragma mark - Invocation Part Seven
#pragma mark - InvocationInterface - testWithParam1:param2:param3:
- (void)invocationPartSeven
{
    // EasyJSWebView 使用方法可以借鉴
    //https://github.com/dukeland/EasyJSWebViewSample
    
    InvocationInterface *obj = [[InvocationInterface alloc] init];
    SEL mySeletor = @selector(testWithParam1:param2:param3:);
    // 创建一个函数签名，这个签名可以是任意的，但需要注意，签名函数的参数数量和调用的一致。
    NSMethodSignature *methodSignature = [[obj class] instanceMethodSignatureForSelector:mySeletor];
    // 通过签名初始化
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    // 设置target
    invocation.target = obj;
    invocation.selector = mySeletor;
    
    NSString *param1 = @"三个参数，第一个参数";
    NSString *param2 = @"三个参数，第二个参数";
    NSString *param3 = @"三个参数，第三个参数";
    [invocation setArgument:&param1 atIndex:2];
    [invocation setArgument:&param2 atIndex:3];
    [invocation setArgument:&param3 atIndex:4];
    
    [invocation invoke];
}

#pragma mark - Invocation Part Eight
#pragma mark - InvocationInterface - testGetReturnValue:
- (void)invocationPartEight
{
    // EasyJSWebView 使用方法可以借鉴
    //https://github.com/dukeland/EasyJSWebViewSample
    
    InvocationInterface *obj = [[InvocationInterface alloc] init];
    SEL mySeletor = @selector(testGetReturnValue:);
    // 创建一个函数签名，这个签名可以是任意的，但需要注意，签名函数的参数数量和调用的一致。
    NSMethodSignature *methodSignature = [[obj class] instanceMethodSignatureForSelector:mySeletor];
    // 通过签名初始化
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    // 设置target
    invocation.target = obj;
    invocation.selector = mySeletor;
    
    NSString *param1 = @"这就是返回值的一部分";
    [invocation setArgument:&param1 atIndex:2];
    
    [invocation invoke];
    
    if ([methodSignature methodReturnLength] > 0) {
        NSString *getReturnValue;
        [invocation getReturnValue:&getReturnValue];
        NSLog(@"\n getReturnValue:%@",getReturnValue);
    }
}
