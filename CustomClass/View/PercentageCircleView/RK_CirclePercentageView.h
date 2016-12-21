//
//  RK_CirclePercentageView.h
//  RKBaseController
//
//  Created by RK on 2016/12/14.
//  Copyright © 2016年 RK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RK_CirclePercentageView : UIView
- (instancetype)initChartWithFrame:(CGRect)frame circleWidth:(CGFloat)circleWidth color:(UIColor *)color percentage:(CGFloat)percentage tip:(NSString *)tip animation:(BOOL)animation;
- (void)startAnimation;
@end
