//
//  BaseWebViewController.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

@interface BaseWebViewController : BaseViewController<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler, UIAlertViewDelegate>

@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, strong) NSURLRequest * request;

- (id)initWithURL:(NSString *)urlString;
- (id)initWithRequest:(NSURLRequest *)request;

- (void)alertError:(NSError *)error;

@end

