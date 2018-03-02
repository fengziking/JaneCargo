//
//  JXIntroduceViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/18.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXIntroduceViewController.h"
#define TITLE_H 0
#define LINE_H 1.5
@interface JXIntroduceViewController ()<UIWebViewDelegate>
//@property (nonatomic,strong)JSContext *jsCondex;
@property (nonatomic, strong)UIWebView *myWeb;
@property (nonatomic, assign)BOOL is_first;


/*
 * 内容 webView
 */
//@property(strong, nonatomic) WKWebView * wkWebView_h;
//@property (nonatomic, strong) WKWebViewConfiguration *wkConfig_h;


@end

@implementation JXIntroduceViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self.view setFrame:CGRectMake(0, 0, NPWidth, NPHeight)];
    [self layoutTempTableView];
    KDLOG(@"%@",_goods_id)
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
//    if (_is_first) {
//        
//    }else {
//        
//        [self layoutTempTableView];
//    }
    
}


- (void)layoutTempTableView
{
    KDLOG(@"%@",_goods_id);
#pragma mark --- web
    self.myWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, NPWidth,NPHeight)];
    [self.view addSubview:_myWeb] ;
    self.myWeb.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://app.1jzhw.com/api/index/product_detail?id=%@",_goods_id]]];
    [self.myWeb loadRequest:request];
}

//- (void)viewDidAppear:(BOOL)animated {
    
   // [super viewDidAppear:animated];
   // NSLog(@"商品的id%@",self.goods_id);
   // [self setGoodsId:self.goods_id];
///}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
//}

//开始加载
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
  //  NSLog(@"开始加载网页");
//}

//加载完成
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
  //  NSLog(@"加载完成");
    
///}

//加载失败
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
  //  NSLog(@"加载失败");
//}

//与h5交互，回来这里的方法，根据返回的字段进行一些操作。
//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
//{
    
  //  NSDictionary *dic_zf = [NSDictionary dictionary];
  //  if ([message.body isKindOfClass:[NSDictionary class]]) {
   //     dic_zf = message.body;
  //  }else
  //  {
  //      dic_zf = [self dictionaryWithJsonString:message.body];
   // }
   // if ([message.name isEqualToString:@"gotoChatTrust"]) {
   //     NSLog(@"加载失败");
   // }
//}

//- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
  //  if (jsonString == nil) {
   //     return nil;
  //  }
 //   NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    //    NSError *err;
  //  KDLOG(@"jsonData===%@",jsonData);
  //  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData

   //                                                     options:NSJSONReadingMutableContainers
                         
    //                                                      error:nil];
  //  KDLOG(@"dic===%@",dic);
  //  return dic;
//}

#pragma mark - start load web
//-(void)setGoodsId:(NSString *)goodsId
//{
    
    
  //  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://app.1jzhw.com/api/index/product_detail?id=%@",goodsId]]];
    
   // request.timeoutInterval = 15.0f;
   // [self.wkWebView_h loadRequest:request];
    
//}

#pragma mark- 下拉监听
//-(void)dropDownAction
//{
    //结束下拉
 //   [self.wkWebView_h.scrollView.mj_header endRefreshing];
//    if ([self.delegate respondsToSelector:@selector(XWPhotoWebViewDropdown:)]) {
//        
//        if (self.Yesdrop==YES) {
//            
//            [self.delegate XWPhotoWebViewDropdown:self];
//        }
//        
//    }
//}

//- (WKWebView *)wkWebView_h {
    
//    if (!_wkWebView_h) {
        
 //       _wkWebView_h = [[WKWebView alloc] initWithFrame:CGRectMake(0, TITLE_H, NPWidth, NPHeight-TITLE_H-64-50-44) configuration:self.wkConfig_h];
 //       _wkWebView_h.navigationDelegate = self;
  //      _wkWebView_h.UIDelegate = self;
 //       [self.view addSubview:_wkWebView_h];
        //添加下拉刷新控件
 //       _wkWebView_h.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock: ^ {
            //进入刷新状态后会自动调用这个块
  //          [self dropDownAction];
 //       }];
 //   }
 //   return _wkWebView_h;
//}
//- (WKWebViewConfiguration *)wkConfig_h {
   // if (!_wkConfig_h) {
   //     _wkConfig_h = [[WKWebViewConfiguration alloc] init];
    //    _wkConfig_h.allowsInlineMediaPlayback = YES;
    //    _wkConfig_h.allowsPictureInPictureMediaPlayback = YES;
    //    //实例化对象
   //     _wkConfig_h.userContentController = [WKUserContentController new];
        //调用JS方法
   //     [_wkConfig_h.userContentController addScriptMessageHandler:self name:@"gotoChatTrust"];
//    }
   // return _wkConfig_h;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
