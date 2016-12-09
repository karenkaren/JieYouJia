//
//  BoundBankCardController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/5.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BoundBankCardController.h"
#import "TextFieldCell.h"
#import "SingleActionSheetPicker.h"
#import "TableViewDevider.h"
#import "MessageCodeController.h"

#import "BoundModel.h"
#import "BankModel.h"

#define kTextFieldCell @"textFieldCell"

#define kTimeCount 60
static NSInteger timeCount = kTimeCount;

@interface BoundBankCardController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * data;
@property (nonatomic, strong) NSMutableDictionary * boundBankCardDic;
@property (nonatomic, strong) UIButton * submitButton;
@property (nonatomic, strong) NSArray * bankList;
@property (nonatomic, strong) NSTimer * timer;

@end

@implementation BoundBankCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名绑卡";
    [self getBankList];
    [self initTableView];
    [self initHeaderView];
    [self initFooterView];
    [self registerCells];
    [self initBoundBankCardDic];
    [self initData];
}

- (void)back
{
    [super back];
    [self stopTimer];
}

- (void)getBankList
{
    [BankModel geBankListWithShowError:NO block:^(id response, id data, NSError *error) {
        if (isArray(data)) {
            self.bankList = data;
        }
    }];
}

- (void)initBoundBankCardDic
{
    if (!self.boundBankCardDic) {
        self.boundBankCardDic = [NSMutableDictionary dictionaryWithCapacity:5];
    }
    
    [self showWaitingIcon];
    [BoundModel checkIdentify:nil block:^(id response, id data, NSError *error) {
        [self dismissWaitingIcon];
        if (!error) {
            if (isDictionary(data) && data[@"idCardNo"] && data[@"realName"]) {
                [self.boundBankCardDic setValue:data[@"realName"] forKey:kRealName];
                [self.boundBankCardDic setObject:data[@"idCardNo"] forKey:kIDCardNo];
                [self initData];
                [self.tableView reloadData];
            }
        }
    }];
}

- (void)initData
{
    self.data = @[
                     @{@"title":@"持卡人姓名：",
                       @"key":kRealName,
                       @"canEdit":[self.boundBankCardDic valueForKey:kRealName] ? @(NO) : @(YES),
                       @"showAccess":@(NO),
                       @"placeholder":@"请输入持卡人姓名",
                       @"maxLength":@(100),
                       },
                     @{@"title":@"身份证号码：",
                       @"key":kIDCardNo,
                       @"canEdit":[self.boundBankCardDic valueForKey:kIDCardNo] ? @(NO) : @(YES),
                       @"showAccess":@(NO),
                       @"placeholder":@"请输入身份证号码",
                       @"maxLength":@(18),
                       },
                     @{@"title":@"选 择 银 行：",
                       @"key":kBankName,
                       @"canEdit":@(NO),
                       @"showAccess":@(YES),
                       @"placeholder":@"请选择银行",
                       @"maxLength":@(100),
                       },
                     @{@"title":@"银行卡卡号：",
                       @"key":kBankCardNo,
                       @"canEdit":@(YES),
                       @"showAccess":@(NO),
                       @"placeholder":@"请输入银行卡卡号",
                       @"maxLength":@(23),
                       },
                     @{@"title":@"银行手机号：",
                       @"key":kBankPhoneNo,
                       @"canEdit":@(YES),
                       @"showAccess":@(NO),
                       @"placeholder":@"请输入银行卡预留的手机号",
                       @"maxLength":@(11),
                       }
                     ];
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - kNavigationBarHeight - kStatusBarHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = kLineColorD8D8D8;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, kCommonMargin, 0, kCommonMargin)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, kCommonMargin, 0, kCommonMargin)];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, kCommonMargin, 0, kCommonMargin)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, kCommonMargin, 0, kCommonMargin)];
    }
}

- (void)initHeaderView
{
    UIView * headerView = [TableViewDevider getViewWithHeight:40 margin:kCommonMargin showTopLine:NO showBottomLine:YES];
    
    UILabel * headerLabel = [[UILabel alloc] init];
    headerLabel.text = @"*请绑定持卡人本人名下的银行卡";
    [headerLabel sizeToFit];
    headerLabel.font = kFont12;
    headerLabel.textColor = kHexColor(0x444444);
    [headerView addSubview:headerLabel];
    
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(kCommonMargin);
        make.centerY.equalTo(headerView);
    }];
    self.tableView.tableHeaderView = headerView;
}

- (void)initFooterView
{
    UIView * footerView = [TableViewDevider getViewWithHeight:kAdaptiveBaseIphone6(95) margin:kCommonMargin showTopLine:YES showBottomLine:NO];
    UIButton * submitButton = [CustomButton createMiddleBGButtonWithTitle:@"下一步" actionBolck:^(UIButton *button) {
        DLog(@"下一步");
        [self submitClick:button];
    }];
    submitButton.enabled = NO;
    [footerView addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(footerView);
    }];
    
    self.tableView.tableFooterView = footerView;
    self.submitButton = submitButton;
}

