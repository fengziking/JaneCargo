//
//  JXChangePhotoViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/27.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXChangePhotoViewController.h"

@interface JXChangePhotoViewController ()<UITextFieldDelegate>  {
    
//    NSString *_photoStr;
    NSString *_verificationStr;
    NSString *_newPhotoStr;
}

@property (weak, nonatomic) IBOutlet UIView *linef;
@property (weak, nonatomic) IBOutlet UIView *lines;
@property (weak, nonatomic) IBOutlet UIView *linet;


@property (weak, nonatomic) IBOutlet UIButton *verificationbt;
@property (weak, nonatomic) IBOutlet UITextField *photoTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;
@property (weak, nonatomic) IBOutlet UITextField *nPhotoTextField;
@property (weak, nonatomic) IBOutlet UIButton *submit;


@end

@implementation JXChangePhotoViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.submit setEnabled:NO];
    [self dealwithColor];
    [self aboutNavigation];
    [self sethideKeyBoardAccessoryView];
    [self textFielSelect];
}


- (void)aboutNavigation {
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"修改手机";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    
    _photoTextField.text = _photoStr;
    _photoTextField.userInteractionEnabled = NO;
    
}
- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)dealwithColor {
    
    [_linef setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_lines setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_linet setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_submit.layer setMasksToBounds:true];
    [_submit.layer setCornerRadius:5.0];
    [_submit setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
}

#pragma mark --- 点击获取验证码
- (IBAction)verificationAction:(UIButton *)sender {
    
    if (_photoStr!=nil||_photoStr.length>0) {
        
        [JXNetworkRequest asyncVerificationCodeStatus:@"3" phoneNumber:_photoStr is_Cache:NO refreshCache:NO completed:^(NSDictionary *messagedic) {
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
            [self showHint:messagedic[@"msg"]];
        } fail:^(NSError *error) {
            
        }];

    }else {
        
        [self showHint:@"请输入手机号"];
        
    }
}
#pragma mark --- 点击提交
- (IBAction)submitAction:(UIButton *)sender {
    
    [JXNetworkRequest asyncsave_info:@"3" value:_photoStr completed:^(NSDictionary *messagedic) {
        
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
}



- (void)textFielSelect {
    
    _photoTextField.delegate = self;
    _verificationTextField.delegate = self;
    _nPhotoTextField.delegate = self;
    self.photoTextField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    self.verificationTextField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
  //  [self.photoTextField addTarget:self action:@selector(photoTextField:) forControlEvents:UIControlEventEditingDidEnd];
    [self.verificationTextField addTarget:self action:@selector(verificationTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.nPhotoTextField addTarget:self action:@selector(passWordTextField:) forControlEvents:UIControlEventEditingChanged];
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
    
    if (_photoStr!=nil&&_photoStr.length>0&&_verificationStr!=nil&&_verificationStr.length>0&&_newPhotoStr!=nil&&_newPhotoStr.length>0) {
        [self.submit setEnabled:YES];
        [self.submit setBackgroundColor:kUIColorFromRGB(0xe82b48)];
    }else {
        [self.submit setEnabled:NO];
        [self.submit setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    }
}


- (void)photoTextField:(UITextField *)textField {
    
//    if (![JXRegular validateMobile:textField.text]) {
//
//        _photoStr = @"";
//
//    }else { //
//
//        _photoStr = textField.text;
//
//    }
}
- (void)verificationTextField:(UITextField *)textField {
    
    
    if (![JXRegular validateVerification:textField.text]) {
        _verificationStr = @"";
        
        
    }else { //
        _verificationStr = textField.text;
        
        
    }
}

- (void)passWordTextField:(UITextField *)textField {
    
    if (![JXRegular validateMobile:textField.text])
    {
        _newPhotoStr = @"";
        
        
    }else {
        
        _newPhotoStr = textField.text;
        
        
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
    self.nPhotoTextField.inputAccessoryView = accessoryView;
    
}

- (void)hideKeyboard{
    
    [self.photoTextField resignFirstResponder];
    [self.verificationTextField resignFirstResponder];
    [self.nPhotoTextField resignFirstResponder];
    
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
