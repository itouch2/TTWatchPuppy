//
//  TTBarkingDot.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/3.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "TTBarkingDot.h"

static CGFloat kBarkingDotRadius = 40;

@interface TTBarkingDot ()

@property (nonatomic, copy) dispatch_block_t tapBlock;
@property (nonatomic, strong) UILabel *countLabel;

@end


@implementation TTBarkingDot

- (instancetype)initWithTapBlock:(dispatch_block_t)tapBlock {
    self = [super initWithFrame:CGRectMake(0, 0, kBarkingDotRadius, kBarkingDotRadius)];
    if (self) {
        _tapBlock = tapBlock;
        
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor colorWithRed:0.18 green:0.18 blue:0.18 alpha:1.00];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = kBarkingDotRadius / 2;
    
    [self addSubview:self.countLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tap];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.countLabel.frame = self.bounds;
}

- (void)setCount:(NSInteger)count {
    _count = count;
    self.countLabel.text = [NSString stringWithFormat:@"%@", @(_count)];
}

- (void)tapped:(UITapGestureRecognizer *)gestureRecognizer {
    if (self.tapBlock) {
        self.tapBlock();
    }
}

- (void)show {
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 1;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    }];
}

#pragma mark - Getters

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _countLabel.backgroundColor = [UIColor clearColor];
        _countLabel.textColor = [UIColor colorWithRed:0.43 green:0.65 blue:0.87 alpha:1.00];
        _countLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
        _countLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countLabel;
}

@end
