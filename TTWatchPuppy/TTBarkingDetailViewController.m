//
//  TTBarkingDetailViewController.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/3.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "TTBarkingDetailViewController.h"

@interface TTBarkingDetailViewController ()

@property (nonatomic, strong) TTBarkingInfo *barkingInfo;
@property (nonatomic, strong) UITextView *infoTextView;

@end

@implementation TTBarkingDetailViewController

- (instancetype)initWithBarkingInfo:(TTBarkingInfo *)barkingInfo {
    self = [super init];
    if (self) {
        _barkingInfo = barkingInfo;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = self.barkingInfo.title;
    
    self.infoTextView = [[UITextView alloc] initWithFrame:self.view.bounds textContainer:nil];
    self.infoTextView.text = self.barkingInfo.snapshot.callStackSymbols.description;
    [self.view addSubview:self.infoTextView];
}

- (void)present {
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped:)];
    self.navigationItem.leftBarButtonItem = barItem;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self];
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window.rootViewController presentViewController:navigationController animated:YES completion:NULL];
}

- (void)push {
    [self.navigationController pushViewController:self animated:YES];
}

- (void)backBtnTapped:(id)sender {
    
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    }
}

@end
