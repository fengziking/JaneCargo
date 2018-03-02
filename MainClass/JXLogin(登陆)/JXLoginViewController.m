//
//  JXLoginViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/20.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXLoginViewController.h"
#import "JXForgerPasswordViewController.h"
#import "JXRegisteredViewController.h"


@interface JXLoginViewController ()<UITextFieldDelegate,RegisteredDelegate,TencentSessionDelegate>  {

    NSString *_accountStr;
    NSString *_passWordStr;
    TencentOAuth *tencentOAuth; // QQ第三方
    NSArray *permissions;
}

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UIButton *eyebt;
@property (weak, nonatomic) IBOutlet UIImageView *eyeImage;
@property (weak, nonatomic) IBOutlet UIButton *forgetPassWordbt;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registeredButton;
@property (weak, nonatomic) IBOutlet UIButton *qqbutton;
@property (weak, nonatomic) IBOutlet UIButton *wxbutton;
@property (weak, nonatomic) IBOutlet UIButton *zfbutton;
@property (weak, nonatomic) IBOutlet UIView *linef;
@property (weak, nonatomic) IBOutlet UIView *lines;
@property (weak, nonatomic) IBOutlet UILabel *thirLabel;
@property (weak, nonatomic) IBOutlet UIView *linet;
@property (weak, nonatomic) IBOutlet UIView *linefo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *qqleft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zfright;
@property (weak, nonatomic) IBOutlet UILabel *errorMessagelabel;
// 旋转
//@property (nonatomic, strong) UIView *loading;
@property (nonatomic, strong) JXRotating *loading;
@property (weak, nonatomic) IBOutlet UIView *thirLoginView;


@end


@implementation JXLoginViewController


#pragma mark--- 点击显示密码
- (IBAction)eyeAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _passWordTextField.secureTextEntry = NO;
        [_eyeImage setImage:[UIImage imageNamed:@"icon_密码显示"]];
    }else {
        _passWordTextField.secureTextEntry = YES;
        [_eyeImage setImage:[UIImage imageNamed:@"icon_密码隐藏"]];
    }
}
#pragma mark--- 忘记密码
- (IBAction)forgetAction:(UIButton *)sender {
    
    JXForgerPasswordViewController *forget = [[JXForgerPasswordViewController alloc] init];
    [self.navigationController pushViewController:forget animated:YES];
    
}

#pragma mark--- 登录
- (IBAction)loginAction:(UIButton *)sender {

    self.loading = [JXRotating initWithRotaing];
    [self.view addSubview:self.loading];
    [JXNetworkRequest asyncUserLoginUsername:_accountStr password:_passWordStr completed:^(NSDictionary *messagedic) {
        
        // 保存sid
        [JXUserDefaultsObjc storageLoginUserSid:messagedic];
        [self.errorMessagelabel setText:@""];
        [self loginsuccessfully];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self.errorMessagelabel setText:messagedic[@"msg"]];
        [self.errorMessagelabel setTextColor:[UIColor redColor]];
    } fail:^(NSError *error) {
    }];
    
}

#pragma mark -- 注册
- (IBAction)registeredAction:(UIButton *)sender {
    
    JXRegisteredViewController *forget = [[JXRegisteredViewController alloc] init];
    forget.registeredelegate = self;
    [self.navigationController pushViewController:forget animated:YES];
    
}

