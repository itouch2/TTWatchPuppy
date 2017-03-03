//
//  ViewController.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/10/30.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+TTHook.h"
#import "TTUIThreadPuppy.h"
#import "TTBarkingUI.h"
#import "TTBarkingView.h"


@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) TTBarkingUI *barkingUI;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testUI];
    [self testUIException];
    [self testNotification];
    
    return;
}

- (IBAction)btnTapped:(id)sender {

    NSString *title = @"Title";
    NSString *desc = @"This is description, blah blah blah. This is description, blah blah blah. This is description, blah blah blah. This is description, blah blah blah. This is description, blah blah blah";
    TTBarkingInfo *barkingInfo = [[TTBarkingInfo alloc] initWithTitle:title description:desc];
    
    static int count = 0;
    count++;
    if (count % 2 == 1) {
        barkingInfo.style = TTBarkingViewStyleToast;
    } else {
        barkingInfo.style = TTBarkingViewStyleAlert;
    }
    [[TTBarkingCenter sharedInstance] barking:barkingInfo];
}

- (void)testUI {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [self.view addSubview:view];
    });
}

- (void)testUIException {
    UIView *view = [[UIView alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:40]];
    
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:view
//                                                     attribute:NSLayoutAttributeHeight
//                                                     relatedBy:NSLayoutRelationEqual
//                                                        toItem:nil
//                                                     attribute:NSLayoutAttributeNotAnAttribute
//                                                    multiplier:1
//                                                      constant:50]];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1
                                                      constant:50]];
}

- (void)testNotification {
    static NSString *const kNotificationName = @"testNotificationName";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:kNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:kNotificationName object:nil];
}

- (void)receiveNotification:(id)object {
    
}

@end
