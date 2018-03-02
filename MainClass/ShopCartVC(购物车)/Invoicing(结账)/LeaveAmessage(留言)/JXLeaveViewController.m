//
//  JXLeaveViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/1.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXLeaveViewController.h"

@interface JXLeaveViewController ()<UITextFieldDelegate> {

    BOOL isLeavemessage;
}



@property (weak, nonatomic) IBOutlet UITextField *leaveTextField;
@property (nonatomic, strong) NSString *s_feedContent;
@end

@implementation JXLeaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isLeavemessage = NO;
    [self navigation];
    [self dealWithView];
}



- (void)dealWithView {

    
//    [self.leaveTextView becomeFirstResponder];
    self.leaveTextField.delegate = self;
    [self.leaveTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    [self.leaveTextField addTarget:self action:@selector(questTextField:) forControlEvents:UIControlEventEditingChanged];
    if (!kStringIsEmpty(_message_Str)) {
        self.leaveTextField.text = _message_Str;
    }
    //监听键盘的移动
    [self sethideKeyBoardAccessoryView];
}
- (void)questTextField:(UITextField *)textField {
    
    self.s_feedContent = textField.text;
}

- (void)navigation{
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"给卖家留言";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    
}


- (void)rightAction:(UIBarButtonItem *)sender {
    
    if (self.s_feedContent.length>0||self.s_feedContent!=nil) {
        isLeavemessage = YES;
    }
    if ([_messagedelegate respondsToSelector:@selector(leaveAmessagedelegatestr:)]) {
        [_messagedelegate leaveAmessagedelegatestr:self.s_feedContent];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)leftAction:(UIBarButtonItem *)sender {
    
    if (isLeavemessage) {
        if ([_messagedelegate respondsToSelector:@selector(leaveAmessagedelegatestr:)]) {
            [_messagedelegate leaveAmessagedelegatestr:self.s_feedContent];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
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
    [doneBtn setTitle:@"完成" forState:(UIControlStateNormal)];
    [doneBtn setTitleColor:[UIColor colorWithRed:236/255.0 green:49/255.0 blue:88/255.0 alpha:1] forState:(UIControlStateNormal)];
    [doneBtn addTarget:self action:@selector(hideKeyboard) forControlEvents:(UIControlEventTouchUpInside)];
    [accessoryView addSubview:doneBtn];
    self.leaveTextField.inputAccessoryView = accessoryView;
    
}
- (void)hideKeyboard{
    
    
    [self.leaveTextField resignFirstResponder];
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
