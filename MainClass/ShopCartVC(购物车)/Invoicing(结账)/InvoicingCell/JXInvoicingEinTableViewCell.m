//
//  JXInvoicingEinTableViewCell.m
//  JaneCargo
//
//  Created by 鹏 on 2017/7/31.
//  Copyright © 2017年 鹏. All rights reserved.
//

#import "JXInvoicingEinTableViewCell.h"

@interface JXInvoicingEinTableViewCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *invTextField;

@end

@implementation JXInvoicingEinTableViewCell


+ (instancetype)cellWithTable {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JXInvoicingEinTableViewCell class]) owner:self options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.line setBackgroundColor:kUIColorFromRGB(0xcccccc)];
    self.invTextField.delegate = self;
    [self.invTextField addTarget:self action:@selector(invTextField:) forControlEvents:UIControlEventEditingDidEnd];
    [self sethideKeyBoardAccessoryView];
}

// 
- (void)invTextField:(UITextField *)textField {
    
    if (textField.tag == 2) {
        if ([RegularExpressionsBySyc deptIdInputShouldAlphaNum:textField.text]) {
            
            if ([self.invoicdelegate respondsToSelector:@selector(invoicingText:tag:)]) {
                [self.invoicdelegate invoicingText:textField.text tag:textField.tag];
            }
        }else {
            textField.text = nil;
            if ([self.invoicdelegate respondsToSelector:@selector(idnumberIsWrong)]) {
                [self.invoicdelegate idnumberIsWrong];
            }
            
        }
    }else {
        if ([self.invoicdelegate respondsToSelector:@selector(invoicingText:tag:)]) {
            [self.invoicdelegate invoicingText:textField.text tag:textField.tag];
        }
        
    }
    
}

- (void)setTextTag:(NSInteger)tag {
    self.invTextField.tag = tag;
}
- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}
- (void)setPlaceText:(NSString *)placeText {
    _invTextField.placeholder = placeText;
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
    
    self.invTextField.inputAccessoryView = accessoryView;
    
    
}

- (void)hideKeyboard{
    
    [self.invTextField resignFirstResponder];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
