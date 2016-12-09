//
//  HomeApartmentCell.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/2.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "HomeApartmentCell.h"

@interface HomeApartmentCell ()

@property (nonatomic, strong) UIImageView * apartmentImageView;
@property (nonatomic, strong) UILabel * apartmentNameLabel;
@property (nonatomic, strong) UILabel * apartmentAddressLabel;
@property (nonatomic, strong) UILabel * apartmentPriceLabel;

@end

@implementation HomeApartmentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI
{
    [self.contentView addSubview:self.apartmentImageView];
    [self.contentView addSubview:self.apartmentNameLabel];
    [self.contentView addSubview:self.apartmentAddressLabel];
    [self.contentView addSubview:self.apartmentPriceLabel];
    
    [self.apartmentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(@(kCommonMargin));
        make.width.equalTo(self.contentView).offset(-2 * kCommonMargin);
        make.width.equalTo(self.apartmentImageView.mas_height).multipliedBy(690.0 / 424.0);
    }];
    
    [self.apartmentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.apartmentImageView.mas_bottom).offset(8);
        make.left.equalTo(self.apartmentImageView);
    }];
    
    [self.apartmentAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.apartmentNameLabel);
        make.top.equalTo(self.apartmentNameLabel.mas_bottom).offset(kAdaptiveBaseIphone6(3));
    }];
    
    [self.apartmentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.apartmentImageView);
        make.centerY.equalTo(self.apartmentAddressLabel);
    }];
}

- (UIImageView *)apartmentImageView
{
    if (!_apartmentImageView) {
        _apartmentImageView = [[UIImageView alloc] init];
        _apartmentImageView.contentMode = UIViewContentModeScaleToFill;
        _apartmentImageView.clipsToBounds = YES;
    }
    return _apartmentImageView;
}

- (UILabel *)apartmentNameLabel
{
    if (!_apartmentNameLabel) {
        _apartmentNameLabel = [[UILabel alloc] init];
        _apartmentNameLabel.font = kFont16;
        _apartmentNameLabel.textColor = kDarkColor333333;
    }
    return _apartmentNameLabel;
}

- (UILabel *)apartmentAddressLabel
{
    if (!_apartmentAddressLabel) {
        _apartmentAddressLabel = [[UILabel alloc] init];
        _apartmentAddressLabel.font = kFont12;
        _apartmentAddressLabel.textColor = kDarkColor878787;
    }
    return _apartmentAddressLabel;
}

- (UILabel *)apartmentPriceLabel
{
    if (!_apartmentPriceLabel) {
        _apartmentPriceLabel = [[UILabel alloc] init];
        _apartmentPriceLabel.font = kFont12;
        _apartmentPriceLabel.textColor = kBrightColorFF6600;
        [_apartmentPriceLabel sizeToFit];
    }
    return _apartmentPriceLabel;
}

- (void)setData:(id)data
{
    _data = data;
    if ([data isKindOfClass:[ApartmentModel class]]) {
        ApartmentModel * apartment = (ApartmentModel *)data;
        self.apartmentAddressLabel.text = apartment.address;
        [self.apartmentAddressLabel sizeToFit];
        self.apartmentPriceLabel.text = [NSString stringWithFormat:@"¥%@起", apartment.minPrice];
        [self.apartmentPriceLabel sizeToFit];
        self.apartmentNameLabel.text = apartment.name;
        [self.apartmentNameLabel sizeToFit];
        self.apartmentImageView.image = [UIImage imageNamed:apartment.picUrl];
    }
}

@end
