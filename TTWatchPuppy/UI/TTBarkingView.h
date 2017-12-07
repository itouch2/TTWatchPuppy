//
//  TTBarkingView.h
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/8.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBarkingInfo.h"

@protocol TTBarkingAlertViewProtocol <NSObject>

@optional
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *detailLabel;

@property (nonatomic, strong) TTBarkingInfo *barkingInfo;
@property (nonatomic, copy) dispatch_block_t detailBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;


- (void)showInView:(UIView *)view;
- (void)dismiss;

@end

@interface TTBarkingAlertView : UIView<TTBarkingAlertViewProtocol>

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *detailLabel;

@property (nonatomic, strong) TTBarkingInfo *barkingInfo;

@property (nonatomic, copy) dispatch_block_t detailBlock;
@property (nonatomic, copy) dispatch_block_t closeBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;

- (void)showInView:(UIView *)view;
- (void)dismiss;

@end

@interface TTBarkingToastView : UIView<TTBarkingAlertViewProtocol>

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *detailLabel;

@property (nonatomic, strong) TTBarkingInfo *barkingInfo;

@property (nonatomic, copy) dispatch_block_t detailBlock;
@property (nonatomic, copy) dispatch_block_t tapBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;

- (void)showInView:(UIView *)view;
- (void)dismiss;

@end
