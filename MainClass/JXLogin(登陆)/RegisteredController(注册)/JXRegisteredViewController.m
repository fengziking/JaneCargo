//
//  JXRegisteredViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/20.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXRegisteredViewController.h"

@interface JXRegisteredViewController ()<UITextFieldDelegate> {
    
    NSString *_accountStr;
    NSString *_passWordStr;
    NSString *_againpassWordStr;
    NSString *_photoStr;
    NSString *_verificationStr;
    
}

// 用户名
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
// 密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *wordImage;
@property (weak, nonatomic) IBOutlet UIButton *wordhiddenbt;

// 再次密码
@property (weak, nonatomic) IBOutlet UITextField *againpasswordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *againwordImage;
@property (weak, nonatomic) IBOutlet UIButton *againwordbt;
// 手机号
@property (weak, nonatomic) IBOutlet UITextField *photoTextField;
// 验证码
@property (weak, nonatomic) IBOutlet UIButton *verificationbt;
@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;
// 错误提示
@property (weak, nonatomic) IBOutlet UILabel *wrongLabel;
// 协议
@property (weak, nonatomic) IBOutlet UIButton *agreementbt;
@property (weak, nonatomic) IBOutlet UILabel *agreementLabel;
// 确认注册
@property (weak, nonatomic) IBOutlet UIButton *registeredbt;
// line
@property (weak, nonatomic) IBOutlet UIView *linefi;
@property (weak, nonatomic) IBOutlet UIView *linese;
@property (weak, nonatomic) IBOutlet UIView *lineth;
@property (weak, nonatomic) IBOutlet UIView *linefo;
@property (weak, nonatomic) IBOutlet UIView *linefiv;



@end

@implementation JXRegisteredViewController

// 注册协议
- (IBAction)registeredaSAction:(UIButton *)sender {
    
    JXWebAgreementViewController *web = [[JXWebAgreementViewController alloc] init];
    web.retweetType = 0;
    [self.navigationController pushViewController:web animated:YES];
}

- (IBAction)policyAction:(UIButton *)sender {
    
    JXWebAgreementViewController *web = [[JXWebAgreementViewController alloc] init];
    web.retweetType = 1;
    [self.navigationController pushViewController:web animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self dealwithColor];
    [self aboutNavigation];
    [self textFielSelect];
    [self aboutNavigation];
    [self sethideKeyBoardAccessoryView];
}




