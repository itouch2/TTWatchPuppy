//
//  TTBarkingUI.h
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/2.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTBarkingInfo.h"
#import "TTBarkingHeader.h"

@interface TTBarkingUI : NSObject

@property (nonatomic, copy) dispatch_block_t finishedBlock;
@property (nonatomic, assign) int test;

- (void)barking:(TTBarkingInfo *)barkingInfo;

@end
