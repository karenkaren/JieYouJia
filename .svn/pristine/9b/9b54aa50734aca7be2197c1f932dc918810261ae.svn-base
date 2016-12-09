//
//  NetAPIManager.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/26.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "NetAPIManager.h"

#define kNetworkMethodName @[@"Get", @"Post"]
#define private_key @"ltn$%^qpdhTH18"

static NetAPIManager * _shareManager;

@interface NetAPIManager ()

@end

@implementation NetAPIManager

static NSString * pathKey(NSString *path, NSDictionary *parameters){
    if(parameters){
        return [path stringByAppendingFormat:@"?%@", AFQueryStringFromParameters(parameters)];
    }
    return path;
}

+ (instancetype)sharedNetAPIManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManager = [[NetAPIManager alloc] init];
        _shareManager.requestSerializer.timeoutInterval = 10;
        _shareManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    });
    return _shareManager;
}

- (void)requestWithPath:(NSString *)path
                 params:(NSDictionary *)params
             methodType:(NetworkMethod)methodType
            block:(void (^)(id response, NSError *error))block
{
    [self requestWithPath:path params:params methodType:methodType autoShowError:YES block:block];
}

- (void)requestWithPath:(NSString *)path
                 params:(NSDictionary *)params
             methodType:(NetworkMethod)methodType
          autoShowError:(BOOL)autoShowError
            block:(void (^)(id response, NSError *error))block
{
    path = esString(path);
    if (!path || path.length <= 0) {
        return;
    }
    // log请求数据
    DLog(@"\n===========request===========\n%@\n%@:\n%@", kNetworkMethodName[methodType], path, params);
    
    // 封装基础参数
    params = [NetAPIManager configParameters:params.mutableCopy];
    
    // 发起请求
    if (![path hasPrefix:@"http"]) {
        if ([path hasPrefix:@"/user"]) {
            path = [@"http://192.168.18.191:61011" stringByAppendingString:path];
        } else {
            path = [API_BASE_URL stringByAppendingString:path];
        }
    }
    switch (methodType) {
        case Get:
        {
            //所有 Get 请求，根据需要增加缓存机制
            NSMutableString * localPath;
            NSArray * cachePaths = [APIUrlConstants getCachePaths];
            if ([cachePaths containsObject:path]) {
                localPath = [NSString netAbsolutePath:path].mutableCopy;
                if (params) {
                    [localPath appendString:params.description];
                }
            }
            [self GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DLog(@"\n===========response===========\n%@:\n%@", path, responseObject);
                id error = [self handleResponse:responseObject autoShowError:autoShowError];
                if (error) {
                    responseObject = [NSObject loadResponseWithPath:pathKey(localPath, params)];
                    block(responseObject, error);
                } else {
                    // 如果需要缓存，则缓存
                    if ([responseObject isKindOfClass:[NSDictionary class]]) {
                        [NSObject saveResponseData:responseObject toPath:pathKey(localPath, params)];
                    }
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"\n===========response===========\n%@:\n%@", path, error.localizedDescription);
                [NSObject showError:error];
                id responseObject = [NSObject loadResponseWithPath:pathKey(localPath, params)];
                block(responseObject, error);
            }];
        }
            break;
        case Post:
        {
            [self POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                DLog(@"\n===========response===========\n%@:\n%@", path, responseObject);
                id error = [self handleResponse:responseObject autoShowError:autoShowError];
                if (error) {
                    block(nil, error);
                }else{
                    block(responseObject, nil);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                DLog(@"\n===========response===========\n%@:\n%@", path, error.localizedDescription);
                [NSObject showError:error];
                block(nil, error);
            }];
        }
            break;
        default:
            break;
    }
}

+ (NSMutableDictionary *)configParameters:(NSMutableDictionary *)parameters
{
    if (!parameters) {
        parameters = [NSMutableDictionary dictionary];
    }
    
    // 基础参数
    [parameters setValue:[GlobalManager appVersion] forKey:@"appVersion"];
    [parameters setValue:@"I" forKey:@"clientType"];
    [parameters setValue:@"jyj" forKey:@"businessLine"];
    [parameters setValue:[[NSUserDefaults standardUserDefaults] valueForKey:kSessionKey] forKey:kSessionKey];
    
    // 加密参数
    NSMutableDictionary * signParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [signParameters setValue:private_key forKey:@"private_key"];
    NSString * signString = [NSString serialize:signParameters];
    signString = [NSString md5:signString];

    [parameters setValue:signString forKey:@"sign"];
    
    return parameters;
}

@end
