//
//  JXBulkSecondViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/9/28.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXBulkSecondViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JXBulkTViewController.h"
@interface JXBulkSecondViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)JSContext *jsCondex;
@property (nonatomic, strong)UIWebView *myWeb;

@end

@implementation JXBulkSecondViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:kUIColorFromRGB(0xffffff)];
    [self layoutTempTableView];
    [self aboutNagivation];
}

- (void)aboutNagivation {// 精品团购 团购详细
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"团购详细";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}


- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)layoutTempTableView
{
#pragma mark --- web
    self.myWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, NPWidth,NPHeight-64)];
    [self.view addSubview:_myWeb] ;
    self.myWeb.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl]];
    [self.myWeb loadRequest:request];
}

#pragma mark --- web代理
- (void)webViewDidStartLoad:(UIWebView *)webView { // http://h5.imchumo.com/lp-ios-h5-msc/mj/money.html   gotoChattingService
    // http://app.1jzhw.com/api/index/groupon
    dispatch_async(dispatch_get_main_queue(), ^{
        //首先创建JSContext 对象
        
        __weak typeof(self) root = self;
        self.jsCondex = [self.myWeb valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        self.jsCondex[@"go_team"] = ^(NSString *status){ // 到结账页面
            KDLOG(@"%@",status);
        };
        
        self.jsCondex[@"go_shopping"] = ^(NSString*good_id){  // 商品详情页
            
            ViewGoodsdetailsController *jxorder = [[ViewGoodsdetailsController alloc] init];
            jxorder.goodsid = [NSNumber numberWithInteger:[good_id integerValue]];
            [root.navigationController pushViewController:jxorder animated:YES];
        };
        
        self.jsCondex[@"group_team"] = ^(NSString *uan_id,NSString*good_dic,NSString*weburl){ // 进入下一页
            
            NSDictionary *wxpaydic = [root parseJSONStringToNSDictionary:good_dic];
            JXBulkTViewController *second = [[JXBulkTViewController alloc] init];
            second.webUrl = weburl;
            second.gooddic = wxpaydic;
            second.tuanid = uan_id;
            [root.navigationController pushViewController:second animated:YES];
        };
        
        
    });
}

-(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}
- (NSString *)dictionaryToJson:(NSDictionary *)dic {  // json
    
    NSError *error = nil;
    NSData *policyData = [NSJSONSerialization dataWithJSONObject:dic options:kNilOptions error:&error];
    if(!policyData && error){
        NSLog(@"Error creating JSON: %@", [error localizedDescription]);
        return [error localizedDescription];
    }
    NSString  *policyStr = [[NSString alloc] initWithData:policyData encoding:NSUTF8StringEncoding];
    return [policyStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
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
