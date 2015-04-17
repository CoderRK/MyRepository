//
//  RKWaterFlowView.m
//  CustomClass
//
//  Created by 任奎 on 15/4/16.
//  Copyright (c) 2015年 RK. All rights reserved.
//

#import "RKWaterFlowView.h"
#import "RKWaterFlowViewCell.h"

#define RKWaterFlowViewDefaultNumOfColumn 3
#define RKWaterFlowViewDefaultCellHeight 100
#define RKWaterFlowViewDefaultMargin 10

@interface RKWaterFlowView ()
@property(nonatomic,strong) NSMutableArray *cellFrames;
@end
@implementation RKWaterFlowView
- (NSMutableArray *)cellFrames
{
    if (_cellFrames == nil) {
        _cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)reloadData
{
    //cell总数
    NSUInteger numOfCells = [self.dataSource numberOfCellsInWaterFlowView:self];
    //总列数
    NSUInteger numOfColumns = [self numOfColumns];
    
    // 间距
    CGFloat leftMargin   = [self marginForType:RKWaterFlowViewMarginTypeLeft];
    CGFloat rightMargin  = [self marginForType:RKWaterFlowViewMarginTypeRight];
    CGFloat topMargin    = [self marginForType:RKWaterFlowViewMarginTypeTop];
    CGFloat bottomMargin = [self marginForType:RKWaterFlowViewMarginTypeBottm];
    CGFloat rowMargin    = [self marginForType:RKWaterFlowViewMarginTypeRow];
    CGFloat columnMargin = [self marginForType:RKWaterFlowViewMarginTypeColumn];
    //计算cell的宽度
    CGFloat cellW = (self.width-leftMargin-rightMargin-(numOfColumns-1)*columnMargin)/numOfColumns;
    
    CGFloat maxYOfColumns[numOfColumns];
    for (int i=0; i<numOfColumns; i++) {
        maxYOfColumns[i] = 0.0;
    }
    
    // 计算每个cell的frame
    for (int i=0; i<numOfCells; i++) {
        CGFloat cellH = [self heightAtIndex:i];
        NSUInteger cellAtColumn = 0;
        CGFloat maxYOfCellAtColumn=maxYOfColumns[cellAtColumn];
        //求出最短的那一列
        for (int j=0; j<numOfColumns; j++) {
            if(maxYOfColumns[j]<maxYOfCellAtColumn){
                cellAtColumn = j;
                maxYOfCellAtColumn = maxYOfColumns[j];
            }
        }
        CGFloat cellX = leftMargin+cellAtColumn*(cellW+columnMargin);
        CGFloat cellY = 0.0;
        if (maxYOfCellAtColumn == 0.0) {
            cellY = topMargin;
        }
        else{
            cellY = maxYOfCellAtColumn+rowMargin;
        }
        
        CGRect cellFrame = CGRectMake(cellX, cellY, cellW, cellH);
        [self.cellFrames addObject:[NSValue valueWithCGRect:cellFrame]];
        maxYOfColumns[cellAtColumn] = CGRectGetMaxY(cellFrame);
        
        //显示cell
        RKWaterFlowViewCell *cell = [self.dataSource waterFlowView:self cellAtIndex:i];
        cell.frame = cellFrame;
        [self addSubview:cell];
    }
    CGFloat contentH = maxYOfColumns[0];
    for (int i=0; i<numOfColumns;i++) {
        if (maxYOfColumns[i]<contentH) {
            contentH = maxYOfColumns[i];
        }
    }
    contentH += bottomMargin;
    self.contentSize = CGSizeMake(0, contentH);
    
}
- (CGFloat)marginForType:(RKWaterFlowViewMarginType)type
{
    if ([self.MyDelegate respondsToSelector:@selector(waterFlowView:marginForType:)]) {
        return [self.MyDelegate waterFlowView:self marginForType:type];
    }
    else{
        return RKWaterFlowViewDefaultMargin;
    }
}
- (CGFloat)numOfColumns
{
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsInWaterFlowView:)]) {
        return [self.dataSource numberOfColumnsInWaterFlowView:self];
    }
    else{
        return RKWaterFlowViewDefaultNumOfColumn;
    }
}
- (CGFloat)heightAtIndex:(NSUInteger)index
{
    if ([self.MyDelegate respondsToSelector:@selector(waterFlowView:heightAtIndex:)]) {
        return [self.MyDelegate waterFlowView:self heightAtIndex:index];
    }
    else{
        return RKWaterFlowViewDefaultCellHeight;
    }
}
@end
