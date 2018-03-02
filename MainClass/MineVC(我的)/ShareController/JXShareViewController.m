//
//  JXShareViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2018/1/25.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import "JXShareViewController.h"
#import "JXShareTableViewCellf.h"
#import "JXShareTableViewCells.h"
#import "JXShareTableViewCellbt.h"
#import "JXShareUrlView.h"
#import "JXTransparentView.h"
@interface JXShareViewController ()<UITableViewDataSource,UITableViewDelegate,TencentSessionDelegate,QQApiInterfaceDelegate>
@property (nonatomic, strong) UITableView *manageTable;
@property (nonatomic, strong) NSMutableArray *dataAarry;
@property (nonatomic, strong) JXShareUrlView *shareview;
// 遮罩
@property (nonatomic, strong) JXTransparentView *showmask;
// qq分享
@property (nonatomic, strong) TencentOAuth *tencentOAuth;
@property (nonatomic, strong) NSString *shareUrls;

@end

@implementation JXShareViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataAarry = @[].mutableCopy;
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"分享有礼";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    [self layoutTempTable];
    [self requestdata];
    
}


- (void)requestdata {
    
    [JXNetworkRequest asyncShareUrlcompleted:^(NSDictionary *messagedic) { // is_dl 0 未付款 1 已付款
        
        JXHomepagModel *model = [[JXHomepagModel alloc] init];
        [model setValuesForKeysWithDictionary:messagedic[@"info"]];
        [self.dataAarry addObject:model];
        [_manageTable reloadData];
        _shareUrls = messagedic[@"info"][@"url"];
        
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
}


- (void)leftAction:(UIBarButtonItem *)sender  {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)layoutTempTable {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _manageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, NPWidth, NPHeight)];
    _manageTable.separatorStyle = UITableViewCellEditingStyleNone;
    _manageTable.delegate = self;
    _manageTable.dataSource = self;
    _manageTable.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    [_manageTable setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:_manageTable];
    if (@available(iOS 11.0, *)) {
        _manageTable.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        _manageTable.contentInset =UIEdgeInsetsMake(0,0,64,0);//64和49自己看效果，是否应该改成0
        _manageTable.scrollIndicatorInsets =_manageTable.contentInset;
    }
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"JXShareUrlView" owner:nil options:nil];
    self.shareview = [nibContents lastObject];
    self.shareview.frame = CGRectMake(0, NPHeight, [[UIScreen mainScreen] bounds].size.width, 145);
    [self.shareview setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.shareview];
    __weak typeof(self)root = self;
    self.shareview.ShareFriendblock = ^(NSInteger index) {
        [root shareFriendIndex:index];
    };
    
}

// 0 微信 1朋友圈 2qq
- (void)shareFriendIndex:(NSInteger)index {
    
    switch (index) {
        case 0:
            {
                [self SendTextImageLink:0];
            }
            break;
        case 1:
        {
             [self SendTextImageLink:1];
        }
            break;
        case 2:
        {
            [self showMediaNewsWithScene:0];
        }
            break;
        default:
            break;
    }
    
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
                                    objectWithURL:[NSURL URLWithString:_shareUrls]
                                    title:@"分享有礼"
                                    description:@"邀请用户/商家，佣金返还"
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
- (void)SendTextImageLink:(int)index { // 图片小于32K 链接小于10K
    if (![WXApi isWXAppInstalled]) {
        NSLog(@"请移步App Store去下载微信客户端");
    }else {
        
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        sendReq.bText = NO;
        sendReq.scene = index;
        // 2.创建分享内容
        WXMediaMessage *message = [WXMediaMessage message];
        //分享标题
        message.title = @"分享有礼";
        // 描述
        message.description = @"邀请用户/商家，佣金返还";
        //分享图片,使用SDK的setThumbImage方法可压缩图片大小
        [message setThumbImage:[UIImage imageNamed:@"1"]];
        //创建多媒体对象
        WXWebpageObject *webObj = [WXWebpageObject object];
        // 点击后的跳转链接
        webObj.webpageUrl = _shareUrls;
        message.mediaObject = webObj;
        sendReq.message = message;
        [WXApi sendReq:sendReq];
    }
}


- (void)sendText:(int)index {
    if (![WXApi isWXAppInstalled]) {
        NSLog(@"请移步App Store去下载微信客户端");
    }else {
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        sendReq.bText = YES;//YES表示使用文本信息 NO表示不使用文本信息
        sendReq.text = @"邀请用户/商家，佣金返还";
        // 0：分享到好友列表 1：分享到朋友圈  2：收藏
        sendReq.scene = index;
        //发送分享信息
        [WXApi sendReq:sendReq];
        
        // 返回分享成功还是失败
        NSLog(@" 成功和失败 - %d",[WXApi sendReq:sendReq]);
    }
}



#pragma mark ---- table代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0)
    {
        JXShareTableViewCellf *cell = [JXShareTableViewCellf cellwithTable];
        cell.ShareUrlblock = ^{
            [self showshareView];
        };
        if (self.dataAarry.count>0) {
            [cell setModel:self.dataAarry[indexPath.section]];
        }
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        JXShareTableViewCells *cell = [JXShareTableViewCells cellwithTable];
        if (self.dataAarry.count>0) {
            [cell setModel:self.dataAarry[0]];
        }
        return cell;
    }
    else
    {
        JXShareTableViewCellbt *cell = [JXShareTableViewCellbt cellwithTable];
        if (self.dataAarry.count>0) {
            [cell setModel:self.dataAarry[0]];
        }
        cell.Paychose = ^{
            [self alerPay];
        };
        
        return cell;
    }
}

