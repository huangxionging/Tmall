//
//  CustomCell.h
//  Tmall
//
//  Created by huangxiong on 14-7-30.
//  Copyright (c) 2014年 New-Life. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义按钮的宽度和高度
#define BUTTON_WIDTH (80)
#define BUTTON_HEIGHT (80)

// 定义标记
#define TAG (1000)

// 定义一行按钮个数
#define ONE_LINE_BUTTONS (4)

// 代理协议
@protocol CustomCellDelegate;

@interface CustomCell : UITableViewCell

// 用于提供按钮上所需的文字、图像信息等等
@property (nonatomic, strong) NSArray *subArray;

// 用于保存单元格的大小
@property (nonatomic, assign) CGSize size;

// 代理
@property (nonatomic, strong) id<CustomCellDelegate> delegate;

- (void) setCustomCell;

@end


// 代理协议
@protocol CustomCellDelegate <NSObject>

@required

- (void)selectWeb: (NSString *)urlPath;

@end
