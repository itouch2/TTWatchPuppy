//
//  TTNotificationPuppy.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/2.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "TTNotificationPuppy.h"
#import "NSNotificationCenter+TTWatch.h"

@interface TTNotificationInfo : NSObject

@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) NSMutableArray *callStackSymbols;
@property (nonatomic, weak) id notificationObserver;

@end

@implementation TTNotificationInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _count = 1;
    }
    return self;
}

@end


@interface TTNotificationPuppy ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, TTNotificationInfo *> *notificationDict;
@property (nonatomic, strong) dispatch_queue_t notificationHandleQueue;
@property (nonatomic, strong) NSMutableArray<NSString *> *watchList;

@property (nonatomic, strong) NSString *currentMd5;
@property (nonatomic, assign) SEL currentSelector;
@property (nonatomic, copy) NSString *currentName;
@property (nonatomic, weak) id currentNotificationObserver;

@end

@implementation TTNotificationPuppy

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"Notification Thread";
    }
    return self;
}


- (void)prepare {
    // register add observer callback
    __weak typeof(self) weakSelf = self;
    [NSNotificationCenter registerAddObserverCallback:^(id observer, SEL selector, NSNotificationName name, id object) {
        if ([weakSelf belongToWatchList:[observer class]]) {
            [weakSelf preaddObserver:observer selector:selector name:name object:object];
        }
    }];
    
    [NSNotificationCenter registerRemoveObserverCallback:^(id notificationObserver) {
        if ([weakSelf belongToWatchList:[notificationObserver class]]) {
            [weakSelf preremoveObserver:notificationObserver];
        }
    }];
}

- (void)smell {
    
    if (!self.currentMd5) {
        // throws an internal exception
    }
    
    TTNotificationInfo *info = self.notificationDict[self.currentMd5];
    info.notificationObserver = self.currentNotificationObserver;
    
    /*
     __weak typeof(self) weakSelf = self;
     // When version is below 9, make sure the notification is removed as expected.
     
     if ([self.currentNotificationObserver isKindOfClass:NSClassFromString(@"TT")]) {
     
     }
     
     [self.currentNotificationObserver tt_registerDeallocCallback:^{
     [weakSelf.notificationDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, TTNotificationInfo * _Nonnull obj, BOOL * _Nonnull stop) {
     if (obj.notificationObserver == weakSelf.currentNotificationObserver) {
     // Oops...
     TTBarkingInfo *barkingInfo = [[TTBarkingInfo alloc] init];
     barkingInfo.title = @"Observer should be removed...";
     barkingInfo.desc = @"Notification observed %@";
     
     [[TTPuppyBarkingCenter sharedInstance] barking:barkingInfo];
     }
     }];
     }];
     */
    
    if (!info) {
        TTNotificationInfo *info = [[TTNotificationInfo alloc] init];
        info.notificationObserver = self.currentNotificationObserver;
        [self.notificationDict setObject:info forKey:self.currentMd5];
    } else {
        info.count++;
        
        // barking
        NSString *title = @"Notification observed more than once";
        NSString *desc = [NSString stringWithFormat:@"Notification %@ observed %@", self.currentMd5, @(info.count)];
        TTBarkingInfo *barkingInfo = [[TTBarkingInfo alloc] initWithTitle:title description:desc];
        [self barking:barkingInfo];
    }
    self.currentMd5 = nil;
}


#pragma mark - Private Method

- (void)addClassToWatchList:(NSString *)watchedClass {
    [self.watchList addObject:watchedClass];
}

- (BOOL)belongToWatchList:(Class)theClass {
    __block BOOL belong = NO;
    NSString *className = NSStringFromClass(theClass);
    [self.watchList enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([className hasPrefix:obj]) {
            belong = YES;
            *stop = YES;
        }
    }];
    return belong;
}

- (void)preaddObserver:(id)observer selector:(SEL)aSelector name:(nullable NSNotificationName)aName object:(nullable id)anObject {
    
    dispatch_async(self.notificationHandleQueue, ^{
        
        [self resetNotificationParameters];
        
        // calculate the md5 of the notification parameters...
        self.currentMd5 = aName;
        self.currentSelector = aSelector;
        self.currentName = aName;
        self.currentNotificationObserver = observer;
        
        [self smell];
    });
}

- (void)preremoveObserver:(id)notificationObserver {
    dispatch_async(self.notificationHandleQueue, ^{
        NSMutableArray *removedKeys = [NSMutableArray array];
        [self.notificationDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, TTNotificationInfo * _Nonnull obj, BOOL * _Nonnull stop) {
            if (obj.notificationObserver == notificationObserver) {
                obj.count--;
                if (obj.count == 0) {
                    [removedKeys addObject:key];
                }
            }
        }];
        [self.notificationDict removeObjectsForKeys:removedKeys];
    });
}

- (void)resetNotificationParameters {
    self.currentMd5 = nil;
    self.currentSelector = NULL;
    self.currentName = nil;
}

#pragma mark - Getters

- (dispatch_queue_t)notificationHandleQueue {
    if (!_notificationHandleQueue) {
        _notificationHandleQueue = dispatch_queue_create("com.TT.notificationQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _notificationHandleQueue;
}

- (NSMutableDictionary *)notificationDict {
    if (!_notificationDict) {
        _notificationDict = [NSMutableDictionary dictionary];
    }
    return _notificationDict;
}

- (NSMutableArray *)watchList {
    if (!_watchList) {
        _watchList = [NSMutableArray array];
    }
    return _watchList;
}

@end
