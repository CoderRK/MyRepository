//
//  RKCircleAnimation.m
//  CustomClass
//
//  Created by 任奎 on 15/4/20.
//  Copyright (c) 2015年 RK. All rights reserved.
//

#import "RKCorlorView.h"

@interface RKCorlorView ()
@property(nonatomic,strong)CAShapeLayer *circleLayer;
@end

@implementation RKCorlorView
+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _circleLayer = [CAShapeLayer layer];
    }
    return self;
}

- (void)configCorlors
{
    //获取当前的layer
    CAGradientLayer *gradientLayer = (CAGradientLayer*)[self layer];
    NSMutableArray *corlors = [NSMutableArray array];
    if (_colors == nil) {
        for (NSInteger hue = 0;hue<=360; hue+= 10) {
            [corlors addObject:(id)[UIColor colorWithHue:1.0*hue/360.0
                                              saturation:1.0
                                              brightness:1.0
                                                   alpha:1.0].CGColor];
        }
        [gradientLayer setColors:[NSArray arrayWithArray:corlors]];
    }
    else{
        [gradientLayer setColors:_colors];
    }
}

// 配置圆型
- (CAShapeLayer *)establishCircle
{
    CGPoint circleCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat circleRadius = 0;
    if (_lineW == 0) {
        circleRadius = self.bounds.size.width/2.0 - 2;
    }
    else{
        circleRadius = self.bounds.size.width/2.0 - 2*_lineW;
    }
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:circleCenter
                                                              radius:circleRadius
                                                          startAngle:M_PI
                                                            endAngle:-M_PI clockwise:NO];
    _circleLayer.path = circlePath.CGPath;
    _circleLayer.strokeColor = [UIColor whiteColor].CGColor;
    _circleLayer.fillColor = [[UIColor clearColor] CGColor];
    
    if (_lineW == 0) {
        _circleLayer.lineWidth = 1;
    }
    else{
        _circleLayer.lineWidth = _lineW;
    }
    _circleLayer.strokeStart = 0;
    _circleLayer.strokeEnd = 1.0;
    
    return _circleLayer;
}


- (void)startAnimation
{
    [self configCorlors];
    self.layer.mask = [self establishCircle];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    if (self.second == 0) {
        animation.duration = 5;
    }
    else{
        animation.duration = self.second;
    }
    animation.repeatDuration = MAXFLOAT;
    animation.fromValue = [NSNumber numberWithDouble:0];
    animation.toValue = [NSNumber numberWithDouble:M_PI*2];
    [self.layer addAnimation:animation forKey:nil];
}

@synthesize percent= _percent;
- (CGFloat)percent
{
    return _percent;
}
- (void)setPercent:(CGFloat)percent
{
    if (_circleLayer) {
        _circleLayer.strokeEnd = percent;
    }
}
- (void)endAnimation
{
    [self.layer removeAllAnimations];
}
@end

