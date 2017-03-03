//
//  TTBarkingDot.h
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/3.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTBarkingDot : UIView

@property (nonatomic, assign) NSInteger count;


/**
 designated initializer

 @param tapBlock callback when tapped

 @return instance object
 */
- (instancetype)initWithTapBlock:(dispatch_block_t)tapBlock NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)show;
- (void)dismiss;

@end
