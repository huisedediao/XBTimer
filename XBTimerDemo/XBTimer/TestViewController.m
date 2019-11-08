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
    NSString *_taskID;
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
    
//    __weak typeof(self) weakself = self;
//    [XBTimer executeWithOwner:self delay:0 interval:2 repeats:YES onMainQueue:YES resultTask:^BOOL{
//        __strong typeof(weakself) strongself = weakself;
//        strongself->_count ++;
//        if (strongself ->_count > 5) {
//            return YES;
//        }
//        NSLog(@"%ld",strongself->_count);
//        return NO;
//    }];
    
    _taskID = [XBTimer executeWithTarget:self task:@selector(timerTest) delay:0 interval:1 repeats:YES onMainQueue:YES];
}


- (void)timerTest
{
    _count ++;
    if (_count > 5) {
        [XBTimer cancelTask:_taskID];
    }else
    {
        NSLog(@"%s,count:%ld",__func__,_count);
    }
    
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
