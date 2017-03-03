//
//  TTBarkingUI.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/2.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "TTBarkingUI.h"
#import <UIKit/UIKit.h>
#import "TTBarkingView.h"
#import "TTBarkingDetailViewController.h"

@interface TTBarkingUI ()

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) TTBarkingAlertView *alertView;
@property (nonatomic, strong) TTBarkingToastView *toastView;

@end

@implementation TTBarkingUI

- (void)barking:(TTBarkingInfo *)barkingInfo {
    UIView<TTBarkingAlertViewProtocol> *barkingView = nil;;
    switch (barkingInfo.style) {
        case TTBarkingViewStyleToast:
            barkingView = self.toastView;
            break;
        case TTBarkingViewStyleAlert:
            barkingView = self.alertView;
            break;
        default:
            break;
    }
    barkingView.barkingInfo = barkingInfo;
    
    __weak typeof(self) weakSelf = self;
    barkingView.detailBlock = ^(void) {
        TTBarkingDetailViewController *detailViewController = [[TTBarkingDetailViewController alloc] initWithBarkingInfo:barkingInfo];
        [detailViewController present];
    };
    barkingView.dismissBlock = ^(void) {
        if (weakSelf.finishedBlock) {
            weakSelf.finishedBlock();
        }
    };
    
    [barkingView showInView:self.window];
}

- (void)done {
    if (self.finishedBlock) {
        self.finishedBlock();
    }
}

#pragma mark - Getters

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIApplication sharedApplication].delegate window];
    }
    return _window;
}

- (TTBarkingToastView *)toastView {
    if (!_toastView) {
        _toastView = [[TTBarkingToastView alloc] init];
    }
    return _toastView;
}

- (TTBarkingAlertView *)alertView {
    if (!_alertView) {
        _alertView = [[TTBarkingAlertView alloc] init];
    }
    return _alertView;
}

@end
