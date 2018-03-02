//
//  JXAskQuestionsViewController.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/9.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXAskQuestionsViewController.h"

@interface JXAskQuestionsViewController ()<UITextViewDelegate> {
    
    NSString *quest_Str;
    BOOL is_questiont;
}

@property (weak, nonatomic) IBOutlet UIButton *submitbt;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *s_placeholder;

@end

@implementation JXAskQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.submitbt setEnabled:NO];
    [self.submitbt setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    [self.view setBackgroundColor:kUIColorFromRGB(0xf2f2f2)];
    [self listnavigation];
    [self textFieldQuest];
    [self sethideKeyBoardAccessoryView];
}


- (void)listnavigation {
    
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"我要提问";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction:)];
}



- (void)textFieldQuest {

    self.contentTextView.delegate = self;
    [self.s_placeholder setText:@"请在下方输入您要提的问题"];
    [self.s_placeholder setTextColor:kUIColorFromRGB(0xbbbbbb)];
    [self.submitbt.layer setMasksToBounds:true];
    [self.submitbt.layer setCornerRadius:3.0];

    
    //监听键盘的移动
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark 键盘事件处理
- (void)keybordHide:(NSNotification *)sender {
    
    if (!kStringIsEmpty(quest_Str)) {
        [self.submitbt setEnabled:YES];
        [self.submitbt setBackgroundColor:[UIColor redColor]];
    }else {
        [self.submitbt setEnabled:NO];
        [self.submitbt setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    }
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}





#pragma mark --- textView代理
//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self.s_placeholder setText:@""];
    return YES;
}

//将要结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        [self.s_placeholder setText:@"请在下方输入您要提的问题"];
    }
    return YES;
}
//内容将要发生改变编辑
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return YES;
}
//内容发生改变编辑
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length>200) {
        [self hideKeyboard];
        [self showHint:@"字数不可超过200"];
        return;
    }else {
        quest_Str = textView.text;
    }
    if (!kStringIsEmpty(quest_Str)) {
        [self.submitbt setEnabled:YES];
        [self.submitbt setBackgroundColor:[UIColor redColor]];
    }else {
        [self.submitbt setEnabled:NO];
        [self.submitbt setBackgroundColor:kUIColorFromRGB(0xe3e3e3)];
    }
}




- (void)leftAction:(UIBarButtonItem *)sender  {
    
    if (is_questiont) {
        if ([_asquestdelegate respondsToSelector:@selector(reloaddate)]) {
            [_asquestdelegate reloaddate];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitAction:(UIButton *)sender {
    
    is_questiont = YES;
    if (quest_Str.length>200) {
        [self showHint:@"字数不可超过200"];
        return;
    }
    [JXNetworkRequest asyncAskQuestions:quest_Str completed:^(NSDictionary *messagedic) {
        [self showHint:messagedic[@"msg"]];
        if ([_asquestdelegate respondsToSelector:@selector(reloaddate)]) {
            [_asquestdelegate reloaddate];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } statisticsFail:^(NSDictionary *messagedic) {
        
    } fail:^(NSError *error) {
        
    }];
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
    
    self.contentTextView.inputAccessoryView = accessoryView;
    
    
}

- (void)hideKeyboard{
    
    [self.contentTextView resignFirstResponder];
    
    
    
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
