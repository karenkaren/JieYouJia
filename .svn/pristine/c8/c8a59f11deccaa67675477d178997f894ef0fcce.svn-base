//
//  BaseWebViewController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BaseWebViewController.h"
#import "JSActions.h"

@interface BaseWebViewController ()

@property (nonatomic, strong) WKUserContentController * userContentController;
@property (nonatomic, strong) JSActions * jsActions;
@end


@implementation BaseWebViewController


#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self registerHandlers];
    [self.view addSubview:self.webView];
    self.jsActions = [[JSActions alloc] initWithWebView:self.webView baseViewController:self];
    
    NSURL * url = self.request.URL;
    if (url.absoluteString.length > 0) {
            [self.webView loadRequest:self.request];
    } else {
        if (self.title.length == 0) {
            self.navigationItem.title = @"地址为空";
        }
    }
}

#pragma mark - init
- (id)initWithURL:(NSString *)urlString{
    
    NSURL *url = [NSURL URLWithString:urlString];
    if (![url host]) {
        urlString = [NSString stringWithFormat:@"%@%@", API_BASE_URL, urlString];
        url = [NSURL URLWithString:urlString];
    }
    self = [self initWithRequest:[NSURLRequest requestWithURL:url]];
    if (self) {
        
    }
    return self;
}

- (id)initWithRequest:(NSURLRequest *)request{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.request = request;
    }
    return self;
}

#pragma mark - Private methods
- (void)registerHandlers
{
    NSArray * actions = [NSObject getAllMethodsFromClass:[JSActions class]];
    for (NSString * actionString in actions) {
        [self.userContentController addScriptMessageHandler:self name:[actionString componentsSeparatedByString:@":"].firstObject];
    }
}

- (void)alertError:(NSError *)error{
    
    if([error code] == NSURLErrorCancelled) {
        return;
    }
    // todo:后续可能为自定义弹框
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载失败" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重试", nil];
    [alertView show];
}

#pragma mark - UIWebView Delegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
//    [self showWaitingIcon];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
//    [self dismissWaitingIcon];
    if (webView.title.length) {
        self.navigationItem.title = webView.title;
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
//    [self dismissWaitingIcon];
    [self alertError:error];
}

#pragma mark - alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (self.navigationController.childViewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    } else {
        [self.webView loadRequest:self.request];
    }
}

#pragma mark - Property Accessor
- (void)setRequest:(NSURLRequest *)request{
    if (_request == request) {
        return;
    }
    _request = [request copy];
}

- (WKWebView *)webView
{
    if (!_webView) {
        WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc] init];
        configuration.preferences.minimumFontSize = 18;
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        _webView.backgroundColor = [UIColor clearColor];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.userContentController = configuration.userContentController;
    }
    return _webView;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSString * selStr = message.name;
    if (![message.body isKindOfClass:[NSNull class]] && isDictionary(message.body)) {
        selStr = [NSString stringWithFormat:@"%@:", selStr];
    }
    SEL action = NSSelectorFromString(selStr);
    if ([self.jsActions respondsToSelector:action]) {
        [self.jsActions performSelector:action withObject:message.body afterDelay:0.0f];
    }
}

@end
