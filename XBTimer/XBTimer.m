//
//  XBTimer.m
//  Interview01-打印
//
//  Created by xxb on 2019/11/8.
//  Copyright © 2019 MJ Lee. All rights reserved.
//

#import "XBTimer.h"

@implementation XBTimer

+ (dispatch_source_t)executeWithTarget:(__weak id)target task:(SEL)task delay:(NSTimeInterval)delay interval:(NSTimeInterval)interval repeats:(BOOL)repeats onMainQueue:(BOOL)onMainQueue
{
    if (!target || !task) return nil;
    if (delay < 0 || (interval < 0 && repeats == YES)) return nil;
    
    dispatch_queue_t queue = onMainQueue ? dispatch_get_main_queue() : dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(source, dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(source, ^{
        if (!target) {
            [self cancelTimer:source];
            return;
        }
        if ([target respondsToSelector:task]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:task];
#pragma clang diagnostic pop
        }
        if (repeats == NO) {
            [self cancelTimer:source];
        }
    });
    dispatch_resume(source);
    
    return source;
}

+ (void)cancelTimer:(dispatch_source_t)timer
{
    if (!timer) return;
    dispatch_source_cancel(timer);
}

@end
