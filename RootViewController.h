//
//  RootViewController.h
//  Tmall
//
//  Created by huangxiong on 14-7-30.
//  Copyright (c) 2014年 New-Life. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomCell.h"

#import "HeadView.h"

@interface RootViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, HeadViewDelegate, CustomCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *listAllData;

// 保存当前节
@property (nonatomic, assign) NSInteger currentSection;

// 保存所有的 headView用
@property (nonatomic, strong) NSMutableArray *headViews;

// 保存头视图
- (void) loadHeadView;

@end
