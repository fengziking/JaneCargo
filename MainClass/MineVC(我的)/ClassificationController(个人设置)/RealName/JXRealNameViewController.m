//
//  JXRealNameViewController.m
//  JaneCargo
//
//  Created by cxy on 2017/7/6.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXRealNameViewController.h"

@interface JXRealNameViewController () <UITextFieldDelegate> {

    NSString *_name_str;
    NSString *_idcard_str;
}

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIView *line;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *idCardTextField;

@property (weak, nonatomic) IBOutlet UILabel *regulationLabel;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIView *lines;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation JXRealNameViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [_submitButton setEnabled:NO];
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"用户实名认证";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    [self AbouttextField];
    [self sethideKeyBoardAccessoryView];
    
    [self.regulationLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
}

#pragma mark --- 阅读协议
- (void)labelClick:(UITapGestureRecognizer *)tap {
    
    JXWebAgreementViewController *web = [[JXWebAgreementViewController alloc] init];
    web.retweetType = 3;
    [self.navigationController pushViewController:web animated:YES];
}



- (void)leftAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)AbouttextField {
    
    
    _nameTextField.delegate = self;
    _idCardTextField.delegate = self;
    
    [_line setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_lines setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [_backView setBackgroundColor:kUIColorFromRGB(0xf7ecd3)];
    [_contentLabel setTextColor:kUIColorFromRGB(0x666666)];

    [_submitButton setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    [self.submitButton.layer setMasksToBounds:true];
    [self.submitButton.layer setCornerRadius:2];
    [self.submitButton setTitleColor:kUIColorFromRGB(0xffffff) forState:(UIControlStateNormal)];
    
    
    [_regulationLabel setTextColor:kUIColorFromRGB(0xbbbbbb)];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:_regulationLabel.text];
    [content addAttribute:NSForegroundColorAttributeName
     
                    value:kUIColorFromRGB(0x0960cc)
     
                    range:NSMakeRange(14,13)];
    _regulationLabel.attributedText = content;
    
    
    // 键盘显示类型
    self.idCardTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    [self.nameTextField addTarget:self action:@selector(nameTextField:) forControlEvents:UIControlEventEditingDidEnd];
    [self.idCardTextField addTarget:self action:@selector(idCardTextField:) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)nameTextField:(UITextField *)textField {

    if ([RegularExpressionsBySyc deptNameInputShouldChinese:textField.text]) {
        NSLog(@"字母或数字");
        _name_str = textField.text;
        if (_idcard_str.length>0) {
            [_submitButton setEnabled:YES];
            [_submitButton setBackgroundColor:kUIColorFromRGB(0xe82b48)];
        }
    }else{
        _name_str = nil;
        NSLog(@"非字母或数字");
    }
    
}

- (void)idCardTextField:(UITextField *)textField {
    
    if ([RegularExpressionsBySyc isIDCardNumComplyWithTheRules:textField.text]) {
        NSLog(@"身份证号码合规");
        _idcard_str = textField.text;
        if (_name_str.length>0) {
            [_submitButton setEnabled:YES];
            [_submitButton setBackgroundColor:kUIColorFromRGB(0xe82b48)];
        }
        
    }else{
        NSLog(@"身份证号码不合规");
        _idcard_str = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)submitAction:(UIButton *)sender {
    
    [JXNetworkRequest asyncCertification:_name_str noid:_idcard_str completed:^(NSDictionary *messagedic) {
        [self showHint:@"认证成功"];
        [self.navigationController popViewControllerAnimated:YES];
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
    self.nameTextField.inputAccessoryView = accessoryView;
    self.idCardTextField.inputAccessoryView = accessoryView;
    
}

- (void)hideKeyboard{
    [self.nameTextField resignFirstResponder];
    [self.idCardTextField resignFirstResponder];

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
