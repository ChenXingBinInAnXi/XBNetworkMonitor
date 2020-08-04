//
//  BaseProxy.h
//  XBNetworkMonitor
//
//  Created by iOS2019 on 2019/6/11.
//  Copyright © 2019 iOS2019. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseProxy : NSProxy

@property(nonatomic,weak,readonly) id target;

-(instancetype)initWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