- (void)registerCells
{
    [self.tableView registerClass:[TextFieldCell class] forCellReuseIdentifier:kTextFieldCell];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:kTextFieldCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableDictionary *dic = [self.data[indexPath.row] mutableCopy];
    NSString * contentText = _boundBankCardDic[dic[@"key"]];
    cell.textField.text = contentText;
    cell.cellDic = dic;
    cell.textFieldTextChangeBlock=^(NSString *text){
        if ([text isEqualToString:@""]) {
            [self.boundBankCardDic removeObjectForKey:dic[@"key"]];
        } else {
            [self.boundBankCardDic setValue:text forKey:dic[@"key"]];
        }
        [self detectIntegrity];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.data[indexPath.row];
    if([dic[@"key"] isEqualToString:kBankName]){
        if (!self.bankList.count) {
            [BankModel geBankListWithShowError:NO block:^(id response, id data, NSError *error) {
                if (isArray(data)) {
                    self.bankList = data;
                    [self showBankSheetPicker];
                }
            }];
        } else {
            [self showBankSheetPicker];
        }
    }
}

- (void)showBankSheetPicker
{
    NSMutableArray * bankList = [NSMutableArray arrayWithCapacity:self.bankList.count];
    for (BankModel * bank in self.bankList) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
        
        NSString * description = [NSString stringWithFormat:@"(单笔充值限额%@万元，单日%@万元)", esString(bank.timeLimit), esString(bank.dateLimit)];
        [dic setValue:bank.bankName forKey:@"key"];
        [dic setValue:bank.bankName forKey:@"value"];
        [dic setValue:description forKey:@"description"];
        [bankList addObject:dic];
    }
    kWeakSelf
    [SingleActionSheetPicker showWithTitle:@"选择银行"
                               selectArray:bankList initialSelectedDic:bankList.firstObject
                                      done:^(RootActionSheetPicker *picker, NSDictionary *selectedDic) {
                                          kStrongSelf
                                          [strongSelf.boundBankCardDic setObject:selectedDic[@"key"] forKey:kBankName];
                                          [strongSelf.tableView reloadData];
                                          [self detectIntegrity];
                                      }
                                    origin:self.view];
}

- (void)detectIntegrity
{
    if (self.boundBankCardDic.count == self.data.count) {
        self.submitButton.enabled = YES;
    } else {
        self.submitButton.enabled = NO;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kTextFieldCellHeight;
}

- (void)submitClick:(UIButton *)button
{
    DLog(@"下一步");
    if (![NSString isValidName:[self.boundBankCardDic valueForKey:kRealName]]) {
        [NSObject showHudTipStr:@"请输入正确的姓名"];
        return;
    }
    
    if (![NSString isValidIDCardNumber:[self.boundBankCardDic valueForKey:kIDCardNo]]) {
        [NSObject showHudTipStr:@"请输入正确的身份证号码"];
        return;
    }
    
    if ([[self.boundBankCardDic valueForKey:kBankName] isEqualToString:@""]) {
        [NSObject showHudTipStr:@"请选择银行"];
        return;
    }
    
    NSString * bankCardNo = [NSString trimSpacesOfString:[self.boundBankCardDic valueForKey:kBankCardNo]];
    if (bankCardNo.length < 16) {
        [NSObject showHudTipStr:@"请输入正确的银行卡号码"];
        return;
    }
    [self.boundBankCardDic setValue:bankCardNo forKey:kBankCardNo];
    
    if (![NSString isPhoneNumber:[self.boundBankCardDic valueForKey:kBankPhoneNo]]) {
        [NSObject showHudTipStr:@"请输入正确的手机号"];
        return;
    }

    [self showWaitingIcon];
    button.enabled = NO;
    [BoundModel bindCard:self.boundBankCardDic block:^(id response, NSError *error) {
        [self dismissWaitingIcon];
        button.enabled = YES;
        if (!error) {
            [self startTimer];
            MessageCodeController * messageCodeController = [[MessageCodeController alloc] init];
            messageCodeController.params = self.boundBankCardDic;
            [self.navigationController pushViewController:messageCodeController animated:YES];
        }
    }];
}

#pragma mark - 计时器
- (void)upateTimer
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TimerCountDown" object:@(timeCount)];
    NSString * timeString = [NSString stringWithFormat:@"%ld秒后重新获取", (long)timeCount--];
    [self.submitButton setTitle:timeString forState:UIControlStateDisabled];
    if (timeCount < 0) {
        [self stopTimer];
    }
}

- (void)startTimer
{
    self.submitButton.enabled = NO;
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(upateTimer) userInfo:nil repeats:YES];
    }
    [self.timer fire];
}

- (void)stopTimer
{
    if(self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        timeCount = kTimeCount;
    }
    if(self.submitButton){
        self.submitButton.enabled = YES;
        [self.submitButton setTitle:@"下一步" forState:UIControlStateNormal];
    }
}

@end
