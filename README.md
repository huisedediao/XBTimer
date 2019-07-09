# XBTimer
会自动销毁的定时器，如果owner销毁了，或者timer调用stop并且没有强指针引用timer时，timer会自动销毁
<br>
### 使用：
<br>
<pre>
__weak TestViewController *weakSelf = self;
[XBTimer timerStartWithTimeInterval:1 owner:self repeats:YES onMainThread:YES delay:NO block:^(XBTimer *timer) {
    __strong TestViewController *strongSelf = weakSelf;
    if (strongSelf->_count == 4)
    {
        [timer stop];
    }
    NSLog(@"runTimerOnMainRunLoop");
    strongSelf->_count++;
}];
</pre>
