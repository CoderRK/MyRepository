//
//  RKTextViewController.m
//  CustomClass
//
//  Created by RK on 2016/12/21.
//  Copyright © 2016年 RK. All rights reserved.
//

#import "RKTextViewController.h"
#import "RKTextView.h"

@interface RKTextViewController ()
@property(nonatomic, weak) RKTextView *textView;
@end

@implementation RKTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
     [self setupTextView];
}

- (void)setupTextView
{
    RKTextView *textView = [[RKTextView alloc] initWithFrame:CGRectMake(0, 64, self.view.width,self.view.height-380)];
    textView.backgroundColor = [UIColor cyanColor];
    textView.placeholderWord = @"赶紧分享你的新鲜事吧，你还可以吐槽,Just do it ";
    textView.placeholderColor = [UIColor brownColor];
    textView.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:textView];
    self.textView = textView;
}

// 点击空白处退出键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.textView isExclusiveTouch]) {
        [self.textView resignFirstResponder];
    }
}
@end
