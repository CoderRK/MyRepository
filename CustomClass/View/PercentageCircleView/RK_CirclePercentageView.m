//
//  RK_CirclePercentageView.m
//  RKBaseController
//
//  Created by RK on 2016/12/14.
//  Copyright © 2016年 RK. All rights reserved.
//

#import "RK_CirclePercentageView.h"

@interface RK_CirclePercentageView()<CAAnimationDelegate>
@property(nonatomic, assign) CGFloat circleWidth;
@property(nonatomic, weak) UILabel *tipLabel;
@property(nonatomic, weak) UILabel *scoreLabel;
@property(nonatomic, assign) CGFloat radius;
@property(nonatomic, strong) UIColor *color;

@property(nonatomic, strong) CAShapeLayer *BGCircleLayer;
@property(nonatomic, strong) CAShapeLayer *outerLayer;
@property(nonatomic, strong) UIBezierPath *circlePath;

@property(nonatomic, assign) CGFloat percentage;
@property(nonatomic, assign,getter=isAnimation) BOOL animation;
@end

@implementation RK_CirclePercentageView

/**
 初始化圆圈统计图表
 @param frame 圆圈的frame
 @param circleWidth 圆圈的宽度
 @param color 圆圈的颜色
 @param percentage 圆圈的占比
 @param animation 是否有动画
 @return 返回
 */
- (instancetype)initChartWithFrame:(CGRect)frame circleWidth:(CGFloat)circleWidth color:(UIColor *)color percentage:(CGFloat)percentage tip:(NSString *)tip animation:(BOOL)animation
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.circleWidth = circleWidth;
        self.color = color;
        self.percentage = percentage;
        self.animation = animation;
        
        if (frame.size.width <= frame.size.height)
        {
            self.radius = frame.size.width/2.0;
        }
        else
        {
            self.radius = frame.size.height/2.0;
        }
        //圆心
        CGPoint centrePoint = CGPointMake(self.width/2.0,self.width/2.0);
        
        UILabel *scoreLabel = [[UILabel alloc] init];
        scoreLabel.size = CGSizeMake(self.radius*2, 22);
        scoreLabel.centerX = centrePoint.x;
        scoreLabel.centerY = centrePoint.y-8;
        scoreLabel.textColor = color;
        scoreLabel.text = [NSString stringWithFormat:@"%.2f",percentage*100];
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        scoreLabel.font = [UIFont boldSystemFontOfSize:22];
        [self addSubview:scoreLabel];
        self.tipLabel = scoreLabel;
        
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.size = CGSizeMake(self.radius*2, 10);
        tipLabel.centerX = centrePoint.x;
        tipLabel.centerY = centrePoint.y+18;
        tipLabel.text = tip;
        tipLabel.textColor = [UIColor colorWithHex:0x565656];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:tipLabel];
        self.tipLabel = tipLabel;
        
        self.circlePath = [UIBezierPath bezierPathWithArcCenter:centrePoint radius:self.radius startAngle:-M_PI_2 endAngle:M_PI*3/2 clockwise:YES];
        [self drawBackgroundLayer];
    }
    return self;
}

- (void)drawBackgroundLayer
{
    self.BGCircleLayer = [CAShapeLayer layer];
    self.BGCircleLayer.path = self.circlePath.CGPath;
    self.BGCircleLayer.strokeColor = [UIColor colorWithHex:0xE8E8E8].CGColor;
    self.BGCircleLayer.fillColor = [UIColor clearColor].CGColor;
    self.BGCircleLayer.lineWidth = self.circleWidth;
    [self.layer addSublayer:self.BGCircleLayer];
    
    if (self.animation)
    {
        [self drawPercentLayer];
        [self startAnimation];
    }
    else
    {
        [self drawPercentLayer];
    }
}

- (void)drawPercentLayer
{
    self.outerLayer = [CAShapeLayer layer];
    self.outerLayer.path = self.circlePath.CGPath;
    self.outerLayer.strokeColor = self.color.CGColor;
    self.outerLayer.fillColor = [UIColor clearColor].CGColor;
    self.outerLayer.lineWidth = self.circleWidth;
    self.outerLayer.lineJoin = kCALineJoinRound;
    self.outerLayer.lineCap = kCALineCapRound;
    self.outerLayer.strokeStart = 0.0f;
    self.outerLayer.strokeEnd = self.percentage;
    [self.layer addSublayer:self.outerLayer];
}

- (void)startAnimation
{
    CABasicAnimation *circleAnimation = nil;
    circleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circleAnimation.duration = 1.5f;
    circleAnimation.fromValue = @(0.0f);
    circleAnimation.toValue = @(self.percentage);
    circleAnimation.autoreverses = NO;
    circleAnimation.delegate = self;
    [self.outerLayer addAnimation:circleAnimation forKey:@"strokeEnd"];
}
@end
