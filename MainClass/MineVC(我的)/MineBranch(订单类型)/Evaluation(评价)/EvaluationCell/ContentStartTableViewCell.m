//
//  ContentStartTableViewCell.m
//  Evaluation
//
//  Created by 鹏 on 2017/9/14.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "ContentStartTableViewCell.h"


@interface ContentStartTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *colorview;


@end

@implementation ContentStartTableViewCell

+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ContentStartTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.colorview setBackgroundColor:kUIColorFromRGB(0xf1f1f1)];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    [_contentTextField addTarget:self action:@selector(evaluationTextField:) forControlEvents:UIControlEventEditingChanged];
    [_contentTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    self.contentTextField.delegate = self;
    [self sethideKeyBoardAccessoryView];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(MineResetPasswordkeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)MineResetPasswordkeyboardWillHide:(NSNotification *)sender {
    
    if ([_refreshdelegate respondsToSelector:@selector(completeInput)]) {
        [_refreshdelegate completeInput];
    }
}
- (void)setContentText:(NSString *)contentText {
    
    [_contentTextField setText:contentText];
}

- (void)evaluationTextField:(UITextField *)textField {
    
    if ([_refreshdelegate respondsToSelector:@selector(refreshtextFieldIndex:text:)]) {
        [_refreshdelegate refreshtextFieldIndex:_indexPath text:textField.text];
    }
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([_refreshdelegate respondsToSelector:@selector(startTypingToEvaluate)]) {
        [_refreshdelegate startTypingToEvaluate];
    }
    
}
/**
 *  键盘添加完成按钮
 */
- (void)sethideKeyBoardAccessoryView{
    
    UIView *accessoryView = [[UIView alloc]init];
    accessoryView.frame = CGRectMake(0, 0, self.frame.size.width, 30);
    accessoryView.backgroundColor = [UIColor colorWithWhite:0.900 alpha:1];
    UIButton *doneBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    doneBtn.frame = CGRectMake(CGRectGetMaxX(accessoryView.bounds) - 50, CGRectGetMinY(accessoryView.bounds), 40,30);
    [doneBtn setTitle:@"完成" forState:(UIControlStateNormal)];
    [doneBtn setTitleColor:[UIColor colorWithRed:236/255.0 green:49/255.0 blue:88/255.0 alpha:1] forState:(UIControlStateNormal)];
    [doneBtn addTarget:self action:@selector(hideKeyboard) forControlEvents:(UIControlEventTouchUpInside)];
    [accessoryView addSubview:doneBtn];
    self.contentTextField.inputAccessoryView = accessoryView;
    
}
- (void)hideKeyboard{
    
    [self.contentTextField resignFirstResponder];
}
@end
