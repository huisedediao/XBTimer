//
//  XBTimer.m
//  XBTimer
//
//  Created by xxb on 2018/8/24.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "XBTimer.h"

@interface XBTimer ()
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,weak) id timerOwner;
@property (nonatomic,assign) NSTimeInterval ti;
@property (nonatomic,assign) BOOL repeats;
@property (nonatomic,copy) XBTimerBlock timerBlock;
@end

@implementation XBTimer

+ (void)timerStartWithTimeInterval:(NSTimeInterval)ti owner:(id)owner repeats:(BOOL)yesOrNo onMainThread:(BOOL)onMainThread delay:(BOOL)delay block:(XBTimerBlock)block
{
    [[[XBTimer alloc] initWithTimeInterval:ti owner:owner repeats:yesOrNo block:block] startOnMainThread:onMainThread delay:delay];
}

- (instancetype)initWithTimeInterval:(NSTimeInterval)ti owner:(id)owner repeats:(BOOL)yesOrNo block:(XBTimerBlock)block
{
    if (self = [super init])
    {
        _timerOwner = owner;
        _timerBlock = block;
        _ti = ti;
        _repeats = yesOrNo;
    }
    return self;
}

- (void)timerFun:(NSTimer *)timer
{
    if (self.timerOwner)
    {
        self.timerBlock(self);
    }
    else
    {
        [self stop];
    }
}

- (void)startOnMainThread:(BOOL)onMainThread delay:(BOOL)delay
{
    if (onMainThread)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self startWithDelay:delay];
        });
    }
    else
    {
        [self startWithDelay:delay];
    }
}

- (void)startWithDelay:(BOOL)delay
{
    if (_timer == nil)
    {
        _timer = [NSTimer timerWithTimeInterval:_ti target:self selector:@selector(timerFun:) userInfo:nil repeats:_repeats];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    if (delay == NO)
    {
        [self timerFun:_timer];
    }
}

- (void)stop
{
    if ([_timer isValid])
    {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)dealloc
{
    NSLog(@"XBTimer 销毁");
}

@end
