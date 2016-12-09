//
//  NetAddressSettingController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/26.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "NetAddressSettingController.h"
#import "BaseWebViewController.h"

@interface NetAddressSettingController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UITextField *netAddressField;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray *dataS;

@end

@implementation NetAddressSettingController

- (void)viewDidLoad
{
    [[IQKeyboardManager sharedManager] setEnable:NO];
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//    [self.view addGestureRecognizer:tap];
    
    _dataS = @[@"http://192.168.18.194:8080",@"http://192.168.18.191:29080",@"http://120.55.184.234:8080", @"http://120.55.184.234:8080", @"https://www.lingtouniao.com/v2",@"https://www.lingtouniao.com/v3",@"http://120.55.184.234/v2"];
    [super viewDidLoad];
    self.title = @"设置HOST";
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [_scrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:_scrollView];
    
    CGFloat x = 10;
    self.netAddressField = [self createTextField];
    self.netAddressField.tag = 1000;
    self.netAddressField.frame = CGRectMake(x, 20, kScreenWidth-x*2, 35);
    [_scrollView addSubview:self.netAddressField];
    
    // footer button
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(self.netAddressField.frame) + 15, kScreenWidth - x*2, kGeneralSize)];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
    button.titleLabel.font = kFont(18);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveAddress:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:button];
    
    
//    UILabel *label = [[UILabel alloc] init];
//    label.font = kFont(12);
//    label.textColor = [UIColor blackColor];
//    label.text = @"网页测试";
//    [label sizeToFit];
//    label.top = button.bottom + 20;
//    label.centerX = self.view.myCenterX;
//    UITextField *inputWeb = [[UITextField alloc] init];
//    inputWeb.width = kScreenWidth;
//    inputWeb.height = 40;
//    inputWeb.textColor = [UIColor blackColor];
//    inputWeb.layer.borderWidth = 1;
//    inputWeb.top = label.bottom + 10;
//    inputWeb.delegate = self;
//    inputWeb.tag = 1001;
//    [_scrollView addSubview:label];
//    [_scrollView addSubview:inputWeb];
    
    // 设置默认值
    self.netAddressField.text = API_BASE_URL;
}

- (void)clearAddress {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDefaults_NetAddress];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [NSObject showHudTipStr:@"清除成功"];
    [self exit];
}

- (UITextField *)createTextField
{
    UITextField *titleField = [[UITextField alloc] initWithFrame:CGRectZero];
    titleField.layer.borderColor = [[UIColor colorWithHex:0xd5d5d5 alpha:1.0] CGColor];
    titleField.layer.cornerRadius = 0;
    titleField.layer.borderWidth = 1.0;
    titleField.delegate = self;
    titleField.backgroundColor = [UIColor colorWithHex:0xf4f4f4 alpha:1.0];
    titleField.textColor = [UIColor colorWithHex:0x4b4b4b alpha:1.0];
    titleField.font = kFont(15);
    titleField.background = nil;
    titleField.placeholder = @"服务器地址";
    return titleField;
}

#pragma mark - UITextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
//    if (textField.tag == 1001) {
//        BaseWebViewController *webVC = [[BaseWebViewController alloc] initWithURL:textField.text];
//        [self.navigationController pushViewController:webVC animated:YES];
//    }
    [self.tableView removeFromSuperview];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 1000) {
        if (!_tableView) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(textField.left, textField.bottom, kScreenWidth, 300)];
            _tableView.dataSource = self;
            _tableView.delegate = self;
        }
        [self.view addSubview:_tableView];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1000) {
        [self.tableView removeFromSuperview];
    }
}

#pragma mark - 保存
- (void)saveAddress:(UIButton *)button
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kDefaults_NetAddress];
    NSMutableDictionary *mdic;
    if (dic == nil) {
        mdic = [[NSMutableDictionary alloc] initWithCapacity:0];
    } else {
        mdic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    }
    
    if (![NSString isEmpty:self.netAddressField.text]) {
        mdic[kDefaults_POST_ADDR] = self.netAddressField.text;
    } else {
        [NSObject showHudTipStr:@"WebService 为空"];
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:mdic forKey:kDefaults_NetAddress];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.view endEditing:YES];
    [self exit];
}



- (void)exit {
    
#if (defined(DEBUG) || defined(ADHOC))
    exit(0);
#endif
    
}

#pragma mark - tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _dataS[indexPath.row];
    return cell;
}

- (void)tapGestureAction:(UITapGestureRecognizer *)sender
{
    CGPoint p = [sender locationInView:self.tableView];
    if (!CGRectContainsPoint(self.tableView.bounds, p)) {
        [super performSelector:@selector(tapGestureAction:) withObject:sender afterDelay:0];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.netAddressField.text = _dataS[indexPath.row];
    [self.view endEditing:YES];
    [tableView removeFromSuperview];
}

//- (void)tap:(UITapGestureRecognizer *)recognizer
//{
//    [self.view endEditing:YES];
//    [self.tableView removeFromSuperview];
//}

@end