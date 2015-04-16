//
//  RKMainController.m
//  CustomClass
//
//  Created by 任奎 on 15/4/15.
//  Copyright (c) 2015年 RK. All rights reserved.
//

#import "RKMainController.h"
#import "RKTextView.h"


@interface RKMainController ()
@property(nonatomic,weak) RKTextView *textView;
@end

@implementation RKMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTextView];
}

- (void)setupTextView
{
    RKTextView *textView = [[RKTextView alloc] initWithFrame:self.view.bounds];
    textView.placeholderWord = @"赶紧分享你的新鲜事吧，你可以吐槽，可以夸奖，可以抒发你的心情，在这里全凭你自由发挥，没有界限，没有尺度，因为我们是龙的传人，龙之子民，就应该有龙的品行！！！！Just do it ";
    textView.placeholderColor = [UIColor brownColor];
    textView.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:textView];
    self.textView = textView;
}
@end
