//
//  RKTextView.h
//  CustomClass
//
//  Created by RK on 15/4/16.
//  Copyright (c) 2015年 RK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKTextView : UITextView
// 占位文字
@property(nonatomic,copy) NSString *placeholderWord;
// 占位文字颜色
@property(nonatomic,strong) UIColor *placeholderColor;
@end
