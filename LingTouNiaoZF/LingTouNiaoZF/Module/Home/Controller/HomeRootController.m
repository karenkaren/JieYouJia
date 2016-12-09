//
//  HomeRootController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "HomeRootController.h"
#import "UserLoginController.h"
#import "BaseNavigationController.h"
#import "BoundBankCardController.h"
#import "MJRefresh.h"

#import "MessageRemindView.h"
#import "RegionSelectView.h"
#import "BannerView.h"
#import "HomeHeaderView.h"
#import "HomeSectionHeaderView.h"

#import "HomeActivityCell.h"
#import "HomeRecommentCell.h"
#import "HomeApartmentCell.h"

#import "RecommendBanner.h"

#define kHomeActivityCell @"HomeActivityCell"
#define kHomeRecommentCell @"HomeRecommentCell"
#define kHomeApartmentCell @"HomeApartmentCell"

#import "HomeModel.h"
#import "SortModel.h"
#import "RecommendBanner.h"
#import "ApartmentModel.h"

@interface HomeRootController ()<UITableViewDataSource, UITableViewDelegate, HomeSectionHeaderViewDelegate, BaseBannerCellDelegate>

@property (nonatomic, strong) MessageRemindView * messageRemindView;
@property (nonatomic, strong) HomeHeaderView * homeHeaderView;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * data;
@property (nonatomic, strong) HomeModel * homeModel;
@property (nonatomic, strong) NSArray * sortList;

@end

@implementation HomeRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"捷友家";
    self.homeModel = [[HomeModel alloc] init];
    self.data = [NSMutableArray array];
    [self initTableView];
    [self getInitialData];
    [self initNavigationBar];
    [self initHeader];
    [self initFooterView];
    [self registerCells];
    
//    UIButton * button = [UIButton createButtonWithTitle:@"登录" color:[UIColor blackColor] font:kFont18 block:^(UIButton *button) {
//        UserLoginController * vc = [[UserLoginController alloc] init];
//        BaseNavigationController * nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
//        [self presentViewController:nav animated:YES completion:nil];
//         }];
//    button.left = 100;
//    button.top = 100;
//    [self.view addSubview:button];
}

#pragma mark - 初始化
- (void)initNavigationBar
{
    self.messageRemindView = [[MessageRemindView alloc] initWithFrame:CGRectMake(0, 0, kGeneralSize, kGeneralSize) iconName:@"tixing" target:self action:@selector(clickMessage)];
    self.messageRemindView.showMessageRemind = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.messageRemindView];
    
    RegionSelectView * regionSelect = [RegionSelectView createRegionSelectViewWithFrame:CGRectMake(0, 0, 90, 44) actionBlock:^(UIButton *button) {
        DLog(@"选择区域");
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:regionSelect];
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - kNavigationBarHeight - kStatusBarHeight - 49) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getInitialData)];
    
    // Enter the refresh status immediately
//    [self.tableView.mj_header beginRefreshing];
}

- (void)initHeader
{
    self.homeHeaderView = [[HomeHeaderView alloc] init];
    self.tableView.tableHeaderView = self.homeHeaderView;
}

- (void)initFooterView
{
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kAdaptiveBaseIphone6(87))];
    UIButton * footerButton = [CustomButton createMiddleBorderButtonWithTitle:@"业主将房屋委托给捷友家" actionBolck:^(UIButton *button) {
        DLog(@"业主将房屋委托给捷友家");
        
        UserLoginController * vc = [[UserLoginController alloc] init];
        BaseNavigationController * nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
        
    }];
    [footerView addSubview:footerButton];
    [footerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kAdaptiveBaseIphone6(8)));
        make.centerX.equalTo(footerView);
    }];
    
    self.tableView.tableFooterView = footerView;
}

- (void)registerCells
{
    [self.tableView registerClass:[HomeActivityCell class] forCellReuseIdentifier:kHomeActivityCell];
    [self.tableView registerClass:[HomeRecommentCell class] forCellReuseIdentifier:kHomeRecommentCell];
    [self.tableView registerClass:[HomeApartmentCell class] forCellReuseIdentifier:kHomeApartmentCell];
}

