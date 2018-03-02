//
//  JXSetUpInformationViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/25.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXSetUpInformationViewController.h"

@interface JXSetUpInformationViewController ()<UITextFieldDelegate> {


    NSString *accountStr;
    NSString *passWordStr;
    NSString *agpassWordStr;
}

@property (weak, nonatomic) IBOutlet UIView *topline;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *agpasswordTextField;

@property (weak, nonatomic) IBOutlet UIButton *submit;

@property (weak, nonatomic) IBOutlet UIView *linef;
@property (weak, nonatomic) IBOutlet UIView *lines;
@property (weak, nonatomic) IBOutlet UIView *linet;
@property (weak, nonatomic) IBOutlet UIImageView *fImage;
@property (weak, nonatomic) IBOutlet UIImageView *sImage;

@end

@implementation JXSetUpInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.submit setEnabled:NO];
    [self aboutNavigation];
    [self dealwithColor];
    [self textFielSelect];
    [self sethideKeyBoardAccessoryView];
}


- (void)textFielSelect {
    
    
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.agpasswordTextField.delegate = self;
    
    [self.userNameTextField addTarget:self action:@selector(userNameTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(passwordTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.agpasswordTextField addTarget:self action:@selector(agpasswordTextField:) forControlEvents:UIControlEventEditingDidEnd];
}



- (void)userNameTextField:(UITextField *)textField {
    
    if ([RegularExpressionsBySyc deptIdInputShouldAlphaNumcharacters:textField.text]) {
        if (textField.text.length<5||textField.text.length>25) {
            accountStr = @"";
            [self showHint:@"请输入5-25位数的账号"];
        }else {
            accountStr = textField.text;
        }
        
    }else{
        accountStr = @"";
        [self showHint:@"含有特殊符号"];
    }
    
}
- (void)passwordTextField:(UITextField *)textField {
    
    BOOL des = [RegularExpressionsBySyc isEmpty:textField.text];
    if (des) {
        [self showHint:@"密码不允许含有空格"];
        return;
    }
    
    if ([RegularExpressionsBySyc isChineseRangeOfString:textField.text]) {
        [self showHint:@"密码不允许含有汉字"];
        return;
    }
    if (textField.text.length<6||textField.text.length>20) {
        [self showHint:@"请输入6-20位数的密码"];
        return;
    }else {
        passWordStr = textField.text;
    }
    
}

- (void)agpasswordTextField:(UITextField *)textField {
    
    
    if ([textField.text isEqualToString:passWordStr]) {
        agpassWordStr = textField.text;
        [self.submit setEnabled:YES];
        [self.submit setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    }else {
        [self.submit setEnabled:NO];
        [self.submit setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
        agpassWordStr = @"";
        [JXEncapSulationObjc choseAlerController:self alerTitle:@"温馨提示" contentTitle:@"密码不一致" cancel:@"取消" confirm:@"确认" block:^(id responseCode) {
            
        } choseBlock:^(id choesbk) {
            
        }];
    }
    
}



- (BOOL)detectionAccountPassWord:(NSString *)strs {
    
    if (strs.length>0 || strs!=nil) {
        return true;
    }else {
        return false;
    }
}


- (void)dealwithColor {
    
    [self.submit setEnabled:NO];
    [self.topline setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.linef setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.lines setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.linet setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.submit.layer setMasksToBounds:true];
    [self.submit.layer setCornerRadius:5.0];
    [self.submit setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
}

- (void)aboutNavigation {
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"完善信息";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(MineResetPasswordkeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)MineResetPasswordkeyboardWillHide:(NSNotification *)sender {

    if (accountStr!=nil&&accountStr.length>0&&passWordStr!=nil&&passWordStr.length>0&&agpassWordStr!=nil&&agpassWordStr.length>0) {
        [self.submit setEnabled:YES];
        [self.submit setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    }else {
        [self.submit setEnabled:NO];
        [self.submit setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    }
}


- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (IBAction)feyeAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.passwordTextField.secureTextEntry = YES;
        [self.fImage setImage:[UIImage imageNamed:@"icon_密码隐藏"]];
    }else {
        self.passwordTextField.secureTextEntry = NO;
        [self.fImage setImage:[UIImage imageNamed:@"icon_密码显示"]];
    }
    
}

- (IBAction)seyeAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.agpasswordTextField.secureTextEntry = YES;
        [self.sImage setImage:[UIImage imageNamed:@"icon_密码隐藏"]];
    }else {
        self.agpasswordTextField.secureTextEntry = NO;
        [self.sImage setImage:[UIImage imageNamed:@"icon_密码显示"]];
    }
    
}



- (IBAction)submitAction:(UIButton *)sender { //
    
    NSString *uuid = _userInfouid;
    [JXNetworkRequest asyncSetUpPassWord:[NSString stringWithFormat:@"%@",passWordStr] username:[NSString stringWithFormat:@"%@",accountStr] uid:uuid  completed:^(NSDictionary *messagedic) {// 设置密码成功返回
        [JXUserDefaultsObjc storageLoginUserSid:messagedic];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PartySuccessfully" object:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
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
    
    self.userNameTextField.inputAccessoryView = accessoryView;
    self.passwordTextField.inputAccessoryView = accessoryView;
    self.agpasswordTextField.inputAccessoryView = accessoryView;
}

- (void)hideKeyboard{
    
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.agpasswordTextField resignFirstResponder];
    
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
