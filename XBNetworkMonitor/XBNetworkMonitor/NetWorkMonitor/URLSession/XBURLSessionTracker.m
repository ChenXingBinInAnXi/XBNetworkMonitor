//
//  XBURLSessionTracker.m
//  XBNetworkMonitor
//
//  Created by iOS2019 on 2019/6/11.
//  Copyright © 2019 iOS2019. All rights reserved.
//

#import "XBURLSessionTracker.h"
#import <objc/runtime.h>
#import "BaseProxy.h"


@interface XBURLSessionProxy : BaseProxy
@end


@implementation XBURLSessionProxy

-(BOOL)respondsToSelector:(SEL)aSelector{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"URLSession:task:didFinishCollectingMetrics:"]) {
        return YES;
    }else if ([NSStringFromSelector(aSelector) isEqualToString:@"URLSession:task:didCompleteWithError:"]){
        return YES;
    }
    return [self.target respondsToSelector:aSelector];
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector{
    if (!self.target) {
        return [NSMethodSignature signatureWithObjCTypes:"v@"];
    }
    return [self.target methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    if (!self.target) {
        return;
    }
    if ([self.target respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:self.target];
    }
    if (@available(iOS 10.0, *)) {
        if ([NSStringFromSelector(invocation.selector) isEqualToString:@"URLSession:task:didFinishCollectingMetrics:"]) {
            __unsafe_unretained NSURLSessionTaskMetrics *metrics;
            [invocation getArgument:&metrics atIndex:4];
//            [[NTDataKeeper shareInstance] trackSessionMetrics:metrics];
        }
    }else{
        if ([NSStringFromSelector(invocation.selector) isEqualToString:@"URLSession:task:didCompleteWithError:"]) {
            __unsafe_unretained NSURLSessionTask *task;
            [invocation getArgument:&task atIndex:3];
            SEL selector = NSSelectorFromString([@"_timin" stringByAppendingString:@"gData"]);
            NSDictionary *timingData = [task performSelector:selector];
//            [[NTDataKeeper shareInstance] trackTimingData:timingData request:task.currentRequest];
        }
    }
}


@end




@implementation NSURLSession(tracker)

+(void)startTrack{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [self class];
        SEL originalSelector = @selector(sessionWithConfiguration:delegate:delegateQueue:);
        SEL swizzledSelector = @selector(swizzled_sessionWithConfiguration:delegate:delegateQueue:);
        
        Method originalMethod = class_getClassMethod(cls, originalSelector);
        Method swizzledMethod = class_getClassMethod(cls, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}


+ (NSURLSession *)swizzled_sessionWithConfiguration:(NSURLSessionConfiguration *)configuration delegate:(nullable id <NSURLSessionDelegate>)delegate delegateQueue:(nullable NSOperationQueue *)queue{
    
    
   
    return nil;
}





@end

