//
//  RK_RadarView.h
//  RKBaseController
//
//  Created by RK on 2016/12/12.
//  Copyright © 2016年 RK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RK_RadarView<ObjectType> : UIView

/**
 分值和标签都是按逆时针方向显示，最顶上为起始点
 */
@property(nonatomic, strong) NSArray<NSNumber *> *scores;
@property(nonatomic, strong) NSArray<NSString *> *titles;
@end

