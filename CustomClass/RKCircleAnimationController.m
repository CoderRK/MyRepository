//
//  RKCircleAnimationController.m
//  CustomClass
//
//  Created by 任奎 on 15/4/20.
//  Copyright (c) 2015年 RK. All rights reserved.
//

#import "RKCircleAnimationController.h"
#import "RKCorlorView.h"

@interface RKCircleAnimationController ()
@property(nonatomic,weak)NSTimer *timer;
@property(nonatomic,weak)RKCorlorView *showAnimation;
@end

@implementation RKCircleAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"圆圈动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    RKCorlorView *showAnimation = [[RKCorlorView alloc] initWithFrame:CGRectMake(0, 0, 110, 100)];
    showAnimation.lineW = 5.f;
    showAnimation.second = 1.f;
    showAnimation.colors = @[(id)[UIColor redColor].CGColor,
                                  (id)[UIColor orangeColor].CGColor,
                                  (id)[UIColor blueColor].CGColor,
                                  (id)[UIColor yellowColor].CGColor];
    showAnimation.center = self.view.center;
   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(event:) userInfo:nil repeats:YES];
    [self.view addSubview:showAnimation];
    [showAnimation startAnimation];
    self.timer = timer;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.showAnimation removeFromSuperview];
    self.showAnimation = nil;
    
    [self.timer invalidate];
    self.timer = nil;
}


- (void)event:(id)object
{
    self.showAnimation.percent = arc4random()%100/100.f;
    NSLog(@"%f",arc4random()%100/100.f);
}

@end