- (void)textFielSelect {
    
    [_registeredbt setEnabled:NO];
    [self.wrongLabel setText:@""];
    self.nameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.againpasswordTextField.delegate = self;
    self.photoTextField.delegate = self;
    self.verificationTextField.delegate = self;
    
    self.photoTextField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    self.verificationTextField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    
    [self.nameTextField addTarget:self action:@selector(accountTextField:) forControlEvents:UIControlEventEditingDidEnd];
    [self.passwordTextField addTarget:self action:@selector(PasswordTextField:) forControlEvents:UIControlEventEditingDidEnd];
    [self.againpasswordTextField addTarget:self action:@selector(againpasswordTextField:) forControlEvents:UIControlEventEditingDidEnd];
    [self.photoTextField addTarget:self action:@selector(photoTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.verificationTextField addTarget:self action:@selector(verificationTextField:) forControlEvents:UIControlEventEditingChanged];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(MineResetPasswordkeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 *  键盘消失
 *
 *  param sender
 */
- (void)MineResetPasswordkeyboardWillHide:(NSNotification *)sender {
    
    if (!kStringIsEmpty(_accountStr)&&!kStringIsEmpty(_passWordStr)&&!kStringIsEmpty(_againpassWordStr)&&!kStringIsEmpty(_photoStr)&&!kStringIsEmpty(_verificationStr)) {
        [_registeredbt setEnabled:YES];
        [_registeredbt setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    }else {
        [_registeredbt setEnabled:NO];
        [_registeredbt setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    }
    
}

#pragma mark --- 错误提示
- (void)warningPromptline:(UIView *)line color:(UIColor *)color warningstr:(NSString *)warningstr textColor:(UITextField *)textColor{

    [self.wrongLabel setText:warningstr];
    [line setBackgroundColor:color];
    [textColor setTextColor:[UIColor redColor]];
}
- (void)normaltextColor:(UITextField *)textColor line:(UIView *)line{

    [self.wrongLabel setText:@""];
    [line setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [textColor setTextColor:[UIColor blackColor]];
}



// 账号
- (void)accountTextField:(UITextField *)textField {
    
    if ([RegularExpressionsBySyc deptIdInputShouldAlphaNumcharacters:textField.text]) {
        _accountStr = textField.text;
        if (textField.text.length<5||textField.text.length>25) {
            // 清空账号内容
            _accountStr = @"";
            [self.rightImage setImage:[UIImage imageNamed:@""]];
            [self warningPromptline:self.linefi color:[UIColor redColor] warningstr:@"账号错误,请使用5~25位的数字、字母、汉字组合而成的账号" textColor:self.nameTextField];
        }else {
            [JXNetworkRequest asyncUserqueryStatus:@"1" value:_accountStr is_Cache:NO refreshCache:NO completed:^(NSDictionary *messagedic) {
                // 清空账号内容
                _accountStr = @"";
                [self warningPromptline:self.linefi color:[UIColor redColor] warningstr:@"用户已存在，请重新输入新的账户" textColor:self.nameTextField];
                [self.rightImage setImage:[UIImage imageNamed:@""]];
            } statisticsFail:^(NSDictionary *messagedic) {
                _accountStr = textField.text;
                [self.rightImage setImage:[UIImage imageNamed:@"icon_选择"]];
                [self normaltextColor:self.nameTextField line:self.linefi];
            } fail:^(NSError *error) {
                
            }];
        }
        
    }else{
        _accountStr = @"";
        [self.rightImage setImage:[UIImage imageNamed:@""]];
        if (textField.text.length!=0) {
            [self warningPromptline:self.linefi color:[UIColor redColor] warningstr:@"账号错误,请使用5~25位的数字、字母、汉字组合" textColor:self.nameTextField];
        }
    }
    
    
    
   
}
// 密码
- (void)PasswordTextField:(UITextField *)textField {
    
    
    BOOL des = [RegularExpressionsBySyc isEmpty:textField.text];
    if (des) {
         [self warningPromptline:self.linese color:[UIColor redColor] warningstr:@"密码不允许含有空格" textColor:self.passwordTextField];
        return;
    }
    
    if ([RegularExpressionsBySyc isChineseRangeOfString:textField.text]) {
        
         [self warningPromptline:self.linese color:[UIColor redColor] warningstr:@"密码不允许含有汉字" textColor:self.passwordTextField];
        return;
    }
    if (textField.text.length<6||textField.text.length>20) {
        [self warningPromptline:self.linese color:[UIColor redColor] warningstr:@"密码有误，请使用6~20位的数字、字母组合" textColor:self.passwordTextField];
        return;
    }else {
        _passWordStr = textField.text;
    }
    
    [self normaltextColor:self.passwordTextField line:self.linese];
    // 检测密码是否一致
    if (![_passWordStr isEqualToString:_againpassWordStr]&&_againpassWordStr!=nil&&_againpassWordStr.length>0)
    {
        
        [self warningPromptline:self.lineth color:[UIColor redColor] warningstr:@"密码不一致，请重新输入" textColor:self.againpasswordTextField];
    }else {
        
        [self normaltextColor:self.againpasswordTextField line:self.lineth];
    }
    
    
    
    
    
//    if ([RegularExpressionsBySyc deptIdInputShouldAlphaNum:textField.text]) {
//        _passWordStr = textField.text;
//        if (textField.text.length<5||textField.text.length>20) {
//             [self warningPromptline:self.linese color:[UIColor redColor] warningstr:@"密码有误，请使用5~20位的数字、字母组合" textColor:self.passwordTextField];
//        }else {
//            [self normaltextColor:self.passwordTextField line:self.linese];
//            // 检测密码是否一致
//            if (![_passWordStr isEqualToString:_againpassWordStr]&&_againpassWordStr!=nil&&_againpassWordStr.length>0)
//            {
//
//                [self warningPromptline:self.lineth color:[UIColor redColor] warningstr:@"密码不一致，请重新输入" textColor:self.againpasswordTextField];
//            }else {
//
//                [self normaltextColor:self.againpasswordTextField line:self.lineth];
//            }
//        }
//
//
//    }else{
//        _passWordStr = @"";
//        if (textField.text.length!=0) {
//            [self warningPromptline:self.linese color:[UIColor redColor] warningstr:@"密码有误，请使用6~16位的数字、字母组合" textColor:self.passwordTextField];
//        }
//    }
    
}
- (void)againpasswordTextField:(UITextField *)textField {
    
    
    // 检测密码是否一致
    _againpassWordStr = textField.text;
    if (![_againpassWordStr isEqualToString:_passWordStr])
    {
        [self warningPromptline:self.lineth color:[UIColor redColor] warningstr:@"密码不一致，请重新输入" textColor:self.againpasswordTextField];
    }else {
        [self normaltextColor:self.againpasswordTextField line:self.lineth];
    }
    
    
    
}
// 手机号
- (void)photoTextField:(UITextField *)textField {
    
    if (![JXRegular validateMobile:textField.text]) {
        _photoStr = @"";
        if (textField.text.length!=0) {
            [self warningPromptline:self.linefo color:[UIColor redColor] warningstr:@"手机号有误，请重新输入" textColor:self.photoTextField];
        }
    }else { //
        
        _photoStr = textField.text;
        [self normaltextColor:self.photoTextField line:self.linefo];
    }
}
// 验证码
- (void)verificationTextField:(UITextField *)textField {
    
    
    if (![JXRegular validateVerification:textField.text]) {
        
        _verificationStr = @"";
        if (textField.text.length!=0) {
            [self warningPromptline:self.linefiv color:[UIColor redColor] warningstr:@"验证码有误，请重新输入" textColor:self.verificationTextField];
        }
        
    }else { //
        
        _verificationStr = textField.text;
        [self normaltextColor:self.verificationTextField line:self.linefiv];
    }
    if (!kStringIsEmpty(_accountStr)&&!kStringIsEmpty(_passWordStr)&&!kStringIsEmpty(_againpassWordStr)&&!kStringIsEmpty(_photoStr)&&!kStringIsEmpty(_verificationStr)) {
        [_registeredbt setEnabled:YES];
        [_registeredbt setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    }else {
        [_registeredbt setEnabled:NO];
        [_registeredbt setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    }
}




- (void)aboutNavigation {
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"用户注册";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}

- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)dealwithColor {
    
    self.passwordTextField.secureTextEntry = YES;
    self.againpasswordTextField.secureTextEntry = YES;
    
    [self.linefi setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.linese setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.lineth setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.linefo setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.linefiv setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    
    [self.registeredbt.layer setMasksToBounds:true];
    [self.registeredbt.layer setCornerRadius:5.0];
    [self.registeredbt setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:self.agreementLabel.text];
    [content addAttribute:NSForegroundColorAttributeName
     
                    value:kUIColorFromRGB(0x0960cc)
     
                    range:NSMakeRange(5,17)];
    self.agreementLabel.attributedText = content;
  
    
}


// 密码隐藏
- (IBAction)wordhiddenAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.passwordTextField.secureTextEntry = NO;
        [self.wordImage setImage:[UIImage imageNamed:@"icon_密码显示"]];
    }else {
        self.passwordTextField.secureTextEntry = YES;
        [self.wordImage setImage:[UIImage imageNamed:@"icon_密码隐藏"]];
    }
}

- (IBAction)againwordAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.againpasswordTextField.secureTextEntry = NO;
        [self.againwordImage setImage:[UIImage imageNamed:@"icon_密码显示"]];
    }else {
        
        self.againpasswordTextField.secureTextEntry = YES;
        [self.againwordImage setImage:[UIImage imageNamed:@"icon_密码隐藏"]];
    }
    
}
// 验证码获取
- (IBAction)verificationAction:(UIButton *)sender {
    
    if (_photoStr != nil || _photoStr.length > 0)
    {
        [self normaltextColor:self.photoTextField line:self.linefo];
        

        [JXNetworkRequest asyncVerificationCodeStatus:@"1" phoneNumber:_photoStr is_Cache:NO refreshCache:NO completed:^(NSDictionary *messagedic) {
            // 发送成功 开始倒计时
            [JXEncapSulationObjc setCountdownTimeStart:^(int time) {
                [self.verificationbt setEnabled:NO];
                [self.verificationbt setTitle:[NSString stringWithFormat:@"%ds",time] forState:(UIControlStateNormal)];
                [self.verificationbt setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
            } timeend:^{
                [self.verificationbt setEnabled:YES];
                [self.verificationbt setTitle:@"重新获取" forState:(UIControlStateNormal)];
            }];
        } statisticsFail:^(NSDictionary *messagedic) {
            [self showHint:messagedic[@"msg"]];
        } fail:^(NSError *error) {
            
        }];

    }
    else
    {
    [self warningPromptline:self.linefo color:[UIColor redColor] warningstr:@"请输入手机号码" textColor:self.photoTextField];
    }
    
    
}
// 协议(h5)
- (IBAction)agreementAction:(UIButton *)sender {
    
    
}
#pragma mark --- 注册
- (IBAction)registeredAction:(UIButton *)sender {
    
    [JXNetworkRequest asyncRegisteredUserName:_accountStr password:_passWordStr phoneNumber:_photoStr verificationCode:_verificationStr status:@"1" is_Cache:NO refreshCache:NO completed:^(NSDictionary *messagedic) {
        // 注册成功改变登录状态
        [JXUserDefaultsObjc storageOnlineStatus:YES];
        [JXUserDefaultsObjc storageLoginUserSid:messagedic];
        if ([self.registeredelegate respondsToSelector:@selector(loginRegisteredSuccessful:)]) {
            [self.registeredelegate loginRegisteredSuccessful:self];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } statisticsFail:^(NSDictionary *messagedic) {
        [JXEncapSulationObjc choseAlerController:self alerTitle:@"错误提示" contentTitle:messagedic[@"msg"] cancel:@"取消" confirm:@"确认" block:^(id responseCode) {
            
        } choseBlock:^(id choesbk) {
            
        }];
    } fail:^(NSError *error) {
        
    }];
    
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
    self.nameTextField.inputAccessoryView = accessoryView;
    self.passwordTextField.inputAccessoryView = accessoryView;
    self.againpasswordTextField.inputAccessoryView = accessoryView;
    self.photoTextField.inputAccessoryView = accessoryView;
    self.verificationTextField.inputAccessoryView = accessoryView;
    
}

- (void)hideKeyboard{
    [self.nameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.againpasswordTextField resignFirstResponder];
    [self.photoTextField resignFirstResponder];
    [self.verificationTextField resignFirstResponder];
    
    
}
@end
