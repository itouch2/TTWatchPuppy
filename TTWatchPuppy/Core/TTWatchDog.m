//
//  TTWatchDog.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/2.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "TTWatchDog.h"
#import "TTWatchPuppy.h"
#import "TTUIThreadPuppy.h"
#import "TTNotificationPuppy.h"
#import "TTTableViewCellPuppy.h"
#import "TTUIExceptionPuppy.h"

@interface TTWatchDog ()

@property (nonatomic, strong) NSMutableArray<TTWatchPuppy *> *puppies;

@end


@implementation TTWatchDog

static TTWatchDog *dog = nil;

+ (instancetype)dog {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dog = [[TTWatchDog alloc] init];
        [dog breed];
    });
    return dog;
}

- (void)breed {
    // UI Thread puppy
    [self.puppies addObject:[[TTUIThreadPuppy alloc] init]];
    
    // Notification puppy
    TTNotificationPuppy *notificationPuppy = [[TTNotificationPuppy alloc] init];
    [notificationPuppy addClassToWatchList:@"ViewController"];
    [self.puppies addObject:notificationPuppy];
    
    // TableView Cell puppy
    [self.puppies addObject:[[TTTableViewCellPuppy alloc] init]];
    
    // UI Exception puppy
    [self.puppies addObject:[[TTUIExceptionPuppy alloc] init]];
}

- (void)barking {
    [_puppies enumerateObjectsUsingBlock:^(TTWatchPuppy * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj start];
    }];
}

#pragma mark - Getters

- (NSMutableArray *)puppies {
    if (!_puppies) {
        _puppies = [[NSMutableArray alloc] init];
    }
    return _puppies;
}

@end
