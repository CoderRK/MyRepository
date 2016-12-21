//
//  RKWaterFlowView.h
//  CustomClass
//
//  Created by RK on 15/4/16.
//  Copyright (c) 2015年 RK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RKWaterFlowViewMarginType){
    RKWaterFlowViewMarginTypeTop,//上面
    RKWaterFlowViewMarginTypeBottm,//下面
    RKWaterFlowViewMarginTypeLeft,//左边
    RKWaterFlowViewMarginTypeRight,//右边
    RKWaterFlowViewMarginTypeColumn,//竖列
    RKWaterFlowViewMarginTypeRow//行
};

@class RKWaterFlowViewCell,RKWaterFlowView;

#pragma dataSource
@protocol RKWaterFlowViewDataSource <NSObject>
@required
//定义有多少个cell
- (NSUInteger)numberOfCellsInWaterFlowView:(RKWaterFlowView *)waterFlowView;
// 选中第index位置对应的cell
- (RKWaterFlowViewCell *)waterFlowView:(RKWaterFlowView *)waterFlowView cellAtIndex:(NSUInteger)index;
@optional
// 返回有多少列
- (NSUInteger)numberOfColumnsInWaterFlowView:(RKWaterFlowView *)waterFlowView;
@end

#pragma delegate
@protocol RKWaterFlowViewDelegate <UIScrollViewDelegate>
@optional
// 第index位置对应cell的高度
- (CGFloat)waterFlowView:(RKWaterFlowView *)waterFlowView heightAtIndex:(NSUInteger)index;
//选中第index位置的cell
- (void)waterFlowView:(RKWaterFlowView *)waterFlowView didSelectAtIndex:(NSUInteger)index;
//返回间距
- (CGFloat)waterFlowView:(RKWaterFlowView *)waterFlowView marginForType:(RKWaterFlowViewMarginType)type;
@end

@interface RKWaterFlowView : UIScrollView
@property(nonatomic,weak) id<RKWaterFlowViewDataSource> dataSource;
@property(nonatomic,weak) id<RKWaterFlowViewDelegate> MyDelegate;
- (void)reloadData;
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
- (CGFloat)cellWidth;
@end
