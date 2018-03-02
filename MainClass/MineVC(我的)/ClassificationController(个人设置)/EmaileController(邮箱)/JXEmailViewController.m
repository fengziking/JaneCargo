//
//  JXEmailViewController.m
//  JaneCargo
//
//  Created by cxy on 2017/7/6.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXEmailViewController.h"



@interface JXEmailViewController ()<UITextFieldDelegate>  {

    // 记录登录密码
    NSString *emailPassWordStr;
    // 记录新邮箱账号
    NSString *emailAccountStr;
    // 记录验证码
    NSString *verificationStr;

}

@property (weak, nonatomic) IBOutlet UILabel *emailAccount;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

//@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
//@property (weak, nonatomic) IBOutlet UIButton *passWordButton;
//@property (weak, nonatomic) IBOutlet UIImageView *hiddenImage;

@property (weak, nonatomic) IBOutlet UITextField *emailNewaddres;
@property (weak, nonatomic) IBOutlet UILabel *verificationLabel;
@property (weak, nonatomic) IBOutlet UIButton *verificationButton;

@property (weak, nonatomic) IBOutlet UITextField *verificationEmail;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;


@property (weak, nonatomic) IBOutlet UIView *linef;
@property (weak, nonatomic) IBOutlet UIView *lines;
@property (weak, nonatomic) IBOutlet UIView *linet;


@end

@implementation JXEmailViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}


- (void)viewDidLoad { // icon_密码显示 icon_密码隐藏
    [super viewDidLoad];
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"修改邮箱";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    [self AbouttextField];
    [self sethideKeyBoardAccessoryView];
    _emailAccount.text = _email_str;
}


- (void)AbouttextField {
    
    [_submitButton setEnabled:NO];
//    _passWordTextField.delegate = self;
    _emailNewaddres.delegate = self;
    _verificationEmail.delegate = self;
    [_linef setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_lines setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_linet setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_emailLabel setTextColor:kUIColorFromRGB(0x999999)];
    [_verificationLabel setTextColor:kUIColorFromRGB(0x0960cc)];
    [_submitButton setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [self.submitButton.layer setMasksToBounds:true];
    [self.submitButton.layer setCornerRadius:2];
    [self.submitButton setTitleColor:kUIColorFromRGB(0xffffff) forState:(UIControlStateNormal)];
    
    // 键盘显示类型
//    self.passWordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.emailNewaddres.keyboardType = UIKeyboardTypeASCIICapable;
    self.verificationEmail.keyboardType = UIKeyboardTypeASCIICapable;
//    [self.passWordTextField addTarget:self action:@selector(s_passwordEditChanged:) forControlEvents:UIControlEventEditingDidEnd];
    [self.emailNewaddres addTarget:self action:@selector(emailNewaddres:) forControlEvents:UIControlEventEditingDidEnd];
    [self.verificationEmail addTarget:self action:@selector(verificationEmail:) forControlEvents:UIControlEventEditingDidEnd];
    
}


- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)s_passwordEditChanged:(UITextField *)textField{
//    
//    if ([RegularExpressionsBySyc deptIdInputShouldAlphaNum:textField.text]) {
//        NSLog(@"字母或数字");
//    }else{
//        NSLog(@"非字母或数字");
//    }
//}

- (void)emailNewaddres:(UITextField *)textField{
    
    if ([RegularExpressionsBySyc isRightEmail:textField.text]) {
        emailAccountStr = textField.text;
    }else{
        emailAccountStr = nil;
        [self showHint:@"请输入正确邮箱"];
    }
}

- (void)verificationEmail:(UITextField *)textField{
    
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    NSString *filtered =
    [[textField.text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if ([textField.text isEqualToString:filtered]) {
        // 获取内容
        verificationStr = textField.text;
        [_submitButton setEnabled:YES];
        [_submitButton setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    }else {
        // 验证码不匹配
        verificationStr = nil;
        [self showHint:@"请输入正确验证码"];
    }
}


// 提交
- (IBAction)subimAction:(UIButton *)sender {
    
    if (kStringIsEmpty(emailAccountStr)) {
        [self showHint:@"请输入邮箱号"];
        return;
    }
    if (kStringIsEmpty(verificationStr)) {
        [self showHint:@"请输入验证码"];
        return;
    }
    [JXNetworkRequest asyncModifyemail:emailAccountStr email_code:verificationStr completed:^(NSDictionary *messagedic) {
        if ([_modifymaildelegate respondsToSelector:@selector(modifySuccessEmail)]) {
            [_modifymaildelegate modifySuccessEmail];
        }
        [self showHint:messagedic[@"msg"]];
        [self.navigationController popViewControllerAnimated:YES];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
    } fail:^(NSError *error) {
        
    }];
}

// 点击验证码
- (IBAction)verificationButtonAction:(UIButton *)sender {
    if (!kStringIsEmpty(emailAccountStr)) {
        
        [JXNetworkRequest asyncVerificationCodeforemail:emailAccountStr completed:^(NSDictionary *messagedic) {
            [self showHint:messagedic[@"msg"]];
            // 开始倒计时
            [JXEncapSulationObjc setCountdownTimeStart:^(int time) {
                [self.verificationButton setEnabled:NO];
                [self.verificationLabel setText:[NSString stringWithFormat:@"%ds",time]];
                [self.verificationLabel setTextColor:[UIColor redColor]];
            } timeend:^{
                [self.verificationButton setEnabled:YES];
                [self.verificationLabel setText:@"重新获取"];
                
            }];
        } statisticsFail:^(NSDictionary *messagedic) {
            [self showHint:messagedic[@"msg"]];
        } fail:^(NSError *error) {
            
        }];
        
    }else {
        [self showHint:@"请输入邮箱号"];
    }
}


//- (IBAction)hiddenImageAction:(UIButton *)sender {
//    sender.selected = !sender.selected;
//    if (sender.selected) {
//        
//        [_hiddenImage setImage:[UIImage imageNamed:@"icon_密码显示"]];
//        self.passWordTextField.secureTextEntry = NO; //是否以密码形式显示
//        
//    }else {
//        self.passWordTextField.secureTextEntry = YES; //是否以密码形式显示
//        [_hiddenImage setImage:[UIImage imageNamed:@"icon_密码隐藏"]];
//    }
//    
//}

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
//    self.passWordTextField.inputAccessoryView = accessoryView;
    self.emailNewaddres.inputAccessoryView = accessoryView;
    self.verificationEmail.inputAccessoryView = accessoryView;
}

- (void)hideKeyboard{
//    [self.passWordTextField resignFirstResponder];
    [self.emailNewaddres resignFirstResponder];
    [self.verificationEmail resignFirstResponder];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
