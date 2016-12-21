//
//  RK_RadarView.m
//  CowBoy
//
//  Created by RK on 2016/11/7.
//  Copyright © 2016年 RK. All rights reserved.
//

#import "RK_RadarView.h"

@interface RK_RadarView()
// 五边形的半径
@property(nonatomic, assign) CGFloat radius;
@property(nonatomic, assign) CGPoint radarCenter;
//五边形五个顶点的位置
@property(nonatomic, strong) NSArray *vertexPoints;
// 每个分值对应的长度
@property(nonatomic, strong) NSArray *scoreLengths;
@end

@implementation RK_RadarView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.radarCenter = CGPointMake(self.width/2.0, self.height/2.0);
        self.radius = (self.height - 20)/2.0;
        self.scoreLengths = [NSArray array];
        [self setupPentagonBackgroundView];
    }
    return self;
}

#pragma mark - 绘制五边形背景
- (void)setupPentagonBackgroundView
{
    NSArray *vertexs = [NSArray arrayWithObjects:@(self.radius),@(self.radius),@(self.radius),@(self.radius),@(self.radius),nil];
    self.vertexPoints = [self getCoordinatesWithLengths:vertexs];
    NSArray *colors = [NSArray arrayWithObjects:
                       [UIColor  colorWithHex:0xF6F6F6],
                       [UIColor  colorWithHex:0xFFFFFF],
                       [UIColor  colorWithHex:0xF6F6F6],
                       [UIColor  colorWithHex:0xFFFFFF],
                       [UIColor  colorWithHex:0xF6F6F6],nil];
    
    for (int i = 0; i < 5; i++)
    {
        CAShapeLayer *bgLayer = [CAShapeLayer layer];
        bgLayer.backgroundColor = [UIColor clearColor].CGColor;
        bgLayer.strokeColor = [UIColor clearColor].CGColor;
        UIColor *fillColor = [colors objectAtIndex:i];
        bgLayer.fillColor = fillColor.CGColor;
        bgLayer.path = [self getPentagonPathWithLength:[[self getLengthFromIndex:4-i] doubleValue]];
        [self.layer addSublayer:bgLayer];
        
        CAShapeLayer *boderLayer = [CAShapeLayer layer];
        boderLayer.backgroundColor = [UIColor clearColor].CGColor;
        boderLayer.strokeColor = [UIColor colorWithHex:0xD2D2D2].CGColor;
        boderLayer.fillColor = [UIColor clearColor].CGColor;
        boderLayer.lineWidth = 0.5;
        boderLayer.path = [self getPentagonPathWithLength:[[self getLengthFromIndex:4-i] doubleValue]];
        [self.layer addSublayer:boderLayer];
    }
    [self setupFiveLine];
}

/**
 从中心到各个顶点画5条分割线
 */
- (void)setupFiveLine
{
    for (int i = 0; i < 5; i++)
    {
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:self.radarCenter];
        [linePath addLineToPoint:[self.vertexPoints[i] CGPointValue]];
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.lineWidth = 0.5;
        lineLayer.strokeColor = [UIColor colorWithHex:0xD2D2D2].CGColor;
        lineLayer.path = linePath.CGPath;
        [self.layer addSublayer:lineLayer];
    }
}

- (NSNumber *)getLengthFromIndex:(int)index
{
    CGFloat length = (self.height - 20) / 10.0;
    return @((index+1)*length);
}

#pragma mark -  -----------------------根据实际数据绘制相应的上层五边形--------------------------------
- (void)setTitles:(NSArray<NSString *> *)titles
{
    _titles = titles;
    //起始点（顶点）
    CGPoint top = [self.vertexPoints[0] CGPointValue];
    top = CGPointMake(top.x, top.y -14);
    
    CGPoint rightTop = [self.vertexPoints[1] CGPointValue];
    rightTop = CGPointMake(rightTop.x+34, rightTop.y);
    
    CGPoint rightBottom = [self.vertexPoints[2] CGPointValue];
    rightBottom = CGPointMake(rightBottom.x+34, rightBottom.y+10);
    
    CGPoint leftBottom = [self.vertexPoints[3] CGPointValue];
    leftBottom = CGPointMake(leftBottom.x-30, leftBottom.y+10);
    
    CGPoint leftTop = [self.vertexPoints[4] CGPointValue];
    leftTop = CGPointMake(leftTop.x-40, leftTop.y);
    
    NSArray *centerArray = [NSArray arrayWithObjects:
                            [NSValue valueWithCGPoint:top],
                            [NSValue valueWithCGPoint:rightTop],
                            [NSValue valueWithCGPoint:rightBottom],
                            [NSValue valueWithCGPoint:leftBottom],
                            [NSValue valueWithCGPoint:leftTop],nil];
    
    for (int i = 0; i < [titles count]; i++)
    {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.bounds = CGRectMake(0, 0, 100, 14);
        label.center = [[centerArray objectAtIndex:i] CGPointValue];
        label.font = [UIFont systemFontOfSize:12];
        label.text = [titles objectAtIndex:i];
        [self addSubview:label];
    }
}

