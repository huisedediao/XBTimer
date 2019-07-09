//
//  ViewController.m
//  XBTimer
//
//  Created by xxb on 2018/8/24.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self presentViewController:[TestViewController new] animated:YES completion:nil];
}

@end
