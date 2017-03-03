//
//  TTWatchPuppy.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/1.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "TTWatchPuppy.h"

@interface TTWatchPuppy ()

@property (nonatomic, copy) NSMutableSet *ignoredObjectList;
@property (nonatomic, copy) NSMutableSet *ignoredClassList;

@end


@implementation TTWatchPuppy

- (void)start {
    // prepare something...
    [self prepare];
}

- (void)prepare {
    
}

- (void)smell {
    
}

- (void)barking:(TTBarkingInfo *)barkingInfo {
    [[TTBarkingCenter sharedInstance] barking:barkingInfo];
}

@end
