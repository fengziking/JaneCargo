//
//  JXBindingPhototNumberViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/25.
//  Copyright © 2017年 鹏. All rights reserved.


#import "JXBindingPhototNumberViewController.h"
#import "JXSetUpInformationViewController.h"
@interface JXBindingPhototNumberViewController ()<UITextFieldDelegate> {

    NSString *_photoStr;
    NSString *_verificationStr;
}

@property (weak, nonatomic) IBOutlet UIView *topline;
@property (weak, nonatomic) IBOutlet UITextField *photoTextField;

@property (weak, nonatomic) IBOutlet UIButton *verificationbt;

@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;

@property (weak, nonatomic) IBOutlet UIView *linef;
@property (weak, nonatomic) IBOutlet UIView *lines;
@property (weak, nonatomic) IBOutlet UIButton *submitbt;

@end

@implementation JXBindingPhototNumberViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.submitbt setEnabled:NO];
    [self textFielSelect];
    [self dealwithColor];
    [self aboutNavigation];
    [self sethideKeyBoardAccessoryView];
    
    
}
- (void)textFielSelect {
    
   
    self.photoTextField.delegate = self;
    self.verificationTextField.delegate = self;
    self.photoTextField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    self.verificationTextField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;

    [self.photoTextField addTarget:self action:@selector(photoTextField:) forControlEvents:UIControlEventAllEditingEvents];
    [self.verificationTextField addTarget:self action:@selector(verificationTextField:) forControlEvents:UIControlEventAllEditingEvents];
}

// 手机号
- (void)photoTextField:(UITextField *)textField {
    
    if (![JXRegular validateMobile:textField.text]) {
        _photoStr = @"";
        
    }else { //
        
        _photoStr = textField.text;
        
    }
}
// 验证码
- (void)verificationTextField:(UITextField *)textField {
    
    
    if (![JXRegular validateVerification:textField.text]) {
        
        _verificationStr = @"";
        [self.submitbt setEnabled:NO];
        [self.submitbt setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
        
    }else { //
        
        _verificationStr = textField.text;
        [self.submitbt setEnabled:YES];
        [self.submitbt setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    }
}


- (void)dealwithColor {
    
    [self.topline setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.linef setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.lines setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.submitbt.layer setMasksToBounds:true];
    [self.submitbt.layer setCornerRadius:5.0];
    [self.submitbt setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
}


- (void)aboutNavigation {
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"绑定手机号码";
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
    
    if (!kStringIsEmpty(_photoStr)&&!kStringIsEmpty(_verificationStr)) {
        [self.submitbt setEnabled:YES];
        [self.submitbt setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    }else {
        [self.submitbt setEnabled:NO];
        [self.submitbt setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    }
    
}


- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)verificationAction:(UIButton *)sender {
    
    if (!kStringIsEmpty(_photoStr))
    {
        
        [JXNetworkRequest asyncThirVerificationphoneNumber:_photoStr completed:^(NSDictionary *messagedic) {
            [self showHint:@"发送成功"];
            // 开始倒计时
            [JXEncapSulationObjc setCountdownTimeStart:^(int time) {
                [self.verificationbt setEnabled:NO];
                [self.verificationbt setTitle:[NSString stringWithFormat:@"%ds",time] forState:(UIControlStateNormal)];
                [self.verificationbt setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
            } timeend:^{
                [self.verificationbt setEnabled:YES];
                [self.verificationbt setTitle:@"重新获取" forState:(UIControlStateNormal)];
            }];
        } statisticsFail:^(NSDictionary *messagedic) {
            [self showHint:@"发送失败"];
        } fail:^(NSError *error) {
            [self showHint:@"发送失败"];
        }];
    }
    else
    {
    

        dispatch_async(dispatch_get_main_queue(), ^{
           UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"请输入正确手机号码" preferredStyle:(UIAlertControllerStyleAlert)];
            [self presentViewController:aler animated:true completion:nil];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [aler addAction:action];
            
        });
        
    }
}

- (IBAction)submitAction:(UIButton *)sender {
    
    [JXNetworkRequest asyncThirBindingphoneNumber:_photoStr phonecode:_verificationStr thitrLoginType:_thitrLoginType openid:_openId completed:^(NSDictionary *messagedic) {
        if ([messagedic[@"status"] integerValue] == 200) { // 已经存在
            
            [self showHint:messagedic[@"msg"]];
            [JXUserDefaultsObjc storageLoginUserSid:messagedic];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PartySuccessfully" object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else if ([messagedic[@"status"] integerValue] == 201) { // 新用户绑定 进入密码绑定
            
            NSString *userInfo = [NSString stringWithFormat:@"%@",messagedic[@"info"]];
            JXSetUpInformationViewController *setup = [[JXSetUpInformationViewController alloc] init];
            setup.userInfouid = userInfo;
            [self.navigationController pushViewController:setup animated:YES];
            
        }else {
            [self showHint:messagedic[@"msg"]];
        }
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        [self showHint:@"网络出现错误"];
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
    
    self.photoTextField.inputAccessoryView = accessoryView;
    self.verificationTextField.inputAccessoryView = accessoryView;
    
}

- (void)hideKeyboard{
    
    [self.photoTextField resignFirstResponder];
    [self.verificationTextField resignFirstResponder];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}













@end
