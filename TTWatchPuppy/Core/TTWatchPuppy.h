//
//  TTWatchPuppy.h
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/1.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTBarkingCenter.h"
#import "NSObject+TTHook.h"

typedef NS_ENUM(NSInteger, TTWatchPuppyLevel) {
    TTWatchPuppyLevelLow,
    TTWatchPuppyLevelNormal,
    TTWatchPuppyLevelHigh
};


@protocol TTWatchPuppyProtocol <NSObject>

@optional
- (void)addObjectToIgnoreList:(id)object;
- (void)addClassToIgnoreList:(Class)theClass;
- (void)preferredBarkingStyle;

@end


@interface TTWatchPuppy : NSObject<TTWatchPuppyProtocol>

/**
 Puppy name.
 */
@property (nonatomic, copy) NSString *name;


/**
 This method is the template method. Do not override this method.
 */
- (void)start;

/**
 Prepare stuff.
 */
- (void)prepare;

/**
 Detect the potential issue
 */
- (void)smell;

/**
 Notify the issue.

 @param barkingInfo the issue info
 */
- (void)barking:(TTBarkingInfo *)barkingInfo;

@end
