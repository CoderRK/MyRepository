//
//  RKCircleAnimation.h
//  CustomClass
//
//  Created by RK on 15/4/20.
//  Copyright (c) 2015年 RK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKCorlorView : UIView
@property(nonatomic,assign)CGFloat lineW;//线的宽度
@property(nonatomic,assign)CFTimeInterval second;//时间：秒
@property(nonatomic,assign)CGFloat percent;//百分比
@property(nonatomic,strong)NSArray *colors;//颜色分组
- (void)startAnimation;
- (void)endAnimation;
@end
