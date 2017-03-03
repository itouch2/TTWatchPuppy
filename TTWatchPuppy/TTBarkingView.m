//
//  TTBarkingView.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/8.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "TTBarkingView.h"
#import "TTBarkingHeader.h"

@interface TTBarkingAlertView ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *detailButton;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, assign) BOOL isAnimating;

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end


@implementation TTBarkingAlertView


- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, 300, 300)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4;
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    _backgroundView = backgroundView;
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.frame), 30)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.font = [UIFont systemFontOfSize:18];
    titleLable.textColor = [UIColor blackColor];
    [self addSubview:titleLable];
    _titleLabel = titleLable;
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 70, CGRectGetWidth(self.frame) - 80, 100)];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.font = [UIFont systemFontOfSize:16];
    detailLabel.textColor = [UIColor darkGrayColor];
    detailLabel.numberOfLines = 5;
    [self addSubview:detailLabel];
    _detailLabel = detailLabel;
    
    UIButton *detailButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 60, CGRectGetWidth(self.frame), 40)];
    [detailButton setTitle:@"What The Fuck" forState:UIControlStateNormal];
    [detailButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [detailButton addTarget:self
                     action:@selector(detailButtonTapped:)
           forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:detailButton];
    _detailButton = detailButton;
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [closeButton addTarget:self
                    action:@selector(closeButtonTapped:)
          forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
    _closeButton = closeButton;
}

- (void)setBarkingInfo:(TTBarkingInfo *)barkingInfo {
    _barkingInfo = barkingInfo;
    
    self.titleLabel.text = barkingInfo.title;
    self.detailLabel.text = barkingInfo.desc;
}

- (void)detailButtonTapped:(id)sender {
    if (self.detailBlock) {
        self.detailBlock();
    }
    [self dismiss];
}

- (void)closeButtonTapped:(id)sender {
    [self dismiss];
}

- (void)showInView:(UIView *)view {
    if (self.isAnimating || self.superview == view) {
        return;
    }
    
    self.transform = CGAffineTransformMakeRotation(M_PI_4 / 2);
    self.center = CGPointMake(TTScreenWidth / 2, TTScreenHeight / 2  - TTScreenHeight / 1.5);
    
    [view addSubview:self.backgroundView];
    [view addSubview:self];
    
    // animate to show
    self.isAnimating = YES;
    [UIView animateWithDuration:0.9
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:1.2
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundView.alpha = 1;
                         self.transform = CGAffineTransformIdentity;
                         self.center = CGPointMake(TTScreenWidth / 2, TTScreenHeight / 2 - 100);
    } completion:^(BOOL finished) {
        self.isAnimating = NO;
    }];
    
}

- (void)dismiss {
    if (self.isAnimating || !self.superview) {
        return;
    }
    
    // animate to dismiss
    self.isAnimating = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.center = CGPointMake(TTScreenWidth / 2, TTScreenHeight + 200);
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        self.isAnimating = NO;
        
        [self removeFromSuperview];
        [self.backgroundView removeFromSuperview];
        
        if (self.dismissBlock) {
            self.dismissBlock();
        }
    }];
}


@end

@interface TTBarkingToastView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, assign) CGPoint originCenter;

@end


@implementation TTBarkingToastView

- (instancetype)init
{
    return [self initWithFrame:CGRectMake(20, 0, TTScreenWidth - 40, 90)];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.originCenter = CGPointMake(TTScreenWidth / 2, 100);
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4;
    
    self.backgroundColor = [UIColor colorWithRed:0.18 green:0.18 blue:0.18 alpha:1.00];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(18, 10, TTScreenWidth - 36, 35)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.font = [UIFont systemFontOfSize:18];
    titleLable.textColor = [UIColor colorWithRed:0.43 green:0.65 blue:0.87 alpha:1.00];
    titleLable.textAlignment = NSTextAlignmentLeft;
    titleLable.numberOfLines = 1;
    [self addSubview:titleLable];
    _titleLabel = titleLable;
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 35, TTScreenWidth - 76, 55)];
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.font = [UIFont systemFontOfSize:16];
    detailLabel.textColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00];
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.numberOfLines = 2;
    [self addSubview:detailLabel];
    _detailLabel = detailLabel;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    [self addGestureRecognizer:pan];
}

- (void)setBarkingInfo:(TTBarkingInfo *)barkingInfo {
    _barkingInfo = barkingInfo;
    
    self.titleLabel.text = barkingInfo.title;
    self.detailLabel.text = barkingInfo.desc;
}

- (void)showInView:(UIView *)view {
    if (self.isAnimating || self.superview == view) {
        return;
    }
    
    self.center = CGPointMake(TTScreenWidth / 2, -50);
    [view addSubview:self];

    // animate to show
    self.isAnimating = YES;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 1;
        self.center = CGPointMake(TTScreenWidth / 2, 100);
    } completion:^(BOOL finished) {
        self.isAnimating = NO;
    }];
    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:5];
}

- (void)dismiss {
    if (self.isAnimating || !self.superview) {
        return;
    }

    // animate to dismiss
    self.isAnimating = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.isAnimating = NO;
        
        [self removeFromSuperview];
        if (self.dismissBlock) {
            self.dismissBlock();
        }
    }];
}

- (void)tapped:(UIGestureRecognizer *)gestureRecognizer {
    if (self.detailBlock) {
        self.detailBlock();
    }
    [self dismiss];
}

- (void)panned:(UIPanGestureRecognizer *)gestureRecognizer {
    UIGestureRecognizerState state = gestureRecognizer.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint point = [gestureRecognizer translationInView:self];
            self.center = CGPointMake(self.originCenter.x, self.originCenter.y + point.y);
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            if (self.originCenter.y - self.center.y > 50) {
                [self dismiss];
            } else {
                // restore position
                [UIView animateWithDuration:0.1 animations:^{
                    self.center = self.originCenter;
                }];
            }
            break;
        }
        default:
            break;
    }
}

@end
