//
//  JXWebPushViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/10/13.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXWebPushViewController.h"

@interface JXWebPushViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *myWeb;
@end

@implementation JXWebPushViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self y_navigation];
    [self layoutTempTableView];
}
- (void)y_navigation {
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"消息";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    
}
- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)layoutTempTableView
{
#pragma mark --- web
    self.myWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, NPWidth,NPHeight)];
    [self.view addSubview:_myWeb] ;
    self.myWeb.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_web_url]];
    [self.myWeb loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
