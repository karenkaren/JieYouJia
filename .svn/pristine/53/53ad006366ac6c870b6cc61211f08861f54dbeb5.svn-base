//
//  ServerEnvironmentConstants.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#ifndef ServerEnvironmentConstants_h
#define ServerEnvironmentConstants_h

//add the following as we pass the definitions from Makefile
#if !defined BUILD_FOR_DEVELOP && !defined BUILD_FOR_TEST && !defined BUILD_FOR_RELEASE

//使用开发服务器
#define BUILD_FOR_DEVELOP

//使用测试服务器
//#define BUILD_FOR_TEST

//使用生产服务器
//#define BUILD_FOR_RELEASE

#endif

#ifdef BUILD_FOR_DEVELOP

#define API_BASE_URL_Internal    @"http://192.168.18.191:60011"

#endif

#ifdef BUILD_FOR_TEST

#define API_BASE_URL_Internal    @"http://120.55.184.234:8080"//阿里云测试
#endif

#ifdef BUILD_FOR_RELEASE

#define API_BASE_URL_Internal @"https://www.lingtouniao.com/v3"

#endif

#if (defined(DEBUG) || defined(ADHOC ))

#define ISPostAddress [[NSUserDefaults standardUserDefaults] dictionaryForKey:kDefaults_NetAddress][kDefaults_POST_ADDR]
#define  API_BASE_URL            (ISPostAddress ?: API_BASE_URL_Internal)

#else

#define API_BASE_URL API_BASE_URL_Internal

#endif

#endif /* ServerEnvironmentConstants_h */
