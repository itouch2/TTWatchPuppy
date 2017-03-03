//
//  NSObject+TTAutoLayout.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/12/8.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "NSObject+TTAutoLayout.h"
#import "NSObject+TTHook.h"

static NSMutableArray<dispatch_block_t> *unsatisfiableAutoLayoutBlock = nil;

@implementation NSObject (TTAutoLayout)

+ (void)hookAutoLayoutException {
    Class theClass = objc_getClass("NSISEngine");
    SEL originalSelector = @selector(handleUnsatisfiableRowWithHead:body:usingInfeasibilityHandlingBehavior:mutuallyExclusiveConstraints:);
    SEL swizzledSelector = @selector(ex_handleUnsatisfiableRowWithHead:body:usingInfeasibilityHandlingBehavior:mutuallyExclusiveConstraints:);
    tt_swizzleInstanceSelector(theClass, originalSelector, swizzledSelector);
}

+ (void)registerUnsatisfiableAutoLayoutBlock:(dispatch_block_t)block {
    if (!block) {
        return;
    }

    if (!unsatisfiableAutoLayoutBlock) {
        unsatisfiableAutoLayoutBlock = [NSMutableArray array];
    }

    [unsatisfiableAutoLayoutBlock addObject:block];
}

- (void)ex_handleUnsatisfiableRowWithHead:(id)head
                                     body:(id)body
       usingInfeasibilityHandlingBehavior:(id)behavior
             mutuallyExclusiveConstraints:(BOOL)constraints {
    
    [unsatisfiableAutoLayoutBlock enumerateObjectsUsingBlock:^(dispatch_block_t  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj();
    }];

    [self ex_handleUnsatisfiableRowWithHead:head
                                       body:body
         usingInfeasibilityHandlingBehavior:behavior
               mutuallyExclusiveConstraints:constraints];
}


@end
