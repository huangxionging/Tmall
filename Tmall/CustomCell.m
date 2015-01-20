//
//  CustomCell.m
//  Tmall
//
//  Created by huangxiong on 14-7-30.
//  Copyright (c) 2014年 New-Life. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) setCustomCell
{
    // 删除内容视图上的按钮
    for (UIView *view in self.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    // 缝隙宽度
    NSInteger space = self.size.width / ONE_LINE_BUTTONS;
    
    // 坐标
    NSInteger x = 0, y = 0;
    
    // 添加按钮
    for (NSInteger index = 0; index < [self.subArray count]; ++index)
    {
        UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
        button.frame = CGRectMake(x , y, BUTTON_WIDTH, BUTTON_HEIGHT);
        x += space;
        
        if ((index + 1) % ONE_LINE_BUTTONS == 0)
        {
            x = 0;
            y += BUTTON_HEIGHT;
        }
        NSDictionary *dict = [self.subArray objectAtIndex: index];

        // 设置按钮背景图片
        [button setBackgroundImage: [UIImage imageNamed: [dict objectForKey: @"image"]] forState: UIControlStateNormal];
        
        // 设置字体大小
        button.titleLabel.font = [UIFont systemFontOfSize: 11.0];
        
        // 设置标题
        [button setTitle: [dict objectForKey: @"name"] forState: UIControlStateNormal];
        
        // 标题颜色
        [button setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
        
        // 标题偏移
        [button setTitleEdgeInsets: UIEdgeInsetsMake(0, 0, -60, 0)];
        
        // 发光效果
        button.showsTouchWhenHighlighted = YES;
        
        // 添加事件
        [button addTarget: self action: @selector(onClick:) forControlEvents: UIControlEventTouchUpInside];
        
        // 设置标记
        button.tag = index + TAG;
        [self.contentView addSubview: button];
    }
}

- (void) onClick: (UIButton *)sender
{
    if (self.delegate != nil && [self.delegate respondsToSelector: @selector(selectWeb:)] == YES)
    {
        NSDictionary *dict = [self.subArray objectAtIndex: (sender.tag - TAG)];
        [self.delegate selectWeb: [dict objectForKey: @"url"]];
    }
}
@end
