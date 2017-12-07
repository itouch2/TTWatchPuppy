//
//  TTBarkingCenter.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/10/30.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "TTBarkingCenter.h"
#import "TTBarkingUI.h"
#import "TTBarkingDot.h"
#import "TTBarkingListViewController.h"

static TTBarkingCenter *barking = nil;

@interface TTBarkingCenter ()

@property (nonatomic, strong) TTBarkingUI *barkingUI;
@property (nonatomic, strong) TTBarkingDot *barkingDot;
@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) NSMutableArray<TTBarkingInfo *> *barkingList;
@property (nonatomic, strong) NSMutableArray<TTBarkingInfo *> *pendingList;
@property (nonatomic, assign) BOOL isBarking;

@end


@implementation TTBarkingCenter

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        barking = [[TTBarkingCenter alloc] init];
    });
    return barking;
}

- (void)barking:(TTBarkingInfo *)barkingInfo {
    dispatch_async(dispatch_get_main_queue(), ^{
        TTBarkingInfo *barkingInfoCopy = [barkingInfo copy];
        // add it to the pending queue
        [self.pendingList addObject:barkingInfoCopy];
        
        [self handlePendingList];
    });
}

#pragma mark - Private Method

- (void)handlePendingList {
    
    if (self.isBarking) {
        return;
    }
        
    TTBarkingInfo *barkingInfo = [self.pendingList firstObject];
    if (!barkingInfo) {
        return;
    }

    [self.barkingUI barking:barkingInfo];
    self.isBarking = YES;
    
    [self.pendingList removeObjectAtIndex:0];
    [self.barkingList insertObject:barkingInfo atIndex:0];
    
    if (self.barkingList.count) {
        self.barkingDot.count = self.barkingList.count;
    }
}

- (void)presentBarkingList {
    TTBarkingListViewController *barkingListViewController = [[TTBarkingListViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:barkingListViewController];
    navigationController.navigationBar.barStyle = UIBarStyleBlack;
    barkingListViewController.willDismissBlock = ^() {
        [self.barkingDot show];
    };
    
    [self.window.rootViewController presentViewController:navigationController animated:YES completion:^{
        [self.barkingDot dismiss];
    }];
}

#pragma mark - Getters

- (NSArray<TTBarkingInfo *> *)list {
    return [self.barkingList copy];
}

- (TTBarkingDot *)barkingDot {
    if (!_barkingDot) {
        __weak typeof(self) weakSelf = self;
        _barkingDot = [[TTBarkingDot alloc] initWithTapBlock:^{
            [weakSelf presentBarkingList];
        }];
        _barkingDot.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 60,
                                         [UIScreen mainScreen].bounds.size.height - 60);
       [self.window addSubview:_barkingDot];
    }
    return _barkingDot;
}

- (TTBarkingUI *)barkingUI {
    if (!_barkingUI) {
        __weak typeof(self) weakSelf = self;
        _barkingUI = [[TTBarkingUI alloc] init];
        _barkingUI.finishedBlock = ^() {
            weakSelf.isBarking = NO;
            [weakSelf handlePendingList];
        };
    }
    return _barkingUI;
}

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIApplication sharedApplication].delegate window];
    }
    return _window;
}

- (NSMutableArray<TTBarkingInfo *> *)barkingList {
    if (!_barkingList) {
        _barkingList = [NSMutableArray array];
    }
    return _barkingList;
}

- (NSMutableArray<TTBarkingInfo *> *)pendingList {
    if (!_pendingList) {
        _pendingList = [NSMutableArray array];
    }
    return _pendingList;
}

@end
