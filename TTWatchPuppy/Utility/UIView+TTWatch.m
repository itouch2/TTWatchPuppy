//
//  UIView+TTWatch.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/10/30.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "UIView+TTWatch.h"
#import "NSObject+TTHook.h"

static NSMutableArray<dispatch_block_t> *setNeedsDisplayObservers = nil;
static NSMutableArray<dispatch_block_t> *setNeedsDisplayInRectObservers = nil;
static NSMutableArray<dispatch_block_t> *setNeedsLayoutObservers = nil;
static NSMutableArray<TTCellAddSubviewCallback> *cellAddSubviewObservers = nil;

@implementation UIView (TTWatch)

+ (void)load {
    tt_swizzleInstanceSelector([self class], @selector(setNeedsDisplay), @selector(tt_swizzledSetNeedsDisplay));
    tt_swizzleInstanceSelector([self class], @selector(setNeedsDisplayInRect:), @selector(tt_swizzledSetNeedsDisplayInRect:));
    tt_swizzleInstanceSelector([self class], @selector(setNeedsLayout), @selector(tt_swizzledSetNeedsLayout));
    tt_swizzleInstanceSelector([self class], @selector(addSubview:), @selector(tt_swizzledAddSubview:));
}

+ (void)registerSetNeedsDisplayObserver:(dispatch_block_t)observer {
    if (!observer) {
        return;
    }

    if (!setNeedsDisplayObservers) {
        setNeedsDisplayObservers = [NSMutableArray array];
    }
    [setNeedsDisplayObservers addObject:observer];
}

+ (void)registerSetNeedsDisplayInRectObserver:(dispatch_block_t)observer {
    if (!observer) {
        return;
    }
    
    if (!setNeedsDisplayInRectObservers) {
        setNeedsDisplayInRectObservers = [NSMutableArray array];
    }
    [setNeedsDisplayInRectObservers addObject:observer];
}

+ (void)registerSetNeedsLayoutObserver:(dispatch_block_t)observer {
    if (!observer) {
        return;
    }

    if (!setNeedsLayoutObservers) {
        setNeedsLayoutObservers = [NSMutableArray array];
    }
    [setNeedsLayoutObservers addObject:observer];
}

+ (void)registerCellAddSubviewObserver:(TTCellAddSubviewCallback)observer {
    if (!observer) {
        return;
    }
    
    if (!cellAddSubviewObservers) {
        cellAddSubviewObservers = [NSMutableArray array];
    }
    [cellAddSubviewObservers addObject:observer];
}

- (void)tt_swizzledSetNeedsDisplay {
    [setNeedsDisplayObservers enumerateObjectsUsingBlock:^(dispatch_block_t _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj();
    }];
    [self tt_swizzledSetNeedsDisplay];
}

- (void)tt_swizzledSetNeedsDisplayInRect:(CGRect)rect {
    [setNeedsDisplayInRectObservers enumerateObjectsUsingBlock:^(dispatch_block_t  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj();
    }];
    
    [self tt_swizzledSetNeedsDisplayInRect:rect];
}

- (void)tt_swizzledSetNeedsLayout {
    [setNeedsLayoutObservers enumerateObjectsUsingBlock:^(dispatch_block_t  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj();
    }];
    
    [self tt_swizzledSetNeedsLayout];
}

- (void)tt_swizzledAddSubview:(UIView *)view {
    if ([self isKindOfClass:[UITableViewCell class]] &&
        ![NSStringFromClass([view class]) isEqualToString:@"UITableViewCellContentView"] &&
        ![NSStringFromClass([view class]) isEqualToString:@"_UITableViewCellSeparatorView"] &&
        view != ((UITableViewCell *)self).accessoryView &&
        view) {
        [cellAddSubviewObservers enumerateObjectsUsingBlock:^(TTCellAddSubviewCallback  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj(view);
        }];
    }
    [self tt_swizzledAddSubview:view];
}

@end
