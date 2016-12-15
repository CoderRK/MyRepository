//
//  RKMainController.m
//  CustomClass
//
//  Created by 任奎 on 15/4/15.
//  Copyright (c) 2015年 RK. All rights reserved.
//

#import "RKMainController.h"
#import "RKTextView.h"
#import "RKWaterFlowController.h"
#import "RKCircleAnimationController.h"


@interface RKMainController ()
@property(nonatomic,weak) RKTextView *textView;
@end

@implementation RKMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"demo";
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTextView];
    [self setupBtnJump];
}

- (void)setupBtnJump
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 44)];
    btn.layer.cornerRadius = 10;
    [btn setTitle:@"点击跳转" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(jumpToCtr) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btnCircle = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 100, 44)];
    btnCircle.layer.cornerRadius = 10;
    [btnCircle setTitle:@"跳转动画" forState:UIControlStateNormal];
    [btnCircle setBackgroundColor:[UIColor brownColor]];
    [btnCircle addTarget:self action:@selector(jumpToCircle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCircle];
    
    
}
- (void)jumpToCircle
{
    RKCircleAnimationController *circleCtr = [[RKCircleAnimationController alloc] init];
    [self.navigationController pushViewController:circleCtr animated:YES];
}

- (void)jumpToCtr
{
    RKWaterFlowController *wfCtr = [[RKWaterFlowController alloc] init];
    [self.navigationController pushViewController:wfCtr animated:YES];
}
- (void)setupTextView
{
    RKTextView *textView = [[RKTextView alloc] initWithFrame:CGRectMake(0, 0, self.view.width,self.view.height-380)];
    textView.backgroundColor = [UIColor cyanColor];
    textView.placeholderWord = @"赶紧分享你的新鲜事吧，你还可以吐槽,Just do it ";
    textView.placeholderColor = [UIColor brownColor];
    textView.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:textView];
    self.textView = textView;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.textView isExclusiveTouch]) {
        [self.textView resignFirstResponder];
    }
}
@end