#pragma mark - 数据加载
- (void)getInitialData
{
    [SortModel getAppFloorListWithBlock:^(id response, NSArray *sortList, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        self.sortList = sortList;
        [self getNewData];
    }];
}
- (void)getNewData
{
    if (!self.sortList.count) {
        return;
    }
    
    for (SortModel * sortModel in self.sortList) {
        if ([sortModel.code isEqualToString:kActivity]) {
            [Banner getActivityListWithBlock:^(id response, NSArray *activityList, NSError *error) {
                self.homeModel.activityDic = @{kSortNo : @(sortModel.sortNo), kData : activityList};;
                [self reloadTableView];
            }];
        } else if ([sortModel.code isEqualToString:kRecommend]) {
            [RecommendBanner getRecommendListWithBlock:^(id response, NSArray *recommendList, NSError *error) {
                self.homeModel.recommendDic = @{kSortNo : @(sortModel.sortNo), kData : recommendList};
                [self reloadTableView];
            }];
        }else if ([sortModel.code isEqualToString:kBrand]) {
            [ApartmentModel getApartmentListWithBlock:^(id response, NSArray *apartmentList, NSError *error) {
                self.homeModel.apartmentDic = @{kSortNo : @(sortModel.sortNo), kData : apartmentList};
                [self reloadTableView];
            }];
        }
    }
    
    [Banner getBannerListWithBlock:^(id response, NSArray *bannerList, NSError *error) {
        [self.homeHeaderView refreshWithBannerList:bannerList];
    }];
}

- (void)initData
{
    [self.data removeAllObjects];
    
    NSMutableArray * dataArray = [NSMutableArray array];
    if (self.homeModel.activityDic) {
        NSDictionary * dic1 = @{@"title" : @"精彩活动",
                 @"titleDetail" : @"更多",
                 @"class" : [HomeActivityCell class],
                 @"value" : self.homeModel.activityDic[kData],
                 @"height" : @(kHomeActivityCellHeight),
                 @"sel" : @"",
                 kSortNo : self.homeModel.activityDic[kSortNo]};
        [dataArray addObject:dic1];
    }
    
    if (self.homeModel.recommendDic) {
        NSDictionary * dic2 = @{@"title" : @"推荐房源",
                 @"titleDetail" : @"更多",
                 @"class" : [HomeRecommentCell class],
                 @"value" : self.homeModel.recommendDic[kData],
                 @"height" : @(kHomeRecommentCellHeight),
                 @"sel" : @"",
                 kSortNo : self.homeModel.recommendDic[kSortNo]};
        [dataArray addObject:dic2];
    }
    
    if (self.homeModel.apartmentDic) {
        NSDictionary * dic3 = @{@"title" : @"精品公寓",
                                @"titleDetail" : @"更多",
                                @"class" : [HomeApartmentCell class],
                                @"value" : self.homeModel.apartmentDic[kData],
                                @"height" : @(kHomeApartmentCellHeight),
                                @"sel" : @"goToApartmentDetail:",
                                kSortNo : self.homeModel.apartmentDic[kSortNo]};
        [dataArray addObject:dic3];
    }
    
    [dataArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSInteger sortNo1 = [obj1[kSortNo] integerValue];
        NSInteger sortNo2 = [obj2[kSortNo] integerValue];
        if (sortNo1 > sortNo2) {
            return (NSComparisonResult)NSOrderedDescending;
        } else if (sortNo1 < sortNo2){
            return (NSComparisonResult)NSOrderedAscending;
        } else {
            return (NSComparisonResult)NSOrderedSame;
        }
    }];
    
    if (dataArray.count) {
        [self.data addObjectsFromArray:dataArray];
    }
}

- (void)reloadTableView
{
    [self initData];
    [self.tableView reloadData];
}

