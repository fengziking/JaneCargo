//
//  JXBulkViewController.m
//  JaneCargo
//
//  Created by 鹏 on 17/6/23.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXBulkViewController.h"
#import "JXBulkSecondViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface JXBulkViewController ()<UIWebViewDelegate>
@property (nonatomic,strong)JSContext *jsCondex;
@property (nonatomic, strong)UIWebView *myWeb;

@end

@implementation JXBulkViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"精品团购";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    
    [self.view setBackgroundColor:kUIColorFromRGB(0xffffff)];
    [self layoutTempTableView];
}

- (void)layoutTempTableView
{
#pragma mark --- web
    self.myWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, NPWidth,NPHeight)];
    [self.view addSubview:_myWeb] ;
    self.myWeb.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://app.1jzhw.com/api/index/groupon"]];
    [self.myWeb loadRequest:request];
}

#pragma mark --- web代理
- (void)webViewDidStartLoad:(UIWebView *)webView { // http://h5.imchumo.com/lp-ios-h5-msc/mj/money.html   gotoChattingService
    // http://app.1jzhw.com/api/index/groupon
    dispatch_async(dispatch_get_main_queue(), ^{
        //首先创建JSContext 对象
        
        __weak typeof(self) root = self;
        self.jsCondex = [self.myWeb valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        
        
        self.jsCondex[@"url_fun"] = ^(NSString *msg){ // 通过h5的字段获取对应的参数
            NSLog(@"111%@",msg);
            JXBulkSecondViewController *second = [[JXBulkSecondViewController alloc] init];
            second.webUrl = msg;
            [root.navigationController pushViewController:second animated:YES];
        };
        
    });
}

+ (NSString *)dictionaryToJson:(NSDictionary *)dic {  // json
    
    NSError *error = nil;
    NSData *policyData = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:&error];
    if(!policyData && error){
        NSLog(@"Error creating JSON: %@", [error localizedDescription]);
        return [error localizedDescription];
    }
    NSString  *policyStr = [[NSString alloc] initWithData:policyData encoding:NSUTF8StringEncoding];
    return [policyStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //此处写刚刚贴的JSContext代码
    //加上这句
    [webView stringByEvaluatingJavaScriptFromString:@"javaCallback()"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
