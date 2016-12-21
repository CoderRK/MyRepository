//
//  RKRadarController.m
//  CustomClass
//
//  Created by RK on 2016/12/21.
//  Copyright © 2016年 RK. All rights reserved.
//

#import "RKRadarController.h"
#import "RK_RadarView.h"

@interface RKRadarController ()
@property(nonatomic, strong) RK_RadarView *radarView;
@end

@implementation RKRadarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.view addSubview:self.radarView];
}

#pragma mark - lazy load
- (RK_RadarView *)radarView
{
    if (!_radarView)
    {
        RK_RadarView *radarView = [[RK_RadarView alloc] initWithFrame:CGRectMake(30, 100, self.view.width-60, 200)];
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@(60.0)];
        [array addObject:@(60.0)];
        [array addObject:@(70.0)];
        [array addObject:@(70.0)];
        [array addObject:@(80)];
        
        radarView.scores = array;
        radarView.titles = @[@"雪球价值",@"主力深度",@"资金热度",@"F点密集度",@"市场关注度"];
        _radarView = radarView;
    }
    return _radarView;
}
@end
