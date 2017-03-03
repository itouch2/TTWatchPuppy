//
//  TTUIExceptionPuppy.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/3.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "TTUIExceptionPuppy.h"
#import "NSObject+TTAutoLayout.h"

@implementation TTUIExceptionPuppy

- (void)prepare {
    [NSObject registerUnsatisfiableAutoLayoutBlock:^{
        [self smell];
    }];
}

- (void)smell {
    // alert the unsatisfiable auto layout exception
    NSString *title = @"Unsatisfiable auto layout exception";
    NSString *desc = @"You can try add an symbolic breakpoint";
    TTBarkingInfo *barkingInfo = [[TTBarkingInfo alloc] initWithTitle:title description:desc];
    [[TTBarkingCenter sharedInstance] barking:barkingInfo];
}

@end
