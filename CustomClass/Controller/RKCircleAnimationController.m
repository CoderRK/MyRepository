//
//  RKCircleAnimationController.m
//  CustomClass
//
//  Created by RK on 15/4/20.
//  Copyright (c) 2015年 RK. All rights reserved.
//

#import "RKCircleAnimationController.h"
#import "RKCorlorView.h"

@interface RKCircleAnimationController ()
@property(nonatomic,weak)NSTimer *timer;
@property(nonatomic,strong)RKCorlorView *corlorView;
@end

@implementation RKCircleAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"圆圈动画";
    self.view.backgroundColor = [UIColor colorWithHex:0x757472 alpha:0.8];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.view addSubview:self.corlorView];
    [self.corlorView startAnimation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.corlorView removeFromSuperview];
    self.corlorView = nil;
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)event:(id)object
{
    self.corlorView.percent = arc4random()%100/100.f;
    NSLog(@"%f",arc4random()%100/100.f);
}

#pragma mark - lazy load
- (RKCorlorView *)corlorView
{
    if (!_corlorView)
    {
        RKCorlorView *corlorView = [[RKCorlorView alloc] initWithFrame:CGRectMake((kMainScreenWidth-100)/2.0, 100, 110, 110)];
        corlorView.lineW = 5.f;
        corlorView.second = 1.f;
        corlorView.colors = @[(id)[UIColor purpleColor].CGColor,
                              (id)[UIColor orangeColor].CGColor,
                              (id)[UIColor whiteColor].CGColor,
                              (id)[UIColor cyanColor].CGColor];
        _corlorView = corlorView;
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(event:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _timer = timer;
    }
    return _corlorView;
}

@end
