//
//  HeadView.m
//  Tmall
//
//  Created by huangxiong on 14-7-31.
//  Copyright (c) 2014年 New-Life. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

- (void) setAll
{
    self.frame = CGRectMake(0, 0, headViewWidth, headViewHeight);
    self.button = [UIButton buttonWithType: UIButtonTypeCustom];
    self.button.frame = self.frame;
    
    // 设置背景图片
    [self.button setBackgroundImage: [UIImage imageNamed: @"topbg"] forState: UIControlStateNormal];
    
    // 设置图片
    [self.button setImage: [UIImage imageNamed: self.imageName] forState: UIControlStateNormal];
    
    // 图片偏移
    UIEdgeInsets edge = UIEdgeInsetsMake(0, -(headViewWidth  - 200), 0, 0);
    [self.button setImageEdgeInsets: edge];
    
    // 设置标题
    [self.button setTitle: self.titleName forState: UIControlStateNormal];
    

    // 设置透明度
    self.button.alpha = 0.55;
    
    // 添加事件
    [self.button addTarget: self action: @selector(onClickButton:) forControlEvents: UIControlEventTouchUpInside];
    
    // 选中高亮
    self.button.showsTouchWhenHighlighted = YES;
    
    [self addSubview: self.button];
}

- (void) onClickButton:(id)sender
{
    if (self.delegate != nil && [self.delegate respondsToSelector: @selector(selected:)] == YES)
    {
        [self.delegate selected: self];
    }
}

@end
