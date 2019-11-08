//
//  XBTimer.m
//  Interview01-打印
//
//  Created by xxb on 2019/11/8.
//  Copyright © 2019 MJ Lee. All rights reserved.
//

#import "XBTimer.h"

@implementation XBTimer

static NSMutableDictionary *_dicM_sources;
static dispatch_semaphore_t _semaphore;

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dicM_sources = [NSMutableDictionary new];
        _semaphore = dispatch_semaphore_create(1);
    });
}

+ (NSString *)executeWithOwner:(__weak id)owner delay:(NSTimeInterval)delay interval:(NSTimeInterval)interval repeats:(BOOL)repeats onMainQueue:(BOOL)onMainQueue taskWithResult:(XBTimerResultTask)taskWithResult
{
    if (!taskWithResult || delay < 0 || (interval < 0 && repeats == YES)) return nil;
    dispatch_queue_t queue = onMainQueue ? dispatch_get_main_queue() : dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    NSString *taskID = [NSString stringWithFormat:@"%ld",_dicM_sources.count];
    _dicM_sources[taskID] = source;
    dispatch_semaphore_signal(_semaphore);
    
    dispatch_source_set_timer(source, dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(source, ^{
        if (!owner) {
            [self cancelTask:taskID];
            return;
        }
        BOOL cancelTask = taskWithResult();
        if (repeats == NO || cancelTask) {
            [self cancelTask:taskID];
        }
    });
    dispatch_resume(source);
    
    return taskID;
}

+ (NSString *)executeWithTarget:(__weak id)target task:(SEL)task delay:(NSTimeInterval)delay interval:(NSTimeInterval)interval repeats:(BOOL)repeats onMainQueue:(BOOL)onMainQueue
{
    if (!target || !task) return nil;
    
    return [self executeWithOwner:target delay:delay interval:interval repeats:repeats onMainQueue:onMainQueue taskWithResult:^BOOL{
        if ([target respondsToSelector:task]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:task];
#pragma clang diagnostic pop
        }
        return NO;
    }];
}

+ (void)cancelTask:(NSString *)taskID
{
    if (taskID.length == 0) return;
    
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    dispatch_source_t source = _dicM_sources[taskID];
    if (source)
    {
        dispatch_source_cancel(source);
        [_dicM_sources removeObjectForKey:taskID];
    }
    dispatch_semaphore_signal(_semaphore);
}

@end
