//
//  JXSecHelpCenterViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/10/16.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXSecHelpCenterViewController.h"

@interface JXSecHelpCenterViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *myWeb;

@end

@implementation JXSecHelpCenterViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"内容";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    
    [self.view setBackgroundColor:kUIColorFromRGB(0xffffff)];
    [self layoutTempTableView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}
- (void)leftAction:(UIBarButtonItem *)sender  {
    if ([_refweb respondsToSelector:@selector(refreshWeb)]) {
        [_refweb refreshWeb];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)layoutTempTableView
{
#pragma mark --- web
    self.myWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, NPWidth,NPHeight)];
    [self.view addSubview:_myWeb] ;
    self.myWeb.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_weburl]];
    [self.myWeb loadRequest:request];
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
