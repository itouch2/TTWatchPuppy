//
//  NSObject+TTHook.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/10/30.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "NSObject+TTHook.h"
#import "NSObject+TTAutoLayout.h"

static NSMutableArray *deallocCallbacks = nil;

@interface TTDeallocMessenger : NSObject

@property (nonatomic, copy) dispatch_block_t notifier;

@end

@implementation TTDeallocMessenger

- (void)dealloc {
    if (self.notifier) {
        self.notifier();
    }
}

@end

@interface NSObject (Dealloc)

@property (nonatomic, strong) NSMutableArray<TTDeallocMessenger *> *deallocMessengers;

@end

@implementation NSObject (TTHook)

+ (void)load {
    [NSObject hookAutoLayoutException];
}

- (void)tt_registerDeallocCallback:(dispatch_block_t)callback {
    
    TTDeallocMessenger *messenger = [[TTDeallocMessenger alloc] init];
    messenger.notifier = callback;
    [self.deallocMessengers addObject:messenger];
}

- (void)setDeallocMessengers:(TTDeallocMessenger *)deallocMessengers {
    objc_setAssociatedObject(self, @selector(deallocMessengers), deallocMessengers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TTDeallocMessenger *)deallocMessengers {
    
    NSMutableArray *messengers = objc_getAssociatedObject(self, @selector(deallocMessengers));
    if (!messengers) {
        messengers = [[NSMutableArray alloc] init];
        [self setDeallocMessengers:messengers];
    }
    return objc_getAssociatedObject(self, @selector(deallocMessengers));
}

@end
