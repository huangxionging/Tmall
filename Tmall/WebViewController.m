//
//  WebViewController.m
//  Tmall
//
//  Created by huangxiong on 14-7-31.
//  Copyright (c) 2014年 New-Life. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.webView = [[UIWebView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];

    // 加载到视图上
    [self.view addSubview: self.webView];
    
    // 地址
    NSURL *url = [NSURL URLWithString: self.urlPath];
    
    // 请求
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    
    [self.webView loadRequest: request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
