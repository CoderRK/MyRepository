//
//  RKMainViewController.m
//  CustomClass
//
//  Created by RK on 2016/12/21.
//  Copyright © 2016年 RK. All rights reserved.
//

#import "RKMainViewController.h"
#import "RKCircleAnimationController.h"
#import "RKWaterFlowController.h"
#import "RKTextViewController.h"
#import "RKRadarController.h"
#import "RKPercentageViewController.h"

@interface RKMainViewController ()
@property(nonatomic, strong) NSArray *datas;
@end

@implementation RKMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"代码小屋 🇨🇳";
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.datas = [NSArray arrayWithObjects:@"自定义TextView", @"雷达图",@"瀑布流",@"百分比视图",@"转圈旋转动画",nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"demoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.datas[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"American Typewriter" size:16];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:{//进入自定义textview
            RKTextViewController *textViewVC = [[RKTextViewController alloc] init];
            [self.navigationController pushViewController:textViewVC animated:YES];
            break;
        }
        case 1:{//进入自定义雷达图
            RKRadarController *radarVC = [[RKRadarController alloc] init];
            [self.navigationController pushViewController:radarVC animated:YES];
            break;
        }
        case 2:{//进入自定义瀑布流视图
            RKWaterFlowController *waterVC = [[RKWaterFlowController alloc] init];
            [self.navigationController pushViewController:waterVC animated:YES];
            break;
        }
        case 3:{//进入自定义百分比视图
            RKPercentageViewController *percentageVC = [[RKPercentageViewController alloc] init];
            [self.navigationController pushViewController:percentageVC animated:YES];
            break;
        }
        case 4:{//进入自定义加载圆圈动画
            RKCircleAnimationController *circleVC = [[RKCircleAnimationController alloc] init];
            [self.navigationController pushViewController:circleVC animated:YES];
            break;
        }
        default:{
            break;
        }
    }
}

@end