#pragma mark -- QQ第三方登录点击
- (IBAction)qqAction:(UIButton *)sender {

    // QQ登录
    //这里的appid填写应用宝得到的id  记得修改 “TARGETS”一栏，在“info”标签栏的“URL type”添加 的“URL scheme”，新的scheme
    tencentOAuth=[[TencentOAuth alloc]initWithAppId:@"101411755" andDelegate:self];
    //4，设置需要的权限列表，此处尽量使用什么取什么。
    permissions= [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t",nil];
    [tencentOAuth authorize:permissions inSafari:NO];
   
}

#pragma mark -- qq TencentSessionDelegate  QQ登陆完成调用

- (void)tencentDidLogin
{
    if (tencentOAuth.accessToken && 0 != [tencentOAuth.accessToken length])
    {
        //  记录登录用户的OpenID、Token以及过期时间
        [tencentOAuth getUserInfo];
        KDLOG(@"openId:%@--accessToken:-%@",tencentOAuth.unionid,tencentOAuth.accessToken)
        [self thirtPatyOpenid:tencentOAuth.openId token:tencentOAuth.accessToken];
    }
    else
    {
        
    }
}

#pragma mark -- qq第三方登录
- (void)thirtPatyOpenid:(NSString *)openid token:(NSString *)token {
    
    [JXNetworkRequest asyncThirdPartyLoginToken:token openId:openid is_login:1 completed:^(NSDictionary *messagedic) {
        if ([messagedic[@"status"] integerValue] == 200) // 绑定过了
        { 
            // 注册成功改变登录状态
            [JXUserDefaultsObjc storageLoginUserSid:messagedic];
            [self loginsuccessfully];
        }else if ([messagedic[@"status"] integerValue] == 201) { // 未绑定
            
            // 记录sid
            JXBindingPhototNumberViewController *bing = [[JXBindingPhototNumberViewController alloc] init];
            bing.thitrLoginType = 1;
            bing.openId = openid;
            [self.navigationController pushViewController:bing animated:YES];
            
        }else { // 登录失败
            [self showHint:@"登录失败"];
        }
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
    
}





#pragma mark--- 非网络错误导致登录失败：
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    
    if (cancelled)
    {
        NSLog(@"用户取消登录");
        
    }else{
        
        NSLog(@"登录失败");
    }
}
// 网络错误导致登录失败：
-(void)tencentDidNotNetWork
{
    NSLog(@"tencentDidNotNetWork");
}



-(void)getUserInfoResponse:(APIResponse *)response
{
    NSLog(@"respons:%@",response.jsonResponse);
}



- (IBAction)wxAction:(UIButton *)sender {
    
   
    if ([WXApi isWXAppInstalled]) { // 检测用户是否安装微信
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"GSTDoctorApp";
        [WXApi sendReq:req];
    }
    else {
        NSLog(@"您还未安装微信");
    }
    
}

- (IBAction)zfAction:(UIButton *)sender {
    
    [self doAlipayAuth];
    
}


#pragma mark -
#pragma mark   ==============支付宝授权登录==============

- (void)doAlipayAuth
{
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *pid = @"2088721548390870";
    NSString *appID = @"2017072007820304";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIEpQIBAAKCAQEAw7C4O8bjzc20d6R/ZcsLLR9hmwpTYyIdBGtwyosq3FqD3FLNzDmFpV2br3pMt4dKn2NpX8XgnrYLc2olhpBArrYifRr21Rj6eaHP1zMfyh8lu97o2WPMIlw7qbfHcrYLwZmequ10Di6PrQEQETOTZ8xmCs5c7y6bsi05RU0tXTgfSm50OyEszVvCabNuhqcq6mMFGraF2yRph5F+UT9RaP7qUFys847cCHDvKA+vq2bwy5oNM2WsY6dJGWomezHUTHs0lwbv84TTWPOsEOgRla8F1yGfZ9xZ2EBGp1l08BnoiPdEXNKJU3NQqElPStX9TbC9UKnhhJKh9H86twwbGwIDAQABAoIBAQCf/L7iwDxGacL9fdNaGaJNhbZ61vpNtfobPuu77ANim+3qFxiBuxV0mQ9La6WE9msf3FquHk0B9Ltv5HxBg3YeYHHZ7k2W8xD0mEIgIn/+83AaJKgh8uFVxipRGxtIwWTjJwD9pZyYa6CzRIcqSQxedFGIzCZWtbg895Q3AF3yMx21PT5jW29/jnJFDT4VCcpMef06uLR2gWcFdikMbtbUQS9pe1cBn4PyZ2Jk8PVqOFflh4s7692PcJu81a/+fJZczuUS5OOBNdLg18Q3AtMFy8wPO3muq3Qh9aRJ0J1ROU9KrPxlMkfa6DcLzy8Yn2Gmlo7mgOI7PoOJ/rYWTMihAoGBAOlfrC7KTSBzsawmgl1ACnaQekSCfnYZ3zFPKRmz+PN5rDqsK1yI8zlWdbn0SHd9ydswTuGXQKNBqD3R/kZyuuVDB05nEDImQmQKrsdoLe040KlAACFDZmAL5eVWF2H8jMAKZkFOArY2Mw2He0wU+VBgMu1M5sQeIyJeNicZajj/AoGBANapvwYoybbebGezDeMcQuvcDtCC3LFd0uL87UOYoZv5uDpIihDsTm+tXAX+ujs9bfu4detb+OF6wmNDDqApRsS3l3nara91Q2i39nkknPfPhlgG/kjoBkYuO/Z8ci6dvzCd7WH+cIKSgBrSV0cADQ4jmG2L7vQPpWsFQX0qEeHlAoGBAN70Uxgkl4igXya7Z6JU82oQX28iSFTmJLAEE50FrppVLLClGYv/Hncx3aj4816NIxKv1Tx6dvtBV80v2MBPDbTH06wYlIWEvbq75fyF0BKpS9fWWAlvTdgGpezy0cYANCuoA8byE28m2qFbRPULuKAMN7sz0+ebby9/WDcEddHbAoGAJE1Cg70kF6vXs1XBdHXUD2UAkFyBC/Gs9zwEt9i5A9KgSCL6TlBYF2S+2jiwr9H8poQUVQARv7ft5bFyaL1yPVQ65p2Hn9N52dy6btQ1Q2cx9fMAz72FShsJgu6atK1yprseaOMJjdtOlLqbjeNBUfHNFkGC4H1A4S9bWtphec0CgYEAk6hNGHC/E2LuRsyZNM06oMmcsJhD06jF9sFETRzVcWuaOG+XuZLInXPlHNTUMZoktCVyxtRtbIZxKVskXxLCNKigysjU9T2AW8J9J1AZ4nlF3gWu/sDulbDNSIpBLqgpg4mdRr4SQx0JWfko/5GDPKiEkkvp+I5moRohk4kVQvc=";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //pid和appID获取失败,提示
    if ([pid length] == 0 ||
        [appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少pid或者appID或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    //生成 auth info 对象
    APAuthV2Info *authInfo = [APAuthV2Info new];
    authInfo.pid = pid;
    authInfo.appID = appID;
    
    //auth type
    NSString *authType = [[NSUserDefaults standardUserDefaults] objectForKey:@"authType"];
    if (authType) {
        authInfo.authType = authType;
    }
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    // 将授权信息拼接成字符串
    NSString *authInfoStr = [authInfo description];
    NSLog(@"authInfoStr = %@",authInfoStr);
    
    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:authInfoStr withRSA2:YES];
    } else {
        signedString = [signer signString:authInfoStr withRSA2:NO];
    }
    
    // 将签名成功字符串格式化为订单字符串,请严格按照该格式
    if (signedString.length > 0) {
        authInfoStr = [NSString stringWithFormat:@"%@&sign=%@&sign_type=%@", authInfoStr, signedString, ((rsa2PrivateKey.length > 1)?@"RSA2":@"RSA")];
        [[AlipaySDK defaultService] auth_V2WithInfo:authInfoStr
                                         fromScheme:appScheme
                                           callback:^(NSDictionary *resultDic) {
                                               NSLog(@"result = %@",resultDic);
                                               // 解析 auth code
                                               NSString *result = resultDic[@"result"];
                                               NSString *authCode = nil;
                                               if (result.length>0) {
                                                   NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                                                   for (NSString *subResult in resultArr) {
                                                       if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                                                           authCode = [subResult substringFromIndex:10];
                                                           break;
                                                       }
                                                   }
                                               }
                                               NSLog(@"授权结果 authCode = %@", authCode?:@"");
                                           }];
    }
}






// 随机生成订单
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg {
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}

// ===============
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [JXEncapSulationObjc clearNavigation:self];
}

