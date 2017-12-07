//
//  NSObject+TTHook.h
//  TTWatchPuppy
//
//  Created by You Tu on 2016/10/30.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

inline static void tt_swizzleInstanceSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(theClass,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(theClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@interface NSObject (TTHook)

- (void)tt_registerDeallocCallback:(dispatch_block_t)callback;

@end
