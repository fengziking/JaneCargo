//
//  JXWithdrawalMoneyTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2018/1/19.
//  Copyright © 2018年 鹏. All rights reserved.
//

#import "JXWithdrawalMoneyTableViewCell.h"

@interface JXWithdrawalMoneyTableViewCell()<UITextFieldDelegate>



@end


@implementation JXWithdrawalMoneyTableViewCell

+ (instancetype)cellwithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXWithdrawalMoneyTableViewCell class]) owner:self options:nil] lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self.layer setBorderWidth:0.5];
    [self.layer setBorderColor:[kUIColorFromRGB(0xe3e3e3) CGColor]];
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    
    _moneytextField.delegate = self;
    self.moneytextField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    [self.moneytextField addTarget:self action:@selector(moneyTextField:) forControlEvents:UIControlEventEditingChanged];
    [self sethideKeyBoardAccessoryView];
}
- (void)moneyTextField:(UITextField *)textField {
    
    
    
    
    _WithdrawalMoney(textField.text);
    
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
    self.moneytextField.inputAccessoryView = accessoryView;
  
}

- (void)hideKeyboard{
    
    [self.moneytextField resignFirstResponder];

}

- (void)setMoneytext:(NSString *)moneytext {
    
    _moneytextField.placeholder = [NSString stringWithFormat:@"你最多可提现金额¥ %@",moneytext];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
