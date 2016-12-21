//
//  UIColor+Extension.m
//  RKBaseController
//
//  Created by RK on 2016/12/12.
//  Copyright © 2016年 RK. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)
+ (UIColor *)colorWithHex:(int)hex
{
    return [UIColor colorWithHex:hex alpha:1.0f];
}

+ (UIColor *)colorWithHex:(int)hex alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0
                           green:((float)((hex & 0xFF00) >> 8))/255.0
                            blue:((float)(hex & 0xFF))/255.0 alpha:alpha];
}

@end
