//
//  UIViewController+TTHook.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/12/10.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "UIViewController+TTHook.h"
#import "NSObject+TTHook.h"

static NSMutableArray *viewDidAppearObservers = nil;
static NSMutableArray *viewDidDisappearObservers = nil;

@implementation UIViewController (TTHook)

+ (void)load {
    tt_swizzleInstanceSelector([self class], @selector(viewDidAppear:), @selector(tt_swizzledViewDidAppear:));
    tt_swizzleInstanceSelector([self class], @selector(viewDidDisappear:), @selector(tt_swizzledViewDidDisappear:));
}

- (void)tt_swizzledViewDidAppear:(BOOL)animated {
    [self tt_swizzledViewDidAppear:animated];
}

- (void)tt_swizzledViewDidDisappear:(BOOL)animated {
    [self tt_swizzledViewDidAppear:animated];
}

+ (void)registerViewDidAppearObserver:(TTViewDidAppearCallback)observer {
    if (!observer) {
        return;
    }

    if (!viewDidAppearObservers) {
        viewDidAppearObservers = [NSMutableArray array];
    }
    [viewDidDisappearObservers addObject:observer];
}

+ (void)registerViewDidDisappearObserver:(TTViewDidDisappearCallback)observer {
    if (!observer) {
        return;
    }
    
    if (!viewDidDisappearObservers) {
        viewDidDisappearObservers = [NSMutableArray array];
    }
    [viewDidDisappearObservers addObject:observer];
}

@end