#pragma mark - table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary * dataDictionary = self.data[section];
    Class cellClass = dataDictionary[@"class"];
    if (cellClass == [HomeApartmentCell class]) {
        id value = dataDictionary[@"value"];
        if (isArray(value)) {
            NSArray * data = (NSArray *)value;
            return data.count;
        }
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dataDictionary = self.data[indexPath.section];
    Class cellClass = dataDictionary[@"class"];
    if (cellClass == [HomeActivityCell class]) {
        return [self getActivityCellWithIndexPath:indexPath];
    } else if (cellClass == [HomeRecommentCell class]) {
        return [self getRecommentCellWithIndexPath:indexPath];
    } else if (cellClass == [HomeApartmentCell class]) {
        return [self getApartmentCellWithIndexPath:indexPath];
    }
    return nil;
}

#pragma mark - 获取不同cell
- (UITableViewCell *)getActivityCellWithIndexPath:(NSIndexPath *)indexPath
{
    HomeActivityCell * cell = [self.tableView dequeueReusableCellWithIdentifier:kHomeActivityCell];
    cell.delegate = self;
    id value = self.data[indexPath.section][@"value"];
    if (isArray(value)) {
        NSArray * datas = (NSArray *)value;
        cell.data = datas;
    }
    return cell;
}

- (UITableViewCell *)getRecommentCellWithIndexPath:(NSIndexPath *)indexPath
{
    HomeRecommentCell * cell = [self.tableView dequeueReusableCellWithIdentifier:kHomeRecommentCell];
    cell.delegate = self;
    id value = self.data[indexPath.section][@"value"];
    if (isArray(value)) {
        NSArray * datas = (NSArray *)value;
        cell.data = datas;
    }
    return cell;
}

- (UITableViewCell *)getApartmentCellWithIndexPath:(NSIndexPath *)indexPath
{
    HomeApartmentCell * cell = [self.tableView dequeueReusableCellWithIdentifier:kHomeApartmentCell];
    id value = self.data[indexPath.section][@"value"];
    if (isArray(value)) {
        NSArray * datas = (NSArray *)value;
        cell.data = datas[indexPath.row];
    }
    return cell;
}

#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [self.data[indexPath.section][@"height"] floatValue];
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kSectionHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary * dataDictionary = self.data[section];
    Class cellClass = dataDictionary[@"class"];

    HomeSectionHeaderView * homeSectionHeader = [HomeSectionHeaderView getHomeSectionHeaderViewWithTitle:[self.data[section] valueForKey:@"title"] titleDetail:[self.data[section] valueForKey:@"titleDetail"]];
    homeSectionHeader.delegate = self;
    homeSectionHeader.classString = NSStringFromClass(cellClass);
    return homeSectionHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * selName = [self.data[indexPath.section] valueForKey:@"sel"];
    SEL action = NSSelectorFromString(selName);
    if (action && [self respondsToSelector:action]) {
        [self performSelector:action withObject:indexPath afterDelay:0];
    }
}

#pragma mark - private methods
#pragma mark -- 点击消息中心方法
- (void)clickMessage
{
    self.messageRemindView.messageCount = 0;
    DLog(@"消息");
    BoundBankCardController * boundBankCardController = [[BoundBankCardController alloc] init];
    boundBankCardController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:boundBankCardController animated:YES];
}

#pragma mark -- 公寓详情
- (void)goToApartmentDetail:(NSIndexPath *)indexPath
{
    
}

#pragma mark - other delegate

// banner delegate
- (void)clickBannerView:(BannerView *)bannerView banner:(Banner *)banner
{
    
}

// 点击section header代理方法
- (void)showMore:(HomeSectionHeaderView *)sectionHeaderView
{
    Class sectionClass = NSClassFromString(sectionHeaderView.classString);
    if ([sectionClass isSubclassOfClass:[HomeActivityCell class]]) {
        DLog(@"精彩活动");
    }  else if ([sectionClass isSubclassOfClass:[HomeRecommentCell class]]) {
        DLog(@"推荐房源");
    } else if ([sectionClass isSubclassOfClass:[HomeApartmentCell class]]) {
        DLog(@"精品公寓");
    } else {
        
    }
}

@end
