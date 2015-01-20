//
//  HeadView.h
//  Tmall
//
//  Created by huangxiong on 14-7-31.
//  Copyright (c) 2014年 New-Life. All rights reserved.
//

#import <UIKit/UIKit.h>


// 写成 static 避免重复定义, 如果有多个地方包含这个头文件，不加static就会重复定义
// 或者使用宏定义也 😄 阔以得嘞
static const CGFloat headViewWidth = 320.0f;

static const CGFloat headViewHeight = 80.0f;

@protocol HeadViewDelegate;

@interface HeadView : UIView

// 表示透视图所在的节是否打开
@property (nonatomic, assign) BOOL isOpen;

// 按钮图片的名字
@property (nonatomic, strong) NSString *imageName;

// 标题
@property (nonatomic, strong) NSString *titleName;

// 按钮
@property (nonatomic, strong) UIButton *button;

// 标签提示
@property (nonatomic, strong) UILabel *label;


// 代理
@property (nonatomic, strong) id<HeadViewDelegate> delegate;

// 表示是第几节的头
@property (nonatomic, assign) NSInteger section;


// 设置头视图
- (void) setAll;

// 响应按钮的动作
- (void) onClickButton:(id) sender;

@end

// 代理协议
@protocol HeadViewDelegate <NSObject>

@optional

- (void) selected: (HeadView *) headView;

@end
