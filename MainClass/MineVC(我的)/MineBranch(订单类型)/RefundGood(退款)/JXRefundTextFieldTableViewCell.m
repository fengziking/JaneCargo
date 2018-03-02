//
//  JXRefundTextFieldTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/8/5.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXRefundTextFieldTableViewCell.h"



@implementation JXRefundTextFieldTableViewCell

+ (instancetype)cellWithTable {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXRefundTextFieldTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.refundTextField.delegate = self;
    [self.refundTextField addTarget:self action:@selector(refundTextField:) forControlEvents:UIControlEventEditingDidEnd];
    [self sethideKeyBoardAccessoryView];
}
- (void)refundTextField:(UITextField *)textField {
    
    if (!kStringIsEmpty(textField.text)) {
        if ([_refundtextdelegate respondsToSelector:@selector(refundTextContent:type:)]) {
            [_refundtextdelegate refundTextContent:textField.text type:_is_type];
        }
    }
}

- (void)setIndex:(NSIndexPath *)index {
    if (index.section == 2) {
        self.refundTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
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
// 代理
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (!_canEditing) {
        return YES;
    }
    return NO;
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
    
    self.refundTextField.inputAccessoryView = accessoryView;
    
    
}

- (void)hideKeyboard{
    
    [self.refundTextField resignFirstResponder];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
