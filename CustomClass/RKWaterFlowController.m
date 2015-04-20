//
//  RKWaterFlowController.m
//  CustomClass
//
//  Created by 任奎 on 15/4/16.
//  Copyright (c) 2015年 RK. All rights reserved.
//

#import "RKWaterFlowController.h"
#import "RKWaterFlowView.h"
#import "RKWaterFlowViewCell.h"

@interface RKWaterFlowController ()<RKWaterFlowViewDelegate,RKWaterFlowViewDataSource>

@end

@implementation RKWaterFlowController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    RKWaterFlowView *waterFlowView = [[RKWaterFlowView alloc] initWithFrame:self.view.bounds];
    waterFlowView.MyDelegate = self;
    waterFlowView.dataSource = self;
    [self.view addSubview:waterFlowView];
    
    [waterFlowView reloadData];
}
- (NSUInteger)numberOfCellsInWaterFlowView:(RKWaterFlowView *)waterFlowView
{
    return 10000;
}
- (NSUInteger)numberOfColumnsInWaterFlowView:(RKWaterFlowView *)waterFlowView
{
    return 3;
}

- (RKWaterFlowViewCell *)waterFlowView:(RKWaterFlowView *)waterFlowView cellAtIndex:(NSUInteger)index
{
    static NSString *cellID = @"cell";
    RKWaterFlowViewCell *cell = [waterFlowView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[RKWaterFlowViewCell alloc] init];
        cell.identifier = cellID;
        cell.backgroundColor = RKRandomColor;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
        label.tag = 10;
        [cell addSubview:label];
    }
    UILabel *label = (UILabel *)[cell viewWithTag:10];
    label.text = [NSString stringWithFormat:@"%lu",(unsigned long)index];
    return cell;
}

- (CGFloat)waterFlowView:(RKWaterFlowView *)waterFlowView heightAtIndex:(NSUInteger)index
{
    switch (index%3) {
        case 0:return 70;
        case 1:return 100;
        case 2:return 80;
        default:return 120;
            
    }
}
- (CGFloat)waterFlowView:(RKWaterFlowView *)waterFlowView marginForType:(RKWaterFlowViewMarginType)type
{
    switch (type) {
        case RKWaterFlowViewMarginTypeTop:
        case RKWaterFlowViewMarginTypeBottm:
        case RKWaterFlowViewMarginTypeLeft:
        case RKWaterFlowViewMarginTypeRight:
            return 10;
        case RKWaterFlowViewMarginTypeColumn:
        case RKWaterFlowViewMarginTypeRow:
            return 20;
    }
}
-(void)waterFlowView:(RKWaterFlowView *)waterFlowView didSelectAtIndex:(NSUInteger)index
{
    NSLog(@"点击了%lu的cell",(unsigned long)index);
}
@end
