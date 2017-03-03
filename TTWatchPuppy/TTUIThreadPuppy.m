//
//  TTUIThreadPuppy.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/2.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "TTUIThreadPuppy.h"
#import "UIView+TTWatch.h"

@implementation TTUIThreadPuppy

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"UI Thread";
    }
    return self;
}


- (void)prepare {
    // register setNeedsDisplay observer
    __weak typeof(self) weakSelf = self;
    dispatch_block_t block = ^(void) {
        [weakSelf smell];
    };
    
    [UIView registerSetNeedsDisplayObserver:block];
    [UIView registerSetNeedsDisplayInRectObserver:block];
    [UIView registerSetNeedsLayoutObserver:block];
}

- (void)smell {
    // UI Operation should run in the main thread
    if (![NSThread isMainThread]) {
        // barking...
        
        NSString *title = @"UI Main Thread";
        NSString *desc = @"UI Operation should run in main thread.";
        TTBarkingInfo *info = [[TTBarkingInfo alloc] initWithTitle:title description:desc];
        [self barking:info];
    }
}

@end
