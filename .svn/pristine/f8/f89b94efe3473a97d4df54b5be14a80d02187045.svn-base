//
//  Defines.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/23.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "Defines.h"

#pragma mark - Dispatch
void ZFDispatchSyncOnMainThread(dispatch_block_t block)
{
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

void ZFDispatchAsyncOnMainThread(dispatch_block_t block)
{
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

void ZFDispatchOnGlobalQueue(dispatch_queue_priority_t priority, dispatch_block_t block)
{
    dispatch_async(dispatch_get_global_queue(priority, 0), block);
}

void ZFDispatchOnDefaultQueue(dispatch_block_t block)
{
    ZFDispatchOnGlobalQueue(DISPATCH_QUEUE_PRIORITY_DEFAULT, block);
}
void ZFDispatchOnHighQueue(dispatch_block_t block)
{
    ZFDispatchOnGlobalQueue(DISPATCH_QUEUE_PRIORITY_HIGH, block);
}
void ZFDispatchOnLowQueue(dispatch_block_t block)
{
    ZFDispatchOnGlobalQueue(DISPATCH_QUEUE_PRIORITY_LOW, block);
}
void ZFDispatchOnBackgroundQueue(dispatch_block_t block)
{
    ZFDispatchOnGlobalQueue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, block);
}

void ZFDispatchAfter(NSTimeInterval delayTime, dispatch_block_t block)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)),
                   dispatch_get_main_queue(),
                   block);
}

