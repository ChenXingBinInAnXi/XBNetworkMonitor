//
//  BaseProxy.m
//  XBNetworkMonitor
//
//  Created by iOS2019 on 2019/6/11.
//  Copyright © 2019 iOS2019. All rights reserved.
//

#import "BaseProxy.h"

@implementation BaseProxy


-(instancetype)initWithTarget:(id)target{
    _target = target;
    return self;
}

+(instancetype)proxyWithTarget:(id)target{
    return [[BaseProxy alloc] initWithTarget:target];
}

-(BOOL)respondsToSelector:(SEL)aSelector{
    return [self.target respondsToSelector:aSelector];
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    if (!self.target) {
        return [NSMethodSignature signatureWithObjCTypes:"v@"];
    }
    return [self.target methodSignatureForSelector:sel];
}

-(void)forwardInvocation:(NSInvocation *)invocation{
    if (!self.target) return;
    
    if ([self.target respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:self.target];
    }
}


@end