#pragma mark -----------  主要的
- (void)viewDidLoad {
    [super viewDidLoad];
    if (![WXApi isWXAppInstalled]) { // 检测用户是否安装微信
        [_wxbutton setHidden:YES];
        _qqleft.constant = (self.thirLoginView.frame.size.width-35)/2;
        _zfright.constant = 32.5;
    }
    [_loginButton setEnabled:NO];
    [self aboutNavigation];
    [self dealwithColor];
    [self textFielSelect];
    [self sethideKeyBoardAccessoryView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(swxLoginAction:) name:@"swxLogin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(thirLoginAction:) name:@"PartySuccessfully" object:nil];
}
#pragma mark -- 微信登录成功通知
- (void)swxLoginAction:(NSNotification *)sender {
    NSString *codestr = sender.object;
    if ([codestr integerValue] == 200) {
        [self loginsuccessfully];
    }else if ([codestr integerValue] == 201) {
        JXBindingPhototNumberViewController *bing = [[JXBindingPhototNumberViewController alloc] init];
        bing.thitrLoginType = 2;
        bing.openId = [[NSUserDefaults standardUserDefaults] objectForKey:@"OPENIDWX"];
        [self.navigationController pushViewController:bing animated:YES];
    }else {
        [self showHint:@"登录失败"];
    }
}
#pragma mark -- 第三方登录绑定成功登录
- (void)thirLoginAction:(NSNotification *)sender {
    
    [self loginsuccessfully];
    
}

// 登录成功操作
- (void)loginsuccessfully {

    // 改变登录状态
    [JXUserDefaultsObjc storageOnlineStatus:YES];
    // 通知刷新
    if ([self.logindelegate respondsToSelector:@selector(loginSuccessful:)]) {
        [self.logindelegate loginSuccessful:self];
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}


#pragma mark --- 账号密码
- (void)textFielSelect {
    
    // 默认隐藏
    _passWordTextField.secureTextEntry = YES;
    _accountTextField.delegate = self;
    _passWordTextField.delegate = self;
    [self.accountTextField addTarget:self action:@selector(accountTextField:) forControlEvents:UIControlEventEditingDidEnd];
    [self.passWordTextField addTarget:self action:@selector(PasswordTextField:) forControlEvents:UIControlEventEditingChanged];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(MineResetPasswordkeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)MineResetPasswordkeyboardWillHide:(NSNotification *)sender {
    
    if (!kStringIsEmpty(_accountStr)&&!kStringIsEmpty(_passWordStr)) {
        [self.loginButton setEnabled:YES];
        [self.loginButton setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    }else {
        [self.loginButton setEnabled:NO];
        [self.loginButton setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    }
}

- (void)accountTextField:(UITextField *)textField { // deptIdInputShouldAlphaNumcharacters
//    
    if ([RegularExpressionsBySyc deptIdInputShouldAlphaNumcharacters:textField.text]) {
        // 获取内容
        _accountStr = textField.text;
        [self.errorMessagelabel setText:@""];
        if (!kStringIsEmpty(_accountStr)&&!kStringIsEmpty(_passWordStr)) {
            [self.loginButton setEnabled:YES];
            [self.loginButton setBackgroundColor:kUIColorFromRGB(0xe82b48)];
        }else {
            [self.loginButton setEnabled:NO];
            [self.loginButton setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
        }
    }else{
        _accountStr = @"";
        [self.errorMessagelabel setText:@"账号错误，含有特殊字符串"];
    }
    
    
}

- (void)PasswordTextField:(UITextField *)textField {
    
    if ([RegularExpressionsBySyc deptIdInputShouldAlphaNum:textField.text]) {
       _passWordStr = textField.text;
    }else{
       _passWordStr = @"";
    }
    if (!kStringIsEmpty(_accountStr)&&!kStringIsEmpty(_passWordStr)) {
        [self.loginButton setEnabled:YES];
        [self.loginButton setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    }else {
        [self.loginButton setEnabled:NO];
        [self.loginButton setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    }
}

- (void)dealwithColor {
    
    [_linef setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_lines setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_linet setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_linefo setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_thirLabel setTextColor:kUIColorFromRGB(0x999999)];
    [_forgetPassWordbt setTitleColor:kUIColorFromRGB(0x999999) forState:(UIControlStateNormal)];
    [_registeredButton setTitleColor:kUIColorFromRGB(0x999999) forState:(UIControlStateNormal)];
    
    [_loginButton.layer setMasksToBounds:true];
    [_loginButton.layer setCornerRadius:5.0];
    [_loginButton setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    
}


- (void)aboutNavigation {
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"用户登录";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_关闭1"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}

- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    NSLog(@"内存警告my");
    [super didReceiveMemoryWarning];//即使没有显示在window上，也不会自动的将self.view释放。注意跟ios6.0之前的区分
    
    // Add code to clean up any of your own resources that are no longer necessary.
    
    // 此处做兼容处理需要加上ios6.0的宏开关，保证是在6.0下使用的,6.0以前屏蔽以下代码，否则会在下面使用self.view时自动加载viewDidUnLoad
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        
        //需要注意的是self.isViewLoaded是必不可少的，其他方式访问视图会导致它加载 ，在WWDC视频也忽视这一点。
        
        if (self.isViewLoaded && !self.view.window)// 是否是正在使用的视图
            
        {
            
            // Add code to preserve data stored in the views that might be
            
            // needed later.
            
            // Add code to clean up other strong references to the view in
            
            // the view hierarchy.
            
            self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
            
        }
        
    }
    
    
}
- (void)loginRegisteredSuccessful:(JXRegisteredViewController *)successful {
    
    if ([self.logindelegate respondsToSelector:@selector(loginSuccessful:)]) {
        [self.logindelegate loginSuccessful:self];
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}



#pragma mark --- 当用户全部清空的时候的时候 会调用
-(BOOL)textFieldShouldClear:(UITextField *)textField {
    
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

/**
 *  键盘添加完成按钮
 */
- (void)sethideKeyBoardAccessoryView{
    UIView *accessoryView = [[UIView alloc]init];
    accessoryView.frame = CGRectMake(0, 0, NPWidth, 30);
    accessoryView.backgroundColor = [UIColor colorWithWhite:0.900 alpha:1];
    UIButton *doneBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    doneBtn.frame = CGRectMake(CGRectGetMaxX(accessoryView.bounds) - 50, CGRectGetMinY(accessoryView.bounds), 40,30);
    //    doneBtn.backgroundColor = [UIColor grayColor];
    [doneBtn setTitle:@"完成" forState:(UIControlStateNormal)];
    [doneBtn setTitleColor:[UIColor colorWithRed:236/255.0 green:49/255.0 blue:88/255.0 alpha:1] forState:(UIControlStateNormal)];
    [doneBtn addTarget:self action:@selector(hideKeyboard) forControlEvents:(UIControlEventTouchUpInside)];
    [accessoryView addSubview:doneBtn];
    self.accountTextField.inputAccessoryView = accessoryView;
    self.passWordTextField.inputAccessoryView = accessoryView;
}

- (void)hideKeyboard{
    [self.accountTextField resignFirstResponder];
    [self.passWordTextField resignFirstResponder];
}

@end
