//
//  TTBarkingDetailViewController.h
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/3.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBarkingInfo.h"

@interface TTBarkingDetailViewController : UIViewController

- (instancetype)initWithBarkingInfo:(TTBarkingInfo *)barkingInfo;

- (void)present;
- (void)push;

@end
