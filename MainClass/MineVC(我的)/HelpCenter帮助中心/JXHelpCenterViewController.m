//
//  JXHelpCenterViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/10/12.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXHelpCenterViewController.h"
#import "JXSecHelpCenterViewController.h"
@interface JXHelpCenterViewController ()<UIWebViewDelegate,RefreshWebdelegate>
@property (nonatomic, strong)UIWebView *myWeb;
@end

@implementation JXHelpCenterViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"帮助中心";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    
    [self.view setBackgroundColor:kUIColorFromRGB(0xffffff)];
    [self layoutTempTableView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}
- (void)leftAction:(UIBarButtonItem *)sender  {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)layoutTempTableView
{
#pragma mark --- web
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.myWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, NPWidth,NPHeight-64)];
    [self.view addSubview:_myWeb] ;
    self.myWeb.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://app.1jzhw.com/api/index/helper"]];
    [self.myWeb loadRequest:request];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ====== web代理 ======
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //获取当前网页的url
    NSString *urlStr = [request.URL absoluteString];
    if (![urlStr isEqualToString:@"http://app.1jzhw.com/api/index/helper"]) {
        NSString *info = [[UIDevice currentDevice] name];
        NSString *js = [NSString stringWithFormat:@"showInfo(\"name\",\"%@\")",info];
        
        [self.myWeb stringByEvaluatingJavaScriptFromString:js];
        JXSecHelpCenterViewController *secweb = [[JXSecHelpCenterViewController alloc] init];
        secweb.refweb = self;
        secweb.weburl = urlStr;
        [self.navigationController pushViewController:secweb animated:YES];
    }
    KDLOG(@"%@",urlStr);
    return YES;
}
- (void)refreshWeb {

    [self layoutTempTableView];
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
