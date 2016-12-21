//
//  RKPercentageViewController.m
//  CustomClass
//
//  Created by RK on 2016/12/21.
//  Copyright © 2016年 RK. All rights reserved.
//

#import "RKPercentageViewController.h"
#import "RK_CirclePercentageView.h"

@interface RKPercentageViewController ()
@property(nonatomic, strong) RK_CirclePercentageView *circleView;
@end

@implementation RKPercentageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    [self.view addSubview:self.circleView];
}

#pragma mark - lazy load
- (RK_CirclePercentageView *)circleView
{
    if (!_circleView)
    {
        RK_CirclePercentageView *circleView = [[RK_CirclePercentageView alloc] initChartWithFrame:CGRectMake(( kMainScreenWidth-200)/2.0, 140, 200, 200) circleWidth:30 color:[UIColor orangeColor] percentage:0.76 tip:@"个人投资者" animation:YES];
        _circleView = circleView;
    }
    return _circleView;
}
@end
