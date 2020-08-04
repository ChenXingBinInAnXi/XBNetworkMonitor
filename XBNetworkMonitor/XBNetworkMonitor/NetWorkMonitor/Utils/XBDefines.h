//
//  XBDefines.h
//  XBNetworkMonitor
//
//  Created by iOS2019 on 2019/6/13.
//  Copyright © 2019 iOS2019. All rights reserved.
//

#ifndef XBDefines_h
#define XBDefines_h


#define XBLock(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER)
#define XBUnlock(lock) dispatch_semaphore_signal(lock)



#endif /* XBDefines_h */
