//
//  XBTimer.h
//  Interview01-打印
//
//  Created by xxb on 2019/11/8.
//  Copyright © 2019 MJ Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef BOOL (^XBTimerResultTask)(void);

@interface XBTimer : NSObject

/**
 返回一个任务标识 taskID
 owner：owner为nil时会自动停止定时器
 delay：延时多久开始执行任务
 interval：重复的间隔时间
 repeats：是否重复
 onMainQueue：是否在主队列中执行
 resultTask：需要执行的任务，task返回YES表示取消当前定时器
 */
+ (NSString *)executeWithOwner:(__weak id)owner
                         delay:(NSTimeInterval)delay
                      interval:(NSTimeInterval)interval
                       repeats:(BOOL)repeats
                   onMainQueue:(BOOL)onMainQueue
                taskWithResult:(__nullable XBTimerResultTask)taskWithResult;

/**
 返回一个任务标识 taskID
 target：
 selector：
 delay：延时多久开始执行任务
 interval：重复的间隔时间
 repeats：是否重复
 onMainQueue：是否在主队列中执行
 */
+ (NSString *)executeWithTarget:(__weak id)target
                           task:(SEL)task
                          delay:(NSTimeInterval)delay
                       interval:(NSTimeInterval)interval
                        repeats:(BOOL)repeats
                    onMainQueue:(BOOL)onMainQueue;

/**
 根据传入的标识停止任务
 */
+ (void)cancelTask:(NSString *)taskID;

@end

NS_ASSUME_NONNULL_END
