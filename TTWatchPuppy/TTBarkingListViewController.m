//
//  TTBarkingListViewController.m
//  TTWatchPuppy
//
//  Created by You Tu on 2016/11/3.
//  Copyright © 2016年 You Tu. All rights reserved.
//

#import "TTBarkingListViewController.h"
#import "TTBarkingDetailViewController.h"
#import "TTBarkingCenter.m"

@interface TTBarkingListCell : UITableViewCell

@property (nonatomic, strong) TTBarkingInfo *barkingInfo;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation TTBarkingListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 14, TTScreenWidth - 36, 24)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:22];
        titleLabel.textColor = [UIColor colorWithRed:0.43 green:0.65 blue:0.87 alpha:1.00];
        titleLabel.numberOfLines = 1;
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 38, TTScreenWidth - 36, 30)];
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.font = [UIFont systemFontOfSize:18];
        detailLabel.textColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00];
        detailLabel.numberOfLines = 2;
        [self.contentView addSubview:detailLabel];
        _detailLabel = detailLabel;
    }
    return self;
}

- (void)setBarkingInfo:(TTBarkingInfo *)barkingInfo {
    _barkingInfo = barkingInfo;
    
    _titleLabel.text = barkingInfo.title;
    _detailLabel.text = barkingInfo.desc;
}

@end


@interface TTBarkingListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<TTBarkingInfo *> *list;

@end

@implementation TTBarkingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Barking...";
    self.view.backgroundColor = [UIColor colorWithRed:0.18 green:0.18 blue:0.18 alpha:1.00];
    
    [self setupSubviews];
    
    // set data source
    self.list = [TTBarkingCenter sharedInstance].list;
    // reload table view
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
    }
}

- (void)setupSubviews {
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnTapped:)];
    self.navigationItem.leftBarButtonItem = barItem;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1.00];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
}

- (void)backBtnTapped:(id)sender {
    if (self.willDismissBlock) {
        self.willDismissBlock();
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const BarkingTableViewCellIdentifier = @"BarkingListCell";
    TTBarkingListCell *cell = [tableView dequeueReusableCellWithIdentifier:BarkingTableViewCellIdentifier];
    if (!cell) {
        cell = [[TTBarkingListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BarkingTableViewCellIdentifier];
    }
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[TTBarkingListCell class]]) {
        ((TTBarkingListCell *)cell).barkingInfo = [self.list objectAtIndex:indexPath.row];
    }
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Go to barking info detail
    TTBarkingInfo *barkingInfo = [self.list objectAtIndex:indexPath.row];
    TTBarkingDetailViewController *barkingDetailViewController = [[TTBarkingDetailViewController alloc] initWithBarkingInfo:barkingInfo];
    [self.navigationController pushViewController:barkingDetailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


@end
