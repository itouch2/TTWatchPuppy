//
//  TTBarkingInfo.h
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/2.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTBarkingHeader.h"

@interface TTSnapshot : NSObject

@property (nonatomic, strong, readonly) NSDate *timestamp;
@property (nonatomic, strong, readonly) NSArray<NSString *> *callStackSymbols;

@end


@interface TTBarkingInfo : NSObject<NSCopying>

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *desc;


/**
 The notification style.
 */
@property (nonatomic, assign) TTBarkingViewStyle style;

/**
 The snapshot.
 */
@property (nonatomic, strong, readonly) TTSnapshot *snapshot;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTitle:(NSString *)title description:(NSString *)description;

@end
