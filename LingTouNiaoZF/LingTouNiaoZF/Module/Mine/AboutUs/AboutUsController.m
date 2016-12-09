//
//  AboutUsController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "AboutUsController.h"

@interface AboutUsController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * OriginalData;

@end

@implementation AboutUsController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"关于我们";
    [self showCloseButton];
    [self initTableView];
    [self initHeaderAndFooterView];
    [self initData];
}

- (void)initHeaderAndFooterView
{
    CGFloat rate = 400.0 / 1080;
    UIImageView * logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * rate)];
    logoImageView.image = [UIImage imageNamed:@"logo"];
    self.tableView.tableHeaderView = logoImageView;
    
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    versionLabel.font = [CustomFont heiti:13.0f];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.textColor = kHexColor(0x8a8a8a);
    versionLabel.text = [NSString stringWithFormat:@"当前版本号：V%@", [GlobalManager appVersion]];
    self.tableView.tableFooterView = versionLabel;
}

- (void)initData
{
    self.OriginalData = @[
                           @[
                               @{
                                   @"title" : @"意见反馈",
                                   @"image" : @"icon_opinion",
                                   @"sel" : @"feedback",
                                   },
                               @{
                                   @"title" : @"去评分",
                                   @"image" : @"icon_score",
                                   @"sel" : @"rating",
                                   },
                               ],
                           @[
                               @{
                                   @"title" : @"关于捷友家",
                                   @"image" : @"icon_about_ltn",
                                   @"sel" : @"aboutLTN",
                                   },
                               @{
                                   @"title" : @"欢迎页",
                                   @"image" : @"icon_welcomePage",
                                   @"sel" : @"welcomeLTN",
                                   },
                               @{
                                   @"title" : @"客服电话",
                                   @"image" : @"icon_phone",
                                   @"sel" : @"callServicePhone:",
                                   @"detail":@"400-999-9980"
                                   },
                               @{
                                   @"title" : @"分享给好友",
                                   @"image" : @"icon_share",
                                   @"sel" : @"shareToFriends",
                                   }
                               ],
                           ];
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = kHexColor(0xcccccc);
    self.tableView.sectionFooterHeight = 0;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.OriginalData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.OriginalData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * CellIdentifier = NSStringFromClass([self class]);
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = kFont(16);
        cell.textLabel.textColor = kHexColor(0x3a3a3a);
        cell.detailTextLabel.font = kFont(14);
        cell.detailTextLabel.textColor = kHexColor(0x8a8a8a);
    }
    
    NSArray * descriptionArray = self.OriginalData[indexPath.section];
    cell.textLabel.text = descriptionArray[indexPath.row][@"title"];
    cell.imageView.image = [UIImage imageNamed:descriptionArray[indexPath.row][@"image"]];
    cell.detailTextLabel.text = descriptionArray[indexPath.row][@"detail"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 10;
    if (section == 0) {
        height = 0;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * dic = self.OriginalData[indexPath.section][indexPath.row];
    NSString * selName = dic[@"sel"];
    SEL action = NSSelectorFromString(selName);
    if ([self respondsToSelector:action]) {
        [self performSelector:action withObject:dic[@"detail"] afterDelay:0];
    }
}

@end
