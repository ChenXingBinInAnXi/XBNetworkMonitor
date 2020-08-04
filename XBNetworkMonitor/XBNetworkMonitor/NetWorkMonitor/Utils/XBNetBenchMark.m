//
//  XBNetBenchMark.m
//  XBNetworkMonitor
//
//  Created by iOS2019 on 2019/6/13.
//  Copyright © 2019 iOS2019. All rights reserved.
//

#import "XBNetBenchMark.h"
#import "XBDefines.h"

@interface XBNetBenchMark(){
    NSMutableDictionary *_beginCache;
    NSMutableDictionary *_benchMarkCache;
    dispatch_semaphore_t _lock;
}
@end

@implementation XBNetBenchMark


- (instancetype)init{
    self = [super init];
    if (self) {
        _beginCache = [NSMutableDictionary new];
        _benchMarkCache = [NSMutableDictionary new];
         _lock = dispatch_semaphore_create(1);
    }
    return self;
}

-(void)beginMarkWithKey:(NSString *)key{
    if (!key) return;
    XBLock(_lock);
    _beginCache[key] = @(CFAbsoluteTimeGetCurrent());
    XBUnlock(_lock);
}

-(void)finishMarkWithKey:(NSString *)key{
    if (!key) return;
    
    XBLock(_lock);
    double begin = [_beginCache[key]  doubleValue];
    double value = CFAbsoluteTimeGetCurrent() - begin;
    value = floor(value * 10000) / 10000;
    _benchMarkCache[key] = @(value);
    XBUnlock(_lock);
}




-(void)directSetCost:(double)cost forKey:(NSString *)key{
    if (!key) return;
    
    XBLock(_lock);
    _benchMarkCache[key] = @(cost);
    XBUnlock(_lock);
}

-(double)costTimeForKey:(NSString *)key{
    if (!key) return 0;
    XBLock(_lock);
    NSNumber *cost = _benchMarkCache[key];
    XBUnlock(_lock);
    return [cost doubleValue];
}



- (NSString*)description{
    NSString * desp = @"";
    @try {
        @synchronized (self) {
            NSData* data = [NSJSONSerialization dataWithJSONObject:_benchMarkCache options:0 error:nil];
            if (!data) {
                return @"{}";
            }
            desp = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
    } @catch (NSException *exception) {
        desp = @"";
    } @finally {
        return desp;
    }
}



@end
