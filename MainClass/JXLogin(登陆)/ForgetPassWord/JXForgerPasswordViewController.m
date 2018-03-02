//
//  JXForgerPasswordViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/20.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXForgerPasswordViewController.h"

@interface JXForgerPasswordViewController ()<UITextFieldDelegate>  {
    
    NSString *_photoStr;
    NSString *_verificationStr;
    NSString *_passwordStr;
}

@property (weak, nonatomic) IBOutlet UITextField *photoTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;
@property (weak, nonatomic) IBOutlet UIView *line;

@property (weak, nonatomic) IBOutlet UIView *lines;

@property (weak, nonatomic) IBOutlet UIView *linet;
@property (weak, nonatomic) IBOutlet UIButton *submitbutton;

@property (weak, nonatomic) IBOutlet UIButton *verificationButton;

@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;



@end

@implementation JXForgerPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.submitbutton setEnabled:NO];
    [self dealwithColor];
    [self aboutNavigation];
    [self textFielSelect];
    
}
- (void)dealwithColor {
    
    [_line setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_lines setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_linet setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_submitbutton.layer setMasksToBounds:true];
    [_submitbutton.layer setCornerRadius:5.0];
    [_submitbutton setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
}


- (void)aboutNavigation {
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"密码找回";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}


- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark --- 点击获取验证码
- (IBAction)verificationAction:(UIButton *)sender {
    
    if (kStringIsEmpty(_photoStr)||_photoStr.length==0) {
        [self showHint:@"请输入手机号码"];
        return;
    }
    
    
    [JXNetworkRequest asyncVerificationCodeStatus:@"2" phoneNumber:_photoStr is_Cache:NO refreshCache:NO completed:^(NSDictionary *messagedic) {
        // 开始倒计时
        [JXEncapSulationObjc setCountdownTimeStart:^(int time) {
            [self.verificationButton setEnabled:NO];
            [self.verificationButton setTitle:[NSString stringWithFormat:@"%ds",time] forState:(UIControlStateNormal)];
            [self.verificationButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        } timeend:^{
            [self.verificationButton setEnabled:YES];
            [self.verificationButton setTitle:@"重新获取" forState:(UIControlStateNormal)];
        }];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark --- 点击提交
- (IBAction)submitAction:(UIButton *)sender {
    [JXNetworkRequest asyncForgetPassWord:_photoStr phone:_verificationStr phonecode:_passwordStr completed:^(NSDictionary *messagedic) {
        // 返回登录界面
        [self.navigationController popViewControllerAnimated:YES];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
    } fail:^(NSError *error) {
        
    }];
    
}

- (void)textFielSelect {
    
    _photoTextField.delegate = self;
    _verificationTextField.delegate = self;
    _passWordTextField.delegate = self;
    self.photoTextField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    self.verificationTextField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    [self.photoTextField addTarget:self action:@selector(photoTextField:) forControlEvents:UIControlEventAllEditingEvents];
    [self.verificationTextField addTarget:self action:@selector(verificationTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.passWordTextField addTarget:self action:@selector(passWordTextField:) forControlEvents:UIControlEventEditingChanged];
    [self sethideKeyBoardAccessoryView];
    
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
    
    if (_photoStr!=nil&&_photoStr.length>0&&_verificationStr!=nil&&_verificationStr.length>0&&_passwordStr!=nil&&_passwordStr.length>0) {
        [_submitbutton setEnabled:YES];
        [_submitbutton setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    }else {
        [_submitbutton setEnabled:NO];
        [_submitbutton setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    }
}


- (void)photoTextField:(UITextField *)textField {
    
    if (![JXRegular validateMobile:textField.text]) {
        
        _photoStr = @"";
    }else { //
        _photoStr = textField.text;
    }
}
- (void)verificationTextField:(UITextField *)textField {
    
    
    if (![JXRegular validateVerification:textField.text]) {
        _verificationStr = @"";
    }else { //
        _verificationStr = textField.text;
    }
}

- (void)passWordTextField:(UITextField *)textField {
    
    if ([RegularExpressionsBySyc deptIdInputShouldAlphaNum:textField.text]) {
        if (textField.text.length<6||textField.text.length>20) {
            _passwordStr = @"";
            [self showHint:@"请输入6-20位数的密码"];
        }else {
            _passwordStr = textField.text;
        }
    }else{
        _passwordStr = @"";
    }
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
    self.photoTextField.inputAccessoryView = accessoryView;
    self.verificationTextField.inputAccessoryView = accessoryView;
    self.passWordTextField.inputAccessoryView = accessoryView;
}

- (void)hideKeyboard{
    
    [self.photoTextField resignFirstResponder];
    [self.verificationTextField resignFirstResponder];
    [self.passWordTextField resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