- (void)showshareView {
    
    self.showmask = [JXTransparentView showMaskViewWith:^{
        self.shareview.frame = CGRectMake(0, NPHeight, [[UIScreen mainScreen] bounds].size.width, 145);
        
    }];
    self.showmask.backgroundColor = [UIColor blackColor];
    self.showmask.alpha = 0.5f;
    [self.view addSubview:self.showmask];
    [UIView animateWithDuration:0.5 animations:^{
        self.shareview.frame = CGRectMake(0, NPHeight-145, [[UIScreen mainScreen] bounds].size.width, 145);
    }];
    
    [self.view bringSubviewToFront:_shareview];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 200;
    }else if (indexPath.section == 1)
    {
        return 260+15;
    }
    else
    {
        return 70;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 2) {
        return 80;
    }else{
        return 0;
    }
    
}



- (void)alerPay {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil  message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction: [UIAlertAction actionWithTitle:@"支付宝" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self requestPay:@"1"];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle:@"微信" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self requestPay:@"2"];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:nil]];
    [self presentViewController: alertController animated: YES completion: nil];
    
}

- (void)requestPay:(NSString *)payid {
    
    [JXNetworkRequest asyncSharepay:payid completed:^(NSDictionary *messagedic) {
        if ( [payid isEqualToString:@"1"]) {
            [self zfPay:messagedic[@"info"][@"info"]];
        }else if ([payid isEqualToString:@"2"]){
            NSDictionary *wxpaydic = [self parseJSONStringToNSDictionary:messagedic[@"info"][@"info"]];
            [self wxPay:wxpaydic];
        }else {
            [self showHint:messagedic[@"msg"]];
        }
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
    
}
-(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}
#pragma mark -- 支付 1支付宝 2微信
- (void)zfPay:(NSString *)orderString {
    
    NSString *appScheme = @"alisdkdemo";
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        switch ([resultDic[@"resultStatus"] intValue]) {
            case 9000:
            {
                [self showHint:@"支付成功"];
            }
                break;
            case 8000:
            {
                [self showHint:@"正在处理中"];
            }
                break;
            case 4000:
            {
                [self showHint:@"支付失败"];
            }
                break;
            case 6001:
            {
                [self showHint:@"取消支付"];
            }
                break;
            case 6002:
            {
                [self showHint:@"网络连接错误"];
            }
                break;
            default:
                break;
        }
    }];
    
}

- (void)wxPay:(NSDictionary *)response {
    
    if (![WXApi isWXAppInstalled]) { // 检测用户是否安装微dateArray信
        
        [self showHint:@"未安装微信"];
        
    }else {
        
        PayReq *req  = [[PayReq alloc] init];
        req.partnerId = [response objectForKey:@"partnerid"];
        req.prepayId = [response objectForKey:@"prepayid"];
        req.package = [response objectForKey:@"package"];
        req.nonceStr = [response objectForKey:@"noncestr"];
        req.timeStamp = [[response objectForKey:@"timestamp"]intValue];
        req.sign = [response objectForKey:@"sign"];
        //调起微信支付
        [WXApi sendReq:req];
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
