//
//  UIViewController+TTHook.h
//  TTWatchPuppy
//
//  Created by You Tu on 2016/12/10.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TTViewDidAppearCallback)(BOOL animated);
typedef void(^TTViewDidDisappearCallback)(BOOL animated);

@interface UIViewController (TTHook)

+ (void)registerViewDidAppearObserver:(TTViewDidAppearCallback)observer;
+ (void)registerViewDidDisappearObserver:(TTViewDidDisappearCallback)observer;


@end
