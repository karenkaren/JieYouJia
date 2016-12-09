//
//  NSObject+Common.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/27.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "NSObject+Common.h"
#import <objc/runtime.h>
#import "MJExtension.h"
#import "BaseModel.h"

#define kPathResponseCache @"ResponseCache"

@implementation NSObject (Common)

#pragma mark - File Manager
// 获取fileName在Document文件夹中的完整地址
//+ (NSString *)pathInDocumentsDirectory:(NSString *)fileName
//{
//    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    return [documentPath stringByAppendingPathComponent:fileName];
//}

//获取fileName在缓存文件夹中的完整地址
+ (NSString* )pathInCacheDirectory:(NSString *)fileName
{
    NSArray * cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    return [cachePath stringByAppendingPathComponent:fileName];
}

//创建缓存文件夹
+ (BOOL)createDirInCache:(NSString *)dirName
{
    NSString *dirPath = [self pathInCacheDirectory:dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    BOOL isCreated = NO;
    if ( !(isDir == YES && existed == YES) )
    {
        isCreated = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (existed) {
        isCreated = YES;
    }
    return isCreated;
}

#pragma mark - Net Data Persistence
// 保存网络请求数据
+ (BOOL)saveResponseData:(NSDictionary *)data toPath:(NSString *)requestPath{
    if ([esString(requestPath) isEqualToString:@""]) {
        return NO;
    }
    if ([self createDirInCache:kPathResponseCache]) {
        NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPathResponseCache], [NSString md5:requestPath]];
        return [data writeToFile:abslutePath atomically:YES];
    }else{
        return NO;
    }
}

+ (id)loadResponseWithPath:(NSString *)requestPath{//返回一个NSDictionary类型的json数据
    
    if ([esString(requestPath) isEqualToString:@""]) {
        return nil;
    }
    NSString * abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPathResponseCache], [NSString md5:requestPath]];
    return [NSMutableDictionary dictionaryWithContentsOfFile:abslutePath];
}

#pragma mark - Net Error Handle
-(id)handleResponse:(id)response{
    return [self handleResponse:response autoShowError:YES];
}
-(id)handleResponse:(id)response autoShowError:(BOOL)autoShowError{
    NSError *error = nil;
    //code为2值时，表示有错,1表示无错
    NSInteger errorCode = [(NSNumber *)[response valueForKeyPath:@"code"] integerValue];
    if (errorCode != 1) {
        error = [NSError errorWithDomain:API_BASE_URL code:errorCode userInfo:response];
        //错误提示
        if (autoShowError) {
            [NSObject showError:error];
        }
    }
    return error;
}

#pragma mark - tips
+ (void)showWaitingIconInView:(UIView *)view
{
    [self dismissWaitingIconInView:view];
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    hud.removeFromSuperViewOnHide = YES;
}

+ (void)dismissWaitingIconInView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (NSString *)tipFromError:(NSError *)error{
    if (error && error.userInfo) {
        NSString * tipStr;
        if ([error.userInfo objectForKey:@"reason"]) {
            tipStr = esString([error.userInfo objectForKey:@"reason"]);
        }else{
            if ([error.userInfo objectForKey:@"NSLocalizedDescription"]) {
                tipStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            }else{
                tipStr = [NSString stringWithFormat:@"ErrorCode%ld", error.code];
            }
        }
        return tipStr;
    }
    return nil;
}

+ (BOOL)showError:(NSError *)error{
    NSString *tipStr = [NSObject tipFromError:error];
    [NSObject showHudTipStr:tipStr];
    return YES;
}

+ (BOOL)showMessage:(NSString *)message
{
    [NSObject showHudTipStr:message];
    return YES;
}

+ (void)showHudTipStr:(NSString *)tipStr
{
    if (tipStr && tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[GlobalManager keyWindow]  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        hud.detailsLabel.font = [UIFont boldSystemFontOfSize:15.0];
        hud.detailsLabel.textColor = [UIColor whiteColor];
        hud.detailsLabel.text = tipStr;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:2.0];
    }
}

#pragma mark - runtime
/**
 *  获取对象的所有方法
 */
+ (NSArray *)getAllMethodsFromClass:(Class)class
{
    unsigned int count_f =0;
    //获取方法链表
    Method * methodList_f = class_copyMethodList(class,&count_f);
    NSMutableArray *methodsArray = [NSMutableArray arrayWithCapacity:count_f];
    
    for(int i=0;i<count_f;i++)
    {
        Method temp_f = methodList_f[i];
        //方法
        SEL name_f = method_getName(temp_f);
        NSString *methodStr = NSStringFromSelector(name_f);
        [methodsArray addObject:methodStr];
    }
    free(methodList_f);
    
    return methodsArray;
}

#pragma mark - Dictionary to Object
+ (id)objectOfClass:(Class)modelClass fromJSON:(NSDictionary *)dict {
    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    BaseModel * model = [(BaseModel *)[modelClass alloc] init];
    [model mj_setKeyValues:dict[@"data"]];
    return model;
}

//+ (UIViewController *)getPreControllerOfCurrentController:(UIViewController *)controller
//{
//    UIViewController * preController = nil;
//    
//}

@end
