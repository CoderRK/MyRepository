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
// 所有的cell的frame
@property(nonatomic,strong) NSMutableArray *cellFrames;
// 正在展示的cell
@property(nonatomic,strong) NSMutableDictionary *displayCells;
// 缓存池
@property(nonatomic,strong) NSMutableSet *reusableCells;
@end

@implementation RKWaterFlowView
- (NSMutableArray *)cellFrames
{
    if (_cellFrames == nil) {
        _cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}
- (NSMutableDictionary *)displayCells
{
    if (_displayCells == nil) {
        _displayCells = [NSMutableDictionary dictionary];
    }
    return _displayCells;
}
- (NSMutableSet *)reusableCells
{
    if (_reusableCells == nil) {
        _reusableCells = [NSMutableSet set];
    }
    return _reusableCells;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
// 第一次显示的时候自动刷新瀑布流控件，不用手动拉取
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self reloadData];
}

- (void)reloadData
{
    [self.displayCells removeAllObjects];
    [self.cellFrames removeAllObjects];
    [self.reusableCells removeAllObjects];
    
    //cell总数
    NSUInteger numOfCells = [self.dataSource numberOfCellsInWaterFlowView:self];
    //总列数
    NSUInteger numOfColumns = [self numOfColumns];
    
    // 间距
    CGFloat leftMargin   = [self marginForType:RKWaterFlowViewMarginTypeLeft];
    CGFloat topMargin    = [self marginForType:RKWaterFlowViewMarginTypeTop];
    CGFloat bottomMargin = [self marginForType:RKWaterFlowViewMarginTypeBottm];
    CGFloat rowMargin    = [self marginForType:RKWaterFlowViewMarginTypeRow];
    CGFloat columnMargin = [self marginForType:RKWaterFlowViewMarginTypeColumn];
    //计算cell的宽度
    //CGFloat cellW = (self.width-leftMargin-rightMargin-(numOfColumns-1)*columnMargin)/numOfColumns;
    CGFloat cellW = [self cellWidth];
    
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
    }
    
    CGFloat contentH = maxYOfColumns[0];
    for (int i=1; i<numOfColumns;i++) {
        if (maxYOfColumns[i]<contentH) {
            contentH = maxYOfColumns[i];
        }
    }
    
    contentH += bottomMargin;
    self.contentSize = CGSizeMake(0, contentH);
}

- (CGFloat)cellWidth
{
    int numOfColumns = [self numOfColumns];
    CGFloat leftM = [self marginForType:RKWaterFlowViewMarginTypeLeft];
    CGFloat rightM = [self marginForType:RKWaterFlowViewMarginTypeRight];
    CGFloat columnsM = [self marginForType:RKWaterFlowViewMarginTypeColumn];
    return (self.width-leftM-rightM-(numOfColumns-1)*columnsM)/numOfColumns;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger numOfCells = self.cellFrames.count;
    for (int i=0;i<numOfCells;i++) {
        CGRect cellFrame = [self.cellFrames[i] CGRectValue];
        RKWaterFlowViewCell *cell = self.displayCells[@(i)];
        if ([self isInScreen:cellFrame]) {
            if (cell == nil) {
                cell = [self.dataSource waterFlowView:self cellAtIndex:i];
                cell.frame = cellFrame;
                [self addSubview:cell];
                self.displayCells[@(i)] = cell;
            }
        }
        else{
            if (cell) {
                [cell removeFromSuperview];
                [self.displayCells removeObjectForKey:@(i)];
                //放进缓存池
                [self.reusableCells addObject:cell];
            }
        }
    }
}
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    __block RKWaterFlowViewCell *reusableCell = nil;
    [self.reusableCells enumerateObjectsUsingBlock:^(RKWaterFlowViewCell *cell, BOOL *stop) {
        if ([cell.identifier isEqualToString:identifier]) {
            reusableCell = cell;
            *stop = YES;
        }
    }];
    if (reusableCell) {
        [self.reusableCells removeObject:reusableCell];
    }
    return reusableCell;
}
- (BOOL)isInScreen:(CGRect)frame
{
    return  (CGRectGetMaxY(frame) > self.contentOffset.y) &&
            (CGRectGetMinY(frame) < self.contentOffset.y + self.height);
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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.MyDelegate respondsToSelector:@selector(waterFlowView:didSelectAtIndex:)]) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __block NSNumber *selectIndex = nil;
    [self.displayCells enumerateKeysAndObjectsUsingBlock:^(id key,RKWaterFlowViewCell *cell, BOOL *stop) {
        if (CGRectContainsPoint(cell.frame, point)) {
            selectIndex = key;
            *stop = YES;
        }
    }];
    if (selectIndex) {
        [self.MyDelegate waterFlowView:self didSelectAtIndex:selectIndex.unsignedIntegerValue];
    }
}
@end