-(void)setScores:(NSArray<NSNumber *> *)scores
{
    _scores = scores;
    [self setupPentagonForegroundView:scores];
}

- (void)setupPentagonForegroundView:(NSArray *)scores
{
    NSMutableArray *lengths = [NSMutableArray array];
    for (int i=0; i<scores.count; i++)
    {
        CGFloat length = [scores[i] floatValue]*self.radius/100.0;
        [lengths addObject:@(length)];
    }
    
    self.scoreLengths = lengths;
    
    CAShapeLayer *alphaLayer = [CAShapeLayer layer];
    alphaLayer.backgroundColor = [UIColor clearColor].CGColor;
    alphaLayer.strokeColor = [UIColor clearColor].CGColor;
    alphaLayer.fillColor = [UIColor colorWithHex:0x0050ff alpha:0.5].CGColor;
    [alphaLayer addAnimation:[self animationFromValue:(id)[self getPentagonPathWithLength:0] toValue:(id)[self getPentagonPathsWithLengths:lengths]] forKey:@"path"];
    alphaLayer.path = [self getPentagonPathsWithLengths:lengths];
    [self.layer addSublayer:alphaLayer];
    
    [self setupDotOnForegroundView];
}

- (void)setupDotOnForegroundView
{
    CAShapeLayer *boderLayer = [CAShapeLayer layer];
    boderLayer.lineWidth = 0.5;
    boderLayer.fillColor = [UIColor clearColor].CGColor;
    boderLayer.strokeColor = [UIColor colorWithHex:0x0000FF].CGColor;
    [boderLayer addAnimation:[self animationFromValue:(id)[self getPentagonPathWithLength:0] toValue:(id)[self getPentagonPathsWithLengths:self.scoreLengths]] forKey:@"scale"];
    boderLayer.path = [self getPentagonPathsWithLengths:self.scoreLengths];
    [self.layer addSublayer:boderLayer];
    
    NSMutableArray *temp = [NSMutableArray array];
    for (int i= 0; i<5; i++)
    {
        [temp addObject:@([self.scoreLengths[i] floatValue]-1.0)];
    }
    NSArray *array = [self getCoordinatesWithLengths:temp];
    for (int i=0; i<temp.count; i++)
    {
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:[array[i] CGPointValue] radius:2 startAngle:0 endAngle:2*M_PI clockwise:YES];
        CAShapeLayer *dotLayer = [CAShapeLayer layer];
        dotLayer.strokeColor = [UIColor colorWithHex:0x0000FF].CGColor;
        dotLayer.fillColor = [UIColor whiteColor].CGColor;
        dotLayer.lineWidth = 1;
        [dotLayer addAnimation:[self animationFromValue:(id)[self getPentagonPathWithLength:0] toValue:(id)path] forKey:@"path"];
        dotLayer.path = path.CGPath;
        [self.layer addSublayer:dotLayer];
    }
}

// 从小到大的基础动画
- (CABasicAnimation *)animationFromValue:(id)fromValue toValue:(id)toValue
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 2;
    animation.autoreverses = NO;
    animation.repeatCount = 0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return animation;
}

#pragma mark - 计算出点的位置
- (CGPathRef)getPentagonPathWithLength:(double)length
{
    NSArray *lengths = [NSArray arrayWithObjects:@(length),@(length),@(length),@(length),@(length), nil];
    return [self getPentagonPathsWithLengths:lengths];
}

- (CGPathRef)getPentagonPathsWithLengths:(NSArray *)lengths
{
    NSArray *coordinates = [self getCoordinatesWithLengths:lengths];
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < [coordinates count]; i++)
    {
        CGPoint point = [[coordinates objectAtIndex:i] CGPointValue];
        if (i == 0)
        {
            [path moveToPoint:point];
        }
        else
        {
            [path addLineToPoint:point];
        }
    }
    [path closePath];
    return path.CGPath;
}

- (NSArray *)getCoordinatesWithLengths:(NSArray *)lengths
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = 0; i < [lengths count] ; i++)
    {
        double length = [[lengths objectAtIndex:i] doubleValue];
        CGPoint point = CGPointZero;
        if (i == 0)
        {
            point =  CGPointMake(self.radarCenter.x ,self.radarCenter.y - length);
        }
        else if (i == 1)
        {
            point = CGPointMake(self.radarCenter.x + length * sin(2*M_PI / 5.0),self.radarCenter.y - length * sin(M_PI / 10.0));
        }
        else if (i == 2)
        {
            point = CGPointMake(self.radarCenter.x + length * sin(M_PI / 5.0),self.radarCenter.y + length * cos(M_PI / 5.0));
        }
        else if (i == 3)
        {
            point = CGPointMake(self.radarCenter.x-length*sin(M_PI/5.0),self.radarCenter.y +length*cos(M_PI/5.0));
        }
        else
        {
            point = CGPointMake(self.radarCenter.x - length * sin(2*M_PI / 5.0),self.radarCenter.y - length * sin(M_PI / 10.0));
        }
        [mutableArray addObject:[NSValue valueWithCGPoint:point]];
    }
    return mutableArray;
}
@end

