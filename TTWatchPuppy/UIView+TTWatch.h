//
//  UIView+TTWatch.h
//  TTWatchPuppy
//
//  Created by You Tu on 2016/10/30.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TTCellAddSubviewCallback)(UIView *view);

@interface UIView (TTWatch)

+ (void)registerSetNeedsDisplayObserver:(dispatch_block_t)observer;
+ (void)registerSetNeedsDisplayInRectObserver:(dispatch_block_t)observer;
+ (void)registerSetNeedsLayoutObserver:(dispatch_block_t)observer;

+ (void)registerCellAddSubviewObserver:(TTCellAddSubviewCallback)observer;


@end
