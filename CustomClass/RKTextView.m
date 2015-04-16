//
//  RKTextView.m
//  CustomClass
//
//  Created by 任奎 on 15/4/16.
//  Copyright (c) 2015年 RK. All rights reserved.
//

#import "RKTextView.h"

@interface RKTextView ()
@property(nonatomic,weak) UILabel *placeholderLabel;
@end

@implementation RKTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:placeholderLabel];
        placeholderLabel.textColor = [UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:14];
        self.placeholderLabel = placeholderLabel;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)setPlaceholderWord:(NSString *)placeholderWord
{
    _placeholderWord = [placeholderWord copy];
    self.placeholderLabel.text = placeholderWord;
    [self setNeedsDisplay];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self setNeedsDisplay];
}
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textDidChange];
}

- (void)textDidChange
{
    self.placeholderLabel.hidden = (self.text.length!=0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderLabel.y = 8;
    self.placeholderLabel.x = 5;
    self.placeholderLabel.width = self.width - 2*self.placeholderLabel.x;
    CGSize maxSize = CGSizeMake(self.placeholderLabel.width, MAXFLOAT);
    CGSize size = [self.placeholderLabel.text textSizeWithFont:self.placeholderLabel.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    self.placeholderLabel.height = size.height;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
