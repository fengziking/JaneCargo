//
//  JXWebAgreementViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/10/14.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXWebAgreementViewController.h"

@interface JXWebAgreementViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *myWeb;

@end

@implementation JXWebAgreementViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    
    if (_retweetType == RegisteredAgreement) {
        titleLabel.text = @"注册协议";
        [self layoutTempTableView:@"http://app.1jzhw.com/api/index/xy"];
    }else if (_retweetType == PrivacyAgreement) {
        titleLabel.text = @"隐私协议";
        [self layoutTempTableView:@"http://app.1jzhw.com/api/index/ys"];
    }else if (_retweetType == StatementAgreement) {
        titleLabel.text = @"特别声明";
        [self layoutTempTableView:@"http://app.1jzhw.com/api/index/orderFlow/id/44"];
    }else if (_retweetType == authenticationAgreement) {
        [self layoutTempTableView:@"http://app.1jzhw.com/api/index/sm"];
    }
    self.navigationItem.titleView = titleLabel;
    [self.view setBackgroundColor:kUIColorFromRGB(0xffffff)];
}


- (void)leftAction:(UIBarButtonItem *)sender  {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)layoutTempTableView:(NSString *)web
{
#pragma mark --- web
    self.myWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, NPWidth,NPHeight)];
    [self.view addSubview:_myWeb] ;
    self.myWeb.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:web]];
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
