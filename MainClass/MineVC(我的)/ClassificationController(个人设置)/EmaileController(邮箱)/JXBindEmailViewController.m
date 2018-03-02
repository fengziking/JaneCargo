//
//  JXBindEmailViewController.m
//  JaneCargo
//
//  Created by cxy on 2017/7/6.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXBindEmailViewController.h"


@interface JXBindEmailViewController () <UITextFieldDelegate> {

    NSString *is_emailStr;
    NSString *is_verificationStr;
}
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *verificationLabel;
@property (weak, nonatomic) IBOutlet UIButton *verificationButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *emilaVerificationTextField;
@property (weak, nonatomic) IBOutlet UIButton *subimButton;


@end

@implementation JXBindEmailViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [_subimButton setEnabled:NO];
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"绑定邮箱";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    [self AbouttextField];
    
}

- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)AbouttextField {

    _emailTextField.delegate = self;
    _emilaVerificationTextField.delegate = self;
    [_lineView setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_verificationLabel setTextColor:kUIColorFromRGB(0x0960cc)];
    [self.subimButton.layer setMasksToBounds:true];
    [self.subimButton.layer setCornerRadius:2];
    [self.subimButton setTitleColor:kUIColorFromRGB(0xffffff) forState:(UIControlStateNormal)];
    [_subimButton setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [self.emailTextField addTarget:self action:@selector(s_passwordEditChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.emilaVerificationTextField addTarget:self action:@selector(verificationEmail:) forControlEvents:UIControlEventEditingDidEnd];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(MineResetPasswordkeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    [self sethideKeyBoardAccessoryView];
    
}
/**
 *  键盘消失
 *
 *  param sender
 */
- (void)MineResetPasswordkeyboardWillHide:(NSNotification *)sender {
    
    if (!kStringIsEmpty(is_verificationStr)) {
        
        [_subimButton setEnabled:YES];
        [_subimButton setBackgroundColor:kUIColorFromRGB(0xe82b48)];
        
    }else {
        
        [_subimButton setEnabled:NO];
        [_subimButton setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    }
    
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
// 提交验证码
- (IBAction)subimtAction:(UIButton *)sender {
    if (kStringIsEmpty(is_emailStr)) {
        [self showHint:@"请输入邮箱号"];
        return;
    }
    if (kStringIsEmpty(is_verificationStr)) {
        [self showHint:@"请输入验证码"];
        return;
    }
    [JXNetworkRequest asyncSetUpemail:is_emailStr email_code:is_verificationStr completed:^(NSDictionary *messagedic) {
        if ([_bindemaildelegate respondsToSelector:@selector(bindingSuccessEmail)]) {
            [_bindemaildelegate bindingSuccessEmail];
        }
        [self showHint:messagedic[@"msg"]];
        [self.navigationController popViewControllerAnimated:YES];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
    } fail:^(NSError *error) {
        
    }];
}

- (void)s_passwordEditChanged:(UITextField *)textField{
    
    if ([RegularExpressionsBySyc isRightEmail:textField.text]) {
        is_emailStr = textField.text;
    }else{
        is_emailStr = nil;
    }
}

- (void)verificationEmail:(UITextField *)textField{
    
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
    NSString *filtered =
    [[textField.text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if ([textField.text isEqualToString:filtered]) {
        // 获取内容
        is_verificationStr = textField.text;
        [_subimButton setEnabled:YES];
        [_subimButton setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    }else {
        // 验证码不匹配
        is_verificationStr = nil;
        [self showHint:@"请输入正确验证码"];
        
    }
}

// 获取验证码
- (IBAction)verificationAction:(UIButton *)sender {
    if (!kStringIsEmpty(is_emailStr)) {
        
        [JXNetworkRequest asyncVerificationCodeforemail:is_emailStr completed:^(NSDictionary *messagedic) {
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
    self.emailTextField.inputAccessoryView = accessoryView;
    self.emilaVerificationTextField.inputAccessoryView = accessoryView;
}


- (void)hideKeyboard{
    
    [self.emailTextField resignFirstResponder];
    [self.emilaVerificationTextField resignFirstResponder];
}


#pragma mark --- 当用户全部清空的时候的时候 会调用
-(BOOL)textFieldShouldClear:(UITextField *)textField {
    
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
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
