//
//  JXBulkTViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/9/29.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXBulkTViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface JXBulkTViewController ()<UIWebViewDelegate,TencentSessionDelegate,QQApiInterfaceDelegate>

@property (nonatomic,strong)JSContext *jsCondex;
@property (nonatomic, strong)UIWebView *myWeb;
// qq分享
@property (nonatomic, strong) TencentOAuth *tencentOAuth;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation JXBulkTViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
    
}



#pragma mark --- QQ分享 0-朋友 1-QQ空间
// 发送图片文字链接
- (void)showMediaNewsWithScene:(int)scene {
    
    if (![TencentOAuth iphoneQQInstalled]) {
        NSLog(@"请移步App Store去下载腾讯QQ客户端");
    }else {
        self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"101411755"
                                                    andDelegate:self];
        QQApiNewsObject *newsObj = [QQApiNewsObject
                                    objectWithURL:[NSURL URLWithString:@"www.baidu.com"]
                                    title:@"小萌妹"
                                    description:@"周小曼萌萌哒----"
                                    previewImageURL:[NSURL URLWithString:@""]];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        if (scene == 0) {
            NSLog(@"QQ好友列表分享 - %d",[QQApiInterface sendReq:req]);
        }else if (scene == 1){
            NSLog(@"QQ空间分享 - %d",[QQApiInterface SendReqToQZone:req]);
        }
    }
}

#pragma mark -- QQApiInterfaceDelegate
// 处理来自QQ的请求，调用sendResp
- (void)onReq:(QQBaseReq *)req {
    
}

// 处理来自QQ的响应，调用sendReq
- (void)onResp:(QQBaseReq *)resp {
    switch (resp.type)
    {
        case ESENDMESSAGETOQQRESPTYPE:
        {
            SendMessageToQQResp* sendResp = (SendMessageToQQResp*)resp;
            if ([sendResp.result isEqualToString:@"0"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"QQ分享成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败" message:@"QQ分享失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            break;
        }
        default:
        {
            break;
        }
    }
}
// 处理QQ在线状态的回调
- (void)isOnlineResponse:(NSDictionary *)response {
    
}



#pragma mark --- 微信分享 发送图片文字链接
- (void)SendTextImageLink { // 图片小于32K 链接小于10K
    if (![WXApi isWXAppInstalled]) {
        NSLog(@"请移步App Store去下载微信客户端");
    }else {
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        sendReq.bText = NO;
        sendReq.scene = 1;
        // 2.创建分享内容
        WXMediaMessage *message = [WXMediaMessage message];
        //分享标题
        message.title = @"周小曼";
        // 描述
        message.description = @"周小曼傻傻傻萌萌萌的测试哦";
        //分享图片,使用SDK的setThumbImage方法可压缩图片大小
        [message setThumbImage:[UIImage imageNamed:@"1"]];
        //创建多媒体对象
        WXWebpageObject *webObj = [WXWebpageObject object];
        // 点击后的跳转链接
        webObj.webpageUrl = @"www.baidu.com";
        message.mediaObject = webObj;
        sendReq.message = message;
        [WXApi sendReq:sendReq];
    }
}


- (void)sendText {
    if (![WXApi isWXAppInstalled]) {
        NSLog(@"请移步App Store去下载微信客户端");
    }else {
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        sendReq.bText = YES;//YES表示使用文本信息 NO表示不使用文本信息
        sendReq.text = @" 周小曼傻傻傻萌萌萌的测试哦";
        // 0：分享到好友列表 1：分享到朋友圈  2：收藏
        sendReq.scene = 1;
        
        //发送分享信息
        [WXApi sendReq:sendReq];
        
        // 返回分享成功还是失败
        NSLog(@" 成功和失败 - %d",[WXApi sendReq:sendReq]);
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[].mutableCopy;
    [self.dataArray addObject:_gooddic];
    [self.view setBackgroundColor:kUIColorFromRGB(0xffffff)];
    [self layoutTempTableView];
    [self aboutNagivation];
}

- (void)aboutNagivation {
    
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
        
        self.jsCondex[@"join_team"] = ^(){ // 到结账页面
            
            JXInvoicingViewController *invoicing = [[JXInvoicingViewController alloc] init];
            invoicing.hidesBottomBarWhenPushed = true;
            invoicing.dateArray = root.dataArray;
            invoicing.totalNum = 100;
            invoicing.goodsNumber = 1;
            [root.navigationController pushViewController:invoicing animated:YES];
            
        };
        
        
    });
}

@end
