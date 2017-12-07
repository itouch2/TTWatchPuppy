//
//  TTBarkingCenter.h
//  TTWatchPuppy
//
//  Created by You Tu on 2016/10/30.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTBarkingInfo.h"
#import "TTBarkingUI.h"

@interface TTBarkingCenter : NSObject

@property (nonatomic, strong, readonly) NSArray<TTBarkingInfo *> *list;

+ (instancetype)sharedInstance;
- (void)barking:(TTBarkingInfo *)barkingInfo;

@end
