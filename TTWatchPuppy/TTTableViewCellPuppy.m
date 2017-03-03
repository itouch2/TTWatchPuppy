//
//  TTTableViewCellPuppy.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/3.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "TTTableViewCellPuppy.h"
#import "UIView+TTWatch.h"

@interface TTTableViewCellPuppy ()

@end


@implementation TTTableViewCellPuppy

- (void)prepare {
    __weak typeof(self) weakSelf = self;
    [UIView registerCellAddSubviewObserver:^(UIView *view) {
        [weakSelf smell];
    }];
}

- (void)smell {
    // Subview should be added to Cell's contentView
    
    NSString *title = @"TableView Cell Add Subview";
    NSString *desc = @"It's better not do that.";
    TTBarkingInfo *barkingInfo = [[TTBarkingInfo alloc] initWithTitle:title description:desc];
    [self barking:barkingInfo];
}

@end
