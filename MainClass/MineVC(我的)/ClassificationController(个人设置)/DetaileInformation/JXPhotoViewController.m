//
//  JXPhotoViewController.m
//  JaneCargo
//
//  Created by cxy on 2017/7/6.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXPhotoViewController.h"  // letter

#define kAlphaNumletter  @"0123456789"

@interface JXPhotoViewController ()<UITextFieldDelegate> {

    NSInteger type;
}

@property (nonatomic, strong) NSString *textContent;
@property (nonatomic, strong) UITextField *messageTextField;

@end

@implementation JXPhotoViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [JXEncapSulationObjc blackNavigation:self color:[UIColor whiteColor]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = _navigationTitle;
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    
//    self.title = _navigationTitle;
    if ([_navigationTitle isEqualToString:@"QQ"]) {
        type = 1;
    }else { // 发票抬头
        type = 2;
    }
    [self  textFields];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ResetPasswordkeyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ResetPasswordkeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)leftAction:(UIBarButtonItem *)sender {
    
    if (self.textContent!=nil) {
        if ([self.messagedelegate respondsToSelector:@selector(returnMessage:content:type:)]) {
            [self.messagedelegate returnMessage:self content:self.textContent type:type];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightAction:(UIBarButtonItem *)sender {
    
    if (!kStringIsEmpty(_textContent)) {
        [JXNetworkRequest asyncsave_info:@"2" value:_textContent completed:^(NSDictionary *messagedic) {
            [self showHint:messagedic[@"msg"]];
            if ([self.messagedelegate respondsToSelector:@selector(returnMessage:content:type:)]) {
                [self.messagedelegate returnMessage:self content:self.textContent type:type];
            }
            [self.navigationController popViewControllerAnimated:YES];
        } statisticsFail:^(NSDictionary *messagedic) {
            [self showHint:messagedic[@"msg"]];
        } fail:^(NSError *error) {
            
        }];
    }else {
        [self hideKeyboard];
        [self showHint:@"QQ号不能为空"];
    }
}

- (void)textFields {
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 74, NPWidth, 44)];
    [view setBackgroundColor:kUIColorFromRGB(0xffffff)];
    [self.view addSubview:view];
    self.messageTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, NPWidth-15, 44)];
    self.messageTextField.delegate = self;
    self.messageTextField.placeholder = [NSString stringWithFormat:@"%@",self.navigationTitle]; //默认显示的字
    self.messageTextField.font = [UIFont systemFontOfSize:14];
    self.messageTextField.secureTextEntry = NO; //是否以密码形式显示
    self.messageTextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    if ([self.navigationTitle isEqualToString:@"QQ"]) {
        self.messageTextField.keyboardType = UIKeyboardTypeASCIICapableNumberPad; //键盘显示类型
    }else {
        self.messageTextField.keyboardType = UIKeyboardTypeASCIICapable; //键盘显示类型
    }
    self.messageTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //设置居中输入
    [self.messageTextField setBackgroundColor:kUIColorFromRGB(0xffffff)];
    [view addSubview:self.messageTextField];
    [self.messageTextField addTarget:self action:@selector(s_passwordEditChanged:) forControlEvents:UIControlEventEditingChanged];
    [self sethideKeyBoardAccessoryView];
    
    if (!kStringIsEmpty(_qq_str)) {
        self.messageTextField.text = _qq_str;
    }
    
}


- (void)s_passwordEditChanged:(UITextField *)textField{ // [1-9][0-9]{4,}
    
    
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNumletter] invertedSet];
    NSString *filtered =
    [[textField.text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if ([textField.text isEqualToString:filtered]) {
        // 获取内容
        if (textField.text.length>15) {
            [self showHint:@"QQ号位数不对"];
            return;
        }else {
            self.textContent = textField.text;
        }
    }else {
        // 类型不匹配
        textField.text = @"";
//        [self showHint:@"请不要输入特殊字符"];
    }
    
//    //validateUserpersonhybridQQ
//    if ([JXRegular validateUserpersonhybridQQ:textField.text]) {
//        self.textContent = textField.text;
//    }else {
//        textField.text = @"";
//
//    }
    
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
    self.messageTextField.inputAccessoryView = accessoryView;
    
}

- (void)hideKeyboard{
    [self.messageTextField resignFirstResponder];
    
}


#pragma mark 键盘事件处理
/**
 *  键盘出现
 *
 *  @param sender
 */
- (void)ResetPasswordkeyboardWillShow:(NSNotification *)sender{
    
    
}
/**
 *  键盘消失
 *
 *  @param sender
 */
- (void)ResetPasswordkeyboardWillHide:(NSNotification *)sender {
    
    
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
