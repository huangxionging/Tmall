//
//  RootViewController.m
//  Tmall
//
//  Created by huangxiong on 14-7-30.
//  Copyright (c) 2014年 New-Life. All rights reserved.
//

#import "RootViewController.h"
#import "WebViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.headViews = [NSMutableArray arrayWithCapacity: 14];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource: @"items" ofType: @"plist"];
    self.listAllData = [NSArray arrayWithContentsOfFile: plistPath];
    
    self.navigationItem.title = @"分类导航";
    
    self.tableView = [[UITableView alloc] initWithFrame: self.view.frame style: UITableViewStylePlain];
    
    // 不要反弹效果
    self.tableView.bounces = NO;
    
    // 不要指示器
    //self.tableView.showsVerticalScrollIndicator = NO;
    
    // 设置减速速度
    //self.tableView.decelerationRate = 0.1;

    [self.view addSubview: self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self loadHeadView];
}


- (void) loadHeadView
{
    NSInteger maxLen = [self.listAllData count];
    
    for (NSInteger index = 0; index < maxLen; ++index)
    {
        HeadView *headView = [[HeadView alloc] init];
        headView.imageName = [[self.listAllData objectAtIndex:index] objectForKey: @"image"];
        headView.titleName = [[self.listAllData objectAtIndex: index] objectForKey: @"name"];
       
        headView.section = index;
        headView.isOpen = NO;
        [headView setAll];
        headView.delegate = self;
        [self.headViews addObject: headView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --UITableViewDelegate

// 为每一节添加头视图
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self.headViews objectAtIndex: section];
}

// 头高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return headViewHeight;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 40;
    }
    NSInteger count = [[[self.listAllData objectAtIndex: indexPath.section] objectForKey: @"subArray"] count];
    NSInteger height = ((count - 1) / ONE_LINE_BUTTONS + 1) * BUTTON_HEIGHT;
    return height;
}

// 表尾高度
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 3;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        WebViewController *webViewController = [[WebViewController alloc] init];
        webViewController.urlPath = [[self.listAllData objectAtIndex: indexPath.section] objectForKey: @"url"];
        [self.navigationController pushViewController: webViewController animated: NO];
    }
}

#pragma mark --UITableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (((HeadView *)[self.headViews objectAtIndex: section]).isOpen == YES)
    {
        return 2;
    }
    else
    {
        return 0;
    }
}

// 节数
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.listAllData count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID0 = @"CELL0";
    static NSString *cellID1 = @"CELL1";
    
    CustomCell *cell = nil;
    if (indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier: cellID0];
        
        if (cell == nil)
        {
            cell = [[CustomCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellID0];
        }
        
        cell.textLabel.text = @"进入主页";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
    
    cell = [tableView dequeueReusableCellWithIdentifier: cellID1];
    
    if (cell == nil)
    {
        cell = [[CustomCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellID1];
    }

    // 设置代理
    cell.delegate = self;
    
    // 获取子数组
    cell.subArray = [[self.listAllData objectAtIndex: indexPath.section] objectForKey: @"subArray"];
    
    // 高度
    NSInteger height = (([cell.subArray count] - 1) / ONE_LINE_BUTTONS + 1) * BUTTON_HEIGHT;
    
    // 大小
    cell.size = CGSizeMake(self.tableView.frame.size.width, height);

    // 重新设置 cell的内容
    [cell setCustomCell];
    
    return cell;
}


#pragma mark --HeadViewDelegate
- (void) selected:(HeadView *)headView
{
    // 点击的不是同一行
    if (self.currentSection != headView.section)
    {
        // 改透明度
        ((HeadView *)[self.headViews objectAtIndex: self.currentSection]).button.alpha = 0.55;
        
        // 折叠起来
        ((HeadView *)[self.headViews objectAtIndex: self.currentSection]).isOpen = NO;
        
        // 修改当前节
        self.currentSection = headView.section;
        
        // 被选中的节不折叠
        headView.isOpen = YES;
        
        // 透明度最高
        headView.button.alpha = 1.0;
        
        // 滚动视图重新加载数据
        [self.tableView reloadData];
        
        // 滚动到指定点
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow: 0 inSection: headView.section] atScrollPosition: UITableViewScrollPositionMiddle animated:YES];
        
        return;
    }
    
    // 点击相同按钮
    headView.button.alpha = 1.0;
    if (headView.isOpen == NO)
    {
        headView.isOpen = YES;
        
        // 重新加载数据
        [self.tableView reloadData];
        
        // 滚动视图
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow: 0 inSection: headView.section] atScrollPosition: UITableViewScrollPositionTop animated:YES];
        return;
    }
    
    // 如果是yes则改为no
    headView.isOpen = NO;
    
    // 重新加载数据
    [self.tableView reloadData];
    
    // 滚动视图
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow: -1 inSection: headView.section] atScrollPosition: UITableViewScrollPositionMiddle animated:YES];
}

#pragma mark --CustomCellDelegate
- (void) selectWeb:(NSString *)urlPath
{
    WebViewController *webViewController = [[WebViewController alloc] init];
    webViewController.urlPath = urlPath;
    [self.navigationController pushViewController: webViewController animated: NO];
}

@end
