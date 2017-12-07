//
//  NSNotificationCenter+TTWatch.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/3.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "NSNotificationCenter+TTWatch.h"
#import "NSObject+TTHook.h"

static NSMutableArray<TTAddObserverCallback> *addObserverCallbacks = nil;
static NSMutableArray<TTRemoveObserverCallback> *removeObserverCallbacks = nil;

@implementation NSNotificationCenter (TTWatch)

+ (void)load {
    tt_swizzleInstanceSelector([self class], @selector(addObserver:selector:name:object:), @selector(tt_swizzledAddObserver:selector:name:object:));
    tt_swizzleInstanceSelector([self class], @selector(removeObserver:), @selector(tt_swizzledRemoveObserver:));
}

+ (void)registerAddObserverCallback:(TTAddObserverCallback)callback {
    if (!callback) {
        return;
    }
    
    if (!addObserverCallbacks) {
        addObserverCallbacks = [NSMutableArray array];
    }
    [addObserverCallbacks addObject:callback];
}

+ (void)registerRemoveObserverCallback:(TTRemoveObserverCallback)callback {
    if (!callback) {
        return;
    }

    
    if (!removeObserverCallbacks) {
        removeObserverCallbacks = [NSMutableArray array];
    }
    [removeObserverCallbacks addObject:callback];
}

- (void)tt_swizzledAddObserver:(id)observer selector:(SEL)aSelector name:(nullable NSNotificationName)aName object:(nullable id)anObject {
    
    [addObserverCallbacks enumerateObjectsUsingBlock:^(TTAddObserverCallback  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj(observer, aSelector, aName, anObject);
    }];
    
    [self tt_swizzledAddObserver:observer selector:aSelector name:aName object:anObject];
}

- (void)tt_swizzledRemoveObserver:(id)observer {
    
    [removeObserverCallbacks enumerateObjectsUsingBlock:^(TTRemoveObserverCallback  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj(observer);
    }];
    
    [self tt_swizzledRemoveObserver:observer];
}

@end
