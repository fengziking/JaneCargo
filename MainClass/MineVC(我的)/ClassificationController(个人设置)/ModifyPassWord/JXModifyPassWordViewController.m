//
//  JXModifyPassWordViewController.m
//  JaneCargo
//
//  Created by cxy on 2017/7/6.
//  Copyright © 2017年 鹏. All rights reserved.
// 修改密码

#import "JXModifyPassWordViewController.h"

@interface JXModifyPassWordViewController () <UITextFieldDelegate> {

    NSString *pass_word;
    NSString *pass_nword;
    NSString *again_word;
}

@property (weak, nonatomic) IBOutlet UIView *linef;
@property (weak, nonatomic) IBOutlet UIView *lines;
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordNewTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordAgaintTextField;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet UIImageView *iconImagef;
@property (weak, nonatomic) IBOutlet UIImageView *iconImages;
@property (weak, nonatomic) IBOutlet UIImageView *iconImaget;





@end

@implementation JXModifyPassWordViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}

- (IBAction)iconImagefAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.oldPasswordTextField.secureTextEntry = NO;
        [self.iconImagef setImage:[UIImage imageNamed:@"icon_密码显示"]];
    }else {
        self.oldPasswordTextField.secureTextEntry = YES;
        [self.iconImagef setImage:[UIImage imageNamed:@"icon_密码隐藏"]];
    }
    
    
}
- (IBAction)iconImagesAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.PasswordNewTextField.secureTextEntry = NO;
        [self.iconImages setImage:[UIImage imageNamed:@"icon_密码显示"]];
    }else {
        self.PasswordNewTextField.secureTextEntry = YES;
        [self.iconImages setImage:[UIImage imageNamed:@"icon_密码隐藏"]];
    }
    
}
- (IBAction)iconImagetAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.PasswordAgaintTextField.secureTextEntry = NO;
        [self.iconImaget setImage:[UIImage imageNamed:@"icon_密码显示"]];
    }else {
        self.PasswordAgaintTextField.secureTextEntry = YES;
        [self.iconImaget setImage:[UIImage imageNamed:@"icon_密码隐藏"]];
    }
    
}




- (void)viewDidLoad { // icon_密码隐藏
    [super viewDidLoad];
    [self.submitButton setEnabled:NO];
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"密码修改";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    
    [self AbouttextField];
    [self sethideKeyBoardAccessoryView];
}


- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)AbouttextField {

    _oldPasswordTextField.delegate = self;
    _PasswordNewTextField.delegate = self;
    _PasswordAgaintTextField.delegate = self;
    self.oldPasswordTextField.secureTextEntry = YES;
    self.PasswordNewTextField.secureTextEntry = YES;
    self.PasswordAgaintTextField.secureTextEntry = YES;
    [_linef setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_lines setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    
    [_submitButton setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [self.submitButton.layer setMasksToBounds:true];
    [self.submitButton.layer setCornerRadius:2];
    [self.submitButton setTitleColor:kUIColorFromRGB(0xffffff) forState:(UIControlStateNormal)];
    
    [self.oldPasswordTextField addTarget:self action:@selector(oldPasswordTextField:) forControlEvents:UIControlEventEditingDidEnd];
    [self.PasswordNewTextField addTarget:self action:@selector(PasswordNewTextField:) forControlEvents:UIControlEventEditingDidEnd];
    [self.PasswordAgaintTextField addTarget:self action:@selector(PasswordAgaintTextField:) forControlEvents:UIControlEventEditingDidEnd];
    
}


- (void)oldPasswordTextField:(UITextField *)textField {
    
    
    if ([RegularExpressionsBySyc deptIdInputShouldAlphaNum:textField.text]) {
        
        pass_word = textField.text;
    }else{
        
        pass_word = nil;
    }
    
}


- (void)PasswordNewTextField:(UITextField *)textField {
    
    if ([textField.text isEqualToString:pass_word]) {
        [self showHint:@"新密码不可与原密码一样"];
        [self hideKeyboard];
        pass_nword = nil;
        return;
    }
    BOOL des = [RegularExpressionsBySyc isEmpty:textField.text];
    if (des) {
        [self hideKeyboard];
        [self showHint:@"密码不允许含有空格"];
        pass_nword = nil;
        return;
    }
    
    if ([RegularExpressionsBySyc isChineseRangeOfString:textField.text]) {
        [self showHint:@"密码不允许含有汉字"];
        [self hideKeyboard];
        pass_nword = nil;
        return;
    }
    if (textField.text.length<6||textField.text.length>20) {
        [self showHint:@"请输入6-20位数的密码"];
        pass_nword = nil;
        [self hideKeyboard];
        return;
    }else {
        pass_nword = textField.text;
    }
    
}

- (void)PasswordAgaintTextField:(UITextField *)textField {
    
    if (![textField.text isEqualToString:pass_nword]) {
        [self showHint:@"密码不一致，请重新输入"];
        [self.submitButton setEnabled:NO];
        [self.submitButton setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    }else {
        again_word = textField.text;
        [self.submitButton setEnabled:YES];
        [self.submitButton setBackgroundColor:kUIColorFromRGB(0xe82b48)];
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
    self.oldPasswordTextField.inputAccessoryView = accessoryView;
    self.PasswordNewTextField.inputAccessoryView = accessoryView;
    self.PasswordAgaintTextField.inputAccessoryView = accessoryView;
}

- (void)hideKeyboard{
    [self.oldPasswordTextField resignFirstResponder];
    [self.PasswordNewTextField resignFirstResponder];
    [self.PasswordAgaintTextField resignFirstResponder];
    
}



- (IBAction)submitAction:(UIButton *)sender {
    
    if (kStringIsEmpty(pass_word)) {
        [self showHint:@"请输原始入密码"];
        return;
    }
    if (kStringIsEmpty(again_word)) {
        [self showHint:@"请输入新密码"];
        return;
    }
    
    [JXNetworkRequest asyncChangethePassword:pass_word npassword:again_word completed:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
        [self exitLogin];
        
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
    } fail:^(NSError *error) {
        
    }];
    
    
}
#pragma mark -- 退出登录
- (void)exitLogin {
    
    [JXNetworkRequest asyncExitcompleted:^(NSDictionary *messagedic) {
        // 退出登录
        [JXUserDefaultsObjc deletegoos_idForsid];
        [JXUserDefaultsObjc deletegoos_idForCart];
        [JXUserDefaultsObjc changeLoginStrat];
        [JXUserDefaultsObjc deleteAddress];
        [JXUserDefaultsObjc deleteUserInfo];
        [self showHint:@"退出成功"];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"LogOut" object:[NSNumber numberWithBool:YES]];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } statisticsFail:^(NSDictionary *messagedic) {
        [self showHint:@"退出失败"];
    } fail:^(NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
