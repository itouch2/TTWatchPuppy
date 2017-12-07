//
//  NSNotificationCenter+TTWatch.h
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/3.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TTAddObserverCallback)(id observer, SEL selector, NSNotificationName name, id object);
typedef void(^TTRemoveObserverCallback)(id notificationObserver);

@interface NSNotificationCenter (TTWatch)

+ (void)registerAddObserverCallback:(TTAddObserverCallback)callback;
+ (void)registerRemoveObserverCallback:(TTRemoveObserverCallback)callback;

@end
