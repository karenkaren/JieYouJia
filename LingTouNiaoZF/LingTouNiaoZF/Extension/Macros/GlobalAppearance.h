//
//  GlobalAppearance.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#ifndef GlobalAppearance_h
#define GlobalAppearance_h

#pragma mark - 字体

#define kFont(size)  [CustomFont heiti:size]
#define kStringSize(string, fontSize) [string sizeWithAttributes:@{NSFontAttributeName : kFont(fontSize)}]

#pragma mark 常用字体大小

#define kFont18 kFont(18)
#define kFont16 kFont(16)
#define kFont14 kFont(14)
#define kFont12 kFont(12)
#define kFont11 kFont(11)

#pragma mark - 颜色

#define kHexColor(hexColor) [UIColor colorWithHex:hexColor]
#define kHexStringColor(hexStringColor) [UIColor colorWithHexString:hexStringColor]
#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define kRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

#pragma mark 常用颜色

#define kBrightColorFF6600 kHexColor(0xff6600)
#define kBrightColorFFCE00 kHexColor(0xffce00)
#define kBrightColor288BFF kHexColor(0x288bff)
#define kBrightColorFF0000 kHexColor(0xff0000)
#define kDarkColor333333 kHexColor(0x333333)
#define kDarkColor666666 kHexColor(0x666666)
#define kDarkColor999999 kHexColor(0x999999)
#define kDarkColor878787 kHexColor(0x878787)
#define kDarkColorADADAD kHexColor(0xadadad)

#define kNavigationBarColor [UIColor whiteColor]
#define kLineColorD8D8D8 kHexColor(0xd8d8d8)

#endif /* GlobalAppearance_h */
