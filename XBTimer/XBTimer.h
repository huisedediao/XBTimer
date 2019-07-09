//
//  XBTimer.h
//  XBTimer
//
//  Created by xxb on 2018/8/24.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XBTimer;

typedef void (^XBTimerBlock)(XBTimer *timer);

@interface XBTimer : NSObject

///注意：如果block里引用其他对象的资源时要用弱引用
+ (void)timerStartWithTimeInterval:(NSTimeInterval)ti owner:(id)owner repeats:(BOOL)yesOrNo onMainThread:(BOOL)onMainThread delay:(BOOL)delay block:(XBTimerBlock)block;

/**
 ti : 执行间隔
 owner : timer的拥有者
 repeats : 是否重复执行
 block : 回调，注意：如果block里引用其他对象的资源时要用弱引用
 */
- (instancetype)initWithTimeInterval:(NSTimeInterval)ti owner:(id)owner repeats:(BOOL)yesOrNo block:(XBTimerBlock)block;

/** 定时器开始工作
 onMainThread : 是否运行在主线程,
                注意：如果不是运行在自己创建的线程，在销毁该线程之前，要调用timer的stop方法，否则timer就变成了野指针
 delay : YES,则ti秒后才执行第一次回调；NO，立即执行第一次回调
 */
- (void)startOnMainThread:(BOOL)onMainThread delay:(BOOL)delay;

/** 立即停止定时器 */
- (void)stop;

@end
