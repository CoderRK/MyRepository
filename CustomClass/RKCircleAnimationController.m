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
@property(nonatomic,strong)NSTimer *rkTime;
@property(nonatomic,strong)RKCorlorView *showAnimation;
@end

@implementation RKCircleAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"圆圈动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.showAnimation = [[RKCorlorView alloc] initWithFrame:CGRectMake(0, 0, 110, 100)];
    self.showAnimation.lineW = 5.f;
    self.showAnimation.second = 1.f;
    self.showAnimation.colors = @[(id)[UIColor redColor].CGColor,
                                  (id)[UIColor orangeColor].CGColor,
                                  (id)[UIColor blueColor].CGColor,
                                  (id)[UIColor yellowColor].CGColor];
    self.showAnimation.center = self.view.center;
    self.rkTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(event:) userInfo:nil repeats:YES];
    [self.view addSubview:self.showAnimation];
    [self.showAnimation startAnimation];
}
- (void)event:(id)object
{
    self.showAnimation.percent = arc4random()%100/100.f;
    NSLog(@"%f",arc4random()%100/100.f);
}
@end
