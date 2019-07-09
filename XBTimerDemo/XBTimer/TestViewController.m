//
//  TestViewController.m
//  XBTimer
//
//  Created by xxb on 2018/8/24.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "TestViewController.h"
#import "XBTimer.h"

@interface TestViewController ()
{
    NSInteger _count;
    XBTimer *_timer;
}
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"back" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self runTimerOnMainRunLoop];
    
//    [self timerDeallocTest];
}

- (void)runTimerOnMainRunLoop
{
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
}

- (void)timerDeallocTest
{
    __weak TestViewController *weakSelf = self;
    _timer = [[XBTimer alloc] initWithTimeInterval:1 owner:self repeats:YES block:^(XBTimer *timer) {
        __strong TestViewController *strongSelf = weakSelf;
        if (strongSelf->_count == 4)
        {
            [timer stop];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [timer startOnMainThread:YES delay:NO];
            });
        }
        NSLog(@"runTimerOnMainRunLoop");
        strongSelf->_count++;
    }];
    [_timer startOnMainThread:YES delay:YES];
}

- (void)dealloc
{
    NSLog(@"TestViewController 销毁");
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
